---
name: km-content-extraction/parallel-processing
description: 병렬 입력 처리 — 다중 URL/PDF/파일/Notion/Vault 동시 크롤링 및 에러 처리
---

# 병렬 입력 처리 (Parallel Input Processing)

---

## 개요

다중 소스 입력 시 **병렬 처리**로 속도를 높일 수 있습니다.

## 병렬 처리 조건

```
병렬 처리 가능:
여러 URL 동시 크롤링
여러 Threads/Instagram 포스트 동시 수집
여러 파일 동시 읽기
여러 Notion 페이지 동시 가져오기
여러 검색 쿼리 동시 실행

순차 처리 필요:
단일 브라우저 세션에서 연속 페이지 이동
의존성 있는 데이터 (A 결과로 B 결정)
```

---

## 1. 다중 URL 동시 크롤링

```
시나리오: 사용자가 3개 URL 제공
- https://example1.com/article
- https://threads.net/@user/post/123
- https://example2.com/docs

→ 3개 playwright 호출 병렬 실행:

동일 메시지에서 3개 도구 호출:
1. mcp__playwright__browser_navigate(url="example1.com/...")
2. mcp__playwright__browser_navigate(url="threads.net/...")
3. mcp__playwright__browser_navigate(url="example2.com/...")

각 결과 수집 후 통합 분석
```

---

## 2. PDF 목차 기반 병렬 처리

> 페이지 번호가 아닌 **목차/섹션 구조**에 따라 분할하여 논리적 단위로 처리

```
시나리오: 100페이지 PDF 처리

Step 1: PDF 목차/구조 파악

  a) 목차 페이지 탐색 (보통 1-5페이지)
     - "목차", "Table of Contents", "Contents" 텍스트 검색
     - 페이지 번호가 포함된 목차 구조 파싱

  b) 목차가 없으면 → 헤딩 스캔 (자동 목차 생성)
     - PDF 전체를 빠르게 스캔
     - 큰 제목(H1, H2 수준 폰트)을 찾아 자동 목차 생성
     - 페이지 번호와 제목 매핑

  c) 결과 예시:
     목차 구조:
     - 1. 서론 (페이지 1-10)
     - 2. 방법론 (페이지 11-25)
     - 3. 결과 (페이지 26-50)
     - 4. 결론 (페이지 51-60)
     - 부록 (페이지 61-100)

Step 2: 섹션별 페이지 범위 결정

  목차 → 페이지 범위 매핑:
  - 섹션 1 "서론": 페이지 0-9 (10페이지)
  - 섹션 2 "방법론": 페이지 10-24 (15페이지)
  - 섹션 3 "결과": 페이지 25-49 (25페이지)
  - 섹션 4 "결론": 페이지 50-59 (10페이지)
  - 섹션 5 "부록": 페이지 60-99 (40페이지)

Step 3: 섹션별 병렬 변환 (marker_single)

  동시 실행:
  marker_single "doc.pdf" --page_range "0-9" --output_dir ./section1_서론
  marker_single "doc.pdf" --page_range "10-24" --output_dir ./section2_방법론
  marker_single "doc.pdf" --page_range "25-49" --output_dir ./section3_결과
  marker_single "doc.pdf" --page_range "50-59" --output_dir ./section4_결론
  marker_single "doc.pdf" --page_range "60-99" --output_dir ./section5_부록

Step 4: 결과 통합

  각 섹션 Markdown을 원래 목차 순서로 병합:
  1. 서론.md
  2. 방법론.md
  3. 결과.md
  4. 결론.md
  5. 부록.md

  → 전체 문서 또는 섹션별 개별 노트 생성
```

### 목차 기반 처리의 장점

| 기존 (페이지 청크) | 개선 (목차 기반) |
|-------------------|-----------------|
| 논리적 단위 무시 | 논리적 단위 유지 |
| 문장 중간에서 잘릴 수 있음 | 섹션 완결성 보장 |
| 맥락 손실 가능 | 맥락 보존 |
| 단순 병합만 가능 | 섹션별 분석/노트 가능 |

### 헤딩 스캔 방법 (목차 없는 PDF)

```
헤딩 스캔 로직:

1. PDF 전체 페이지 빠르게 스캔
2. 큰 폰트 사이즈 텍스트 감지 (상위 10%)
3. 패턴 매칭:
   - "1.", "1.1", "Chapter", "Section" 등 번호 패턴
   - 볼드/굵은 텍스트
   - 독립 라인 (문단 시작이 아닌 단독 라인)

4. 자동 목차 구성:
   - 감지된 헤딩들의 페이지 번호 기록
   - 계층 구조 추정 (폰트 크기 기준)
   - 섹션 범위 계산

결과 예시:
자동 생성 목차:
├─ Introduction (p.1)
├─ Literature Review (p.8)
├─ Methodology (p.22)
├─ Results (p.45)
├─ Discussion (p.78)
└─ Conclusion (p.95)
```

---

## 3. 다중 파일 동시 읽기

```
시나리오: 5개 문서 파일 분석 요청

→ 5개 Read 도구 병렬 호출:

동일 메시지에서:
1. Read(file_path="doc1.pdf")
2. Read(file_path="doc2.docx")
3. Read(file_path="doc3.xlsx")
4. Read(file_path="doc4.pptx")
5. Read(file_path="doc5.md")

각 결과 수집 후 통합 분석
```

---

## 4. 다중 Notion 페이지 동시 가져오기

```
시나리오: 관련 Notion 페이지 5개 수집

Step 1: 검색으로 관련 페이지 ID 확보
mcp__notion__API-post-search(query="AI 에이전트")

Step 2: 페이지 내용 병렬 가져오기
동일 메시지에서:
1. mcp__notion__API-get-block-children(block_id="page1_id")
2. mcp__notion__API-get-block-children(block_id="page2_id")
3. mcp__notion__API-get-block-children(block_id="page3_id")
...

Step 3: 결과 통합
```

---

## 5. Vault 검색 병렬화

```
시나리오: 여러 키워드로 관련 노트 검색

→ 여러 검색 쿼리 병렬 실행:

# 1순위: Obsidian CLI search (병렬 Bash 호출)
OBSIDIAN_CLI="/mnt/c/Program Files/Obsidian/Obsidian.com"
동일 메시지에서:
1. "$OBSIDIAN_CLI" search query="AI 에이전트" format=json
2. "$OBSIDIAN_CLI" search query="MCP 프로토콜" format=json
3. "$OBSIDIAN_CLI" search query="프롬프트 엔지니어링" format=json

# CLI 실패 시: Obsidian MCP fallback
1. mcp__obsidian__search_vault(query="AI 에이전트")
2. mcp__obsidian__search_vault(query="MCP 프로토콜")
3. mcp__obsidian__search_vault(query="프롬프트 엔지니어링")

결과 병합 후 중복 제거
→ CLI read 루프 또는 mcp__obsidian__read_multiple_notes로 일괄 읽기
```

---

## 에러 처리

```
병렬 처리 중 일부 실패 시:

원칙: 실패한 항목만 건너뛰고 나머지 계속 진행

예시:
- URL 3개 중 1개 실패 → 2개 결과로 진행
- PDF 섹션 5개 중 1개 실패 → 4개 섹션 결과 + 실패 섹션 재시도 또는 스킵

사용자 보고:
"3개 URL 중 2개 성공, 1개 실패 (example.com - 접근 불가)
성공한 2개 콘텐츠로 분석을 진행합니다."
```

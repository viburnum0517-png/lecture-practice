# km-export-formats: 기타 포맷 + 병렬 처리 상세

> 참조 문서: Markdown/PDF/블로그/다이어그램 내보내기 + 병렬 출력 처리 + 스킬 조합 예시

---

## 병렬 출력 처리 (Parallel Output)

> 여러 형식/문서를 **동시에** 생성하여 내보내기 속도 향상

### A. 다중 형식 동시 출력

하나의 콘텐츠를 Obsidian + Notion + 기타 형식으로 동시 저장:

```
시나리오: 웹 콘텐츠 → Obsidian + Notion 동시 저장

Step 1: 콘텐츠 준비 (공통)
  - 콘텐츠 분석 완료
  - Obsidian용 마크다운 준비
  - Notion용 블록 구조 준비

Step 2: 병렬 저장 (동시 실행!)
  같은 응답에서 두 도구 호출:

  [도구 1] Bash (Obsidian CLI — Tier 1)
    "/mnt/c/Program Files/Obsidian/Obsidian.com" create path="Library/Zettelkasten/AI-연구/주제.md" content="[Obsidian 마크다운]"
    CLI 실패 시: mcp__obsidian__create_note (Tier 2) → Write (Tier 3)

  [도구 2] Bash (Notion curl 호출) ⚠️ MCP 도구 사용 금지!
    → "references/notion.md"의 "Notion 저장 (PowerShell 직접 호출)" 섹션 참조

  → 두 작업이 동시에 실행됨!

Step 3: 결과 통합 보고
  - Obsidian: [경로] 저장 완료
  - Notion: [URL] 페이지 생성 완료
```

### B. 단일 형식 다중 문서

같은 형식으로 여러 문서를 동시 생성:

```
시나리오: 5개 Zettelkasten 노트 동시 생성

Step 1: 각 노트 콘텐츠 사전 준비
  - note_1: 개념 A 노트 내용
  - note_2: 개념 B 노트 내용
  - note_3: 개념 C 노트 내용
  - note_4: 개념 D 노트 내용
  - note_5: 개념 E 노트 내용

Step 2: 병렬 저장 (5개 동시 실행!)
  같은 응답에서 5개 도구 호출:

  [도구 1] mcp__obsidian__create_note
    path: "Library/Zettelkasten/AI-연구/개념A.md"

  [도구 2] mcp__obsidian__create_note
    path: "Library/Zettelkasten/AI-연구/개념B.md"

  [도구 3] mcp__obsidian__create_note
    path: "Library/Zettelkasten/AI-연구/개념C.md"

  [도구 4] mcp__obsidian__create_note
    path: "Library/Zettelkasten/AI-연구/개념D.md"

  [도구 5] mcp__obsidian__create_note
    path: "Library/Zettelkasten/AI-연구/개념E.md"

Step 3: 결과 보고
  ✅ 5개 노트 생성 완료
  - 개념A.md
  - 개념B.md
  - 개념C.md
  - 개념D.md
  - 개념E.md
```

### D. 의존성 처리 규칙

```
병렬 가능 (동시 실행):
├── Obsidian 노트 A + Obsidian 노트 B
├── Obsidian 노트 + Notion 페이지
├── 다이어그램 + 텍스트 노트
└── PDF 생성 + Markdown 저장

순차 필수 (의존성):
├── 폴더 생성 → 해당 폴더에 파일 저장
├── 메인 노트 생성 → MOC에 링크 추가
├── Notion 페이지 생성 → 블록 추가 (patch-block-children)
└── 다이어그램 생성 → 노트에 임베드 링크 추가
```

### E. 에러 핸들링

```
일부 실패 시 처리:

1. 실패한 항목 기록
2. 성공한 항목은 정상 보고
3. 실패 원인 분석 및 안내
4. 재시도 옵션 제공

예시 보고:
  ✅ 성공: 노트A.md, 노트B.md, 노트C.md
  ❌ 실패: 노트D.md (경로 오류)
  ⚠️ 재시도 필요: 노트D.md

  실패 원인: 폴더 "XYZ/"가 존재하지 않음
  해결 방법: 폴더 생성 후 재시도
```

### F. 병렬 출력 예시 템플릿

```
## 다중 형식 내보내기 완료!

### 생성된 파일
| 플랫폼 | 경로/URL | 상태 |
|--------|----------|------|
| Obsidian | Library/Zettelkasten/AI-연구/주제.md | ✅ |
| Notion | notion.so/page/xxx | ✅ |
| PDF | exports/주제.pdf | ✅ |

### 처리 방식
- 병렬 처리: 3개 형식 동시 생성
- 소요 시간: ~2초 (순차 대비 ~66% 단축)
```

---

## 5C. 표준 Markdown 내보내기

### 생성 절차

```
Step 1: 클린 마크다운으로 변환
  - Obsidian 전용 문법 제거
  - [[wikilinks]] → [일반 링크](path) 변환
  - 표준 마크다운 포맷팅

Step 2: 지정 위치에 저장
  - 출력 디렉토리 확인
  - 파일명: [title].md
  - 프론트매터 포함 (선택적)

Step 3: 파일 경로 보고
  - 저장된 경로 안내
  - 추가 작업 안내
```

---

## 5D. PDF 내보내기

### 사용 스킬
`pdf.md` 참조 (reportlab)

### 생성 절차

```
Step 1: PDF용 콘텐츠 포맷팅
  - 타이틀 페이지 추가
  - 헤딩 계층적 포맷팅
  - 메타데이터 푸터 포함

Step 2: 마크다운 → PDF 변환
  - reportlab 또는 pandoc 사용
  - 스타일링 적용
  - 페이지 레이아웃 설정

Step 3: PDF 파일 저장
  - 출력 위치 확인
  - 파일명: [title].pdf

Step 4: 파일 경로 보고
```

---

## 5E. 블로그 플랫폼 내보내기

### Medium 형식

```
Step 1: Medium 호환 포맷팅
  - YAML 프론트매터 제거
  - Medium 호환 마크다운으로 변환
  - 이미지 참조 최적화
  - 코드 블록 포맷팅

Step 2: 내보내기 파일 생성
  - 포맷된 콘텐츠 저장
  - 게시 지침 포함

Step 3: 게시 가이드 제공
  - 복사-붙여넣기 지침
  - 이미지 업로드 안내
  - 태그/토픽 추천
```

### WordPress 형식

```
Step 1: WordPress 호환 포맷팅
  - HTML 변환
  - WordPress 숏코드 적용
  - 특성 이미지 지원

Step 2: 내보내기 파일 생성
  - HTML 파일 저장
  - 옵션: XML 내보내기

Step 3: 게시 가이드 제공
  - 대시보드 게시 방법
  - 미디어 업로드 안내
  - SEO 최적화 팁
```

---

## 5F. 다이어그램 내보내기

### 사용 스킬
`drawio-diagram.md` 참조

### 생성 절차

```
Step 1: 세션 시작
  mcp__drawio__start_session
  - 브라우저에서 실시간 프리뷰 열림 (port 6002-6020)

Step 2: 콘텐츠에서 다이어그램 구조 분석
  - 추출된 콘텐츠에서 다이어그램 요소 식별
  - 노드 (개념, 엔티티, 컴포넌트)
  - 연결 (관계, 흐름, 의존성)
  - 그룹/레이어 (분류, 계층)

Step 3: 다이어그램 생성
  mcp__drawio__create_new_diagram
  - 자연어 설명 또는 mxGraphModel XML 입력
  - 다이어그램 유형에 맞는 레이아웃 적용

Step 4: 사용자와 반복 (선택적)
  - 브라우저에서 프리뷰 확인
  - 사용자 수정 요청 반영
  mcp__drawio__edit_diagram  # 수정용

Step 5: 내보내기 및 저장
  mcp__drawio__export_diagram
  - 저장 경로: [관련노트폴더]/[주제]-diagram-[YYYY-MM-DD].drawio
  - 예: Library/Zettelkasten/AI-연구/MCP-Architecture-diagram-2025-01-02.drawio
  - CRITICAL: vault root 기준 상대경로 (Second_Brain/ 접두사 금지!)

Step 6: 노트에 링크 추가
  관련 노트에 다이어그램 참조:

  ## 시각화
  ![[주제-diagram-2025-01-02.drawio]]
  *다이어그램: [설명]*

  또는 독립 다이어그램 노트 생성 (type: diagram)
```

### 다이어그램 유형별 가이드

| 유형 | 용도 | 요소 |
|------|------|------|
| Flowchart | 프로세스, 워크플로우, 의사결정 | 시작/끝, 프로세스, 판단, 화살표 |
| Architecture | 시스템 구조, 컴포넌트 관계 | 컴포넌트, 레이어, 연결선 |
| Mind Map | 개념 관계, 지식 계층 | 중심 주제, 분기, 하위 개념 |
| Sequence | API 흐름, 상호작용 | 액터, 생명선, 메시지 |
| ERD | 데이터베이스 스키마 | 엔티티, 속성, 관계 |

---

## 파일 저장 필수 프로토콜

### CRITICAL: 반드시 도구 호출!

노트/파일 생성 시 JSON 출력만 하고 끝내면 **절대 안 됩니다!**

### ✅ 필수 패턴 (3-Tier)

```
// Tier 1: Obsidian CLI (최우선):
Bash: "/mnt/c/Program Files/Obsidian/Obsidian.com" create path="Library/Research/note.md" content="..."

// CLI 실패 시 Tier 2: Obsidian MCP:
mcp__obsidian__create_note(path="Library/Research/note.md", content="...")

// MCP 실패 시 Tier 3: Write 도구:
Write(file_path="C:\...\Second_Brain\Research\note.md", content="...")
```

### ❌ 금지 패턴

```json
// 이렇게 하면 실제 저장 안 됨!
{
  "path": "Research/note.md",
  "content": "..."
}
```

### 저장 후 검증

```
1. 저장 도구 호출 (CLI → create_note → Write 순서)
2. 결과 확인 - CLI exit 0 / "created successfully" / 성공 메시지
3. 실패 시 다음 Tier로 폴백
4. 절대 JSON 출력만 하고 끝내지 말 것!
```

---

## 스킬 조합 예시

### 예시 1: PDF → Obsidian + Notion

```
1. marker_single로 PDF → Markdown 변환 (토큰 절감!)
2. Markdown 파일 읽기 및 분석
3. zettelkasten-note로 Obsidian 노트 생성
4. notion-knowledge-capture로 Notion 페이지 생성
```

### 예시 2: 웹 콘텐츠 → 노트 + 다이어그램

```
1. playwright로 웹 콘텐츠 추출
2. 시스템 컴포넌트/프로세스 감지
3. zettelkasten-note로 노트 생성
4. drawio-diagram으로 아키텍처/플로우차트 생성
5. 노트에 다이어그램 참조 링크 추가
```

### 예시 3: Excel 분석 → 리포트 + PDF

```
1. xlsx 스킬로 데이터 분석
2. 트렌드 및 인사이트 도출
3. 분석 노트 생성
4. pdf 스킬로 PDF 리포트 생성
```

### 예시 4: Notion 리서치 → 다중 포맷

```
1. notion-research-documentation으로 리서치 수행
2. 종합 문서 생성
3. Obsidian 노트로 저장
4. pdf 스킬로 PDF 버전 생성
5. pptx 스킬로 요약 프레젠테이션 생성
```

---
name: km-workflow
description: Use when needing Knowledge Manager 핵심 워크플로우. 5-Phase 처리 파이프라인 (수집→분석→변환→저장→연결) 전체 절차.
---

# Knowledge Manager 워크플로우 스킬

> Knowledge Manager 에이전트의 6단계 워크플로우 정의

---

## 🚨 CRITICAL PHASES (필수 도구 호출!)

다음 Phase에서는 반드시 도구를 실제로 호출해야 합니다:

| Phase | 필수 행동 | 절대 금지 |
|-------|----------|----------|
| **Phase 2: 콘텐츠 추출** | `scrapling-crawl.py` 또는 `playwright` 도구 호출하여 실제 크롤링 | 도구 없이 추측 |
| **Phase 5: 내보내기** | `create_note` 또는 `Write` 도구 호출 | JSON만 출력 |

⚠️ **Phase 2/5에서 도구 호출 없이 다음 단계 진행 금지!**

---

## 워크플로우 개요

```
Phase 0: 환경 감지 (→ km-environment-detection.md) ⭐ NEW
    ↓
Phase 1: 입력 소스 감지
    ↓
Phase 1.5: 사용자 선호도 수집
    ↓
★ 병렬 검색 자동 구성 (복잡도 판정 → 병렬 Task 또는 Agent Teams)
    ↓
Phase 2: 콘텐츠 추출 (→ km-content-extraction.md) [병렬 실행]
    ↓
Phase 3: 콘텐츠 분석 [결과 통합]
    ↓
Phase 3.5: 시각화 기회 감지
    ↓
Phase 4: 출력 형식 선택
    ↓
Phase 5: 내보내기 실행 (→ km-export-formats.md) [Main 직접 실행]
    ↓
Phase 5.25: 이미지 저장 + 임베딩 (→ km-image-pipeline.md) [Main 직접 실행]
    ↓
Phase 5.5: 연결 강화 (→ km-link-strengthening.md) [Main 직접 실행]
    ↓
Phase 6: 검증 및 보고 [Main 통합 검증]
```

---

## Phase 0: 환경 감지 ⭐ NEW

**상세 내용**: `km-environment-detection.md` 및 `references/phase-1-collection.md` 참조

| 조건 | 동작 |
|------|------|
| **첫 실행** | 전체 감지 프로세스 (스펙 → 티어 → 안내 → 활성화 제안) |
| **이후 실행** | 현재 설정 요약만 표시 (1줄) |
| **"환경 감지" 키워드** | 전체 프로세스 재실행 |
| **"GraphRAG", "그래프 구축" 키워드** | Mode G (km-graphrag-workflow.md Phase G0-G6) |

**환경별 병렬화 방법:**

| 환경 | 실행 모드 | 병렬화 방법 |
|------|----------|-----------|
| **터미널 CLI** | Agent Teams | Teammate 생성 + Mailbox 통신 |
| **VS Code / SDK** | 병렬 Task 서브에이전트 | Task 도구 병렬 호출 (쓰기는 Main만) |

> See `references/phase-1-collection.md` for GraphRAG 팀 구성, 복잡도 판정, 모드 A/B 상세

---

## Phase 1: 입력 소스 감지

```
URL → threads.net/* / instagram.com/* → km-social-media.md ⭐
URL → notion.so/* → Notion Import
URL → 기타 → Web Crawling (playwright MCP)
File → .pdf → Marker 우선
File → .docx/.xlsx/.pptx/.txt/.md → 해당 스킬
"종합"/"synthesize" 키워드 → Vault Synthesis
일반 텍스트 → Direct Text Processing
```

> See `references/phase-1-collection.md` for 입력 유형 분류 상세 + 소셜 미디어 패턴

---

## Phase 1.5: 사용자 선호도 수집

**CRITICAL**: 콘텐츠 추출 전 반드시 사용자 선호도 확인

### 기본값 (사용자가 "기본" 또는 스킵 시)

| 항목 | 기본값 |
|------|--------|
| Detail Level | 3 (상세) |
| Focus Area | E (전체) |
| Note Structure | ④ (3-tier) |
| Connection Level | 최대 |

### 퀵 프리셋

| 사용자 표현 | 프리셋 |
|------------|--------|
| "빠르게", "간단히" | 1, E, ①, 최소 |
| "꼼꼼히", "자세히" | 3, E, ③, 최대 |
| "실무용", "실용적으로" | 2, B+C, ②, 보통 |
| "공부용", "학습용" | 3, A+D, ③, 최대 |
| "레퍼런스", "참고용" | 2, C, ①, 보통 |
| **"상세하게", "체계적으로"** | **3, E, ④, 최대** ⭐ |
| **"연구보고서", "논문정리"** | **3, A+D, ④, 최대** ⭐ |

> See `references/phase-1-collection.md` for 선호도 질문 프롬프트 전체 + 옵션 상세

---

## Phase 2: 콘텐츠 추출 (🚨 MANDATORY TOOL CALLS!)

**상세 내용**: `km-content-extraction.md` 참조

```
❌ 도구 호출 없이 콘텐츠 추측 금지
❌ 이전 대화 기억에만 의존 금지
✅ 반드시 아래 도구 중 하나를 실제로 호출!
```

| 소스 유형 | 🚨 필수 도구 호출 |
|----------|------------------|
| **소셜 미디어 (Threads/Instagram)** | `mcp__playwright__browser_navigate` → `wait_for` → `snapshot` ⭐ |
| **일반 웹 페이지** | `mcp__playwright__browser_navigate` → `snapshot` |
| PDF | `marker_single` 또는 `Read` |
| DOCX/TXT/MD | `Read` 도구 |
| Excel/CSV | `Read` 도구 |
| Notion | `mcp__notion__API-get-block-children` |
| Vault 종합 | CLI search → `mcp__obsidian__search_vault` 폴백 |

> See `references/phase-1-collection.md` for Phase 2 완료 검증 체크리스트

---

## Phase 3: 콘텐츠 분석

Phase 1.5 선호도에 따라 분석 수행. 상세 수준(1-3), 중점 영역(A-E), 노트 구조(①-④) 적용.

**노트 구조 ④ 3-tier (권장):**
```
Library/Research/[프로젝트명]/
├── [제목]-MOC.md                    ← 메인 MOC
├── 01-[챕터1명]/
│   ├── [챕터1]-MOC.md               ← 카테고리 MOC
│   └── [원자노트N].md               ← 원자적 노트들
└── 02-[챕터2명]/...
```

> See `references/phase-2-analysis.md` for 상세 수준별 처리, 중점 영역별 처리, 노트 구조 상세

---

## Phase 3.5: 시각화 기회 감지

| 콘텐츠 패턴 | 추천 다이어그램 |
|------------|----------------|
| 3단계 이상 순차 프로세스 | Flowchart |
| 3개 이상 시스템 컴포넌트 | Architecture Diagram |
| 계층적 개념 구조 | Mind Map |
| API/통신 흐름 | Sequence Diagram |

> See `references/phase-2-analysis.md` for 자동 감지 프롬프트, 명시적 요청 감지 상세

---

## Phase 4: 출력 형식 선택

| 형식 | 사용 스킬 |
|------|----------|
| Obsidian | zettelkasten-note |
| Notion | notion-knowledge-capture |
| PDF | pdf 스킬 (reportlab) |
| 다이어그램 | drawio-diagram |

> See `references/phase-2-analysis.md` for 출력 형식 선택 프롬프트 전체

---

## Phase 5: 내보내기 실행 (🚨 MANDATORY TOOL CALLS!)

**상세 내용**: `km-export-formats/SKILL.md` 참조

```
❌ JSON 형식으로 출력만 하고 끝내기 금지
❌ "저장하겠습니다"라고만 말하고 실제 저장 안 함 금지
✅ 반드시 저장 도구를 실제로 호출!
```

### 저장 경로 결정 (CRITICAL — 파일 저장 전 필수!)

```
Q: "이 콘텐츠의 원저자가 tofukyung(김재경)인가?"

YES → Mine/ 하위:
  - 얼룩소 원문           → Mine/얼룩소/
  - @tofukyung Threads    → Mine/Threads/
  - 강의 자료             → Mine/Lectures/
  - 에세이/분석/에버그린  → Mine/Essays/
  - 업무 산출물 (CV 등)   → Mine/Projects/

NO → Library/ 하위 (기본):
  - YouTube/웹 정리       → Library/Zettelkasten/{적절한 주제폴더}/
  - 대규모 리서치 (3-tier) → Library/Research/{프로젝트명}/
  - 외부 Threads          → Library/Threads/
  - 학술 논문             → Library/Papers/
  - 웹 클리핑/가이드      → Library/Clippings/
```

**판별 시그널**: author=tofukyung/김재경, source에 @tofukyung, tags에 tofukyung → Mine/. 그 외 → Library/.

> **3-Tier 저장 프로토콜 상세**: `km-export-formats/SKILL.md` 참조 (Obsidian CLI → MCP → Write 폴백)
> See `references/phase-3-5-transform-save-link.md` for 절대 금지 패턴, Phase 5 완료 검증 체크리스트 상세

---

## Phase 5.25: 이미지 저장 + 임베딩

**상세 내용**: `km-image-pipeline.md` 참조

| 조건 | 동작 |
|------|------|
| image_extraction = true | 전체 이미지 추출+저장 |
| image_extraction = "auto" (기본) | 차트/다이어그램만, 개수 제한 |
| image_extraction = false | 스킵 |

> See `references/phase-3-5-transform-save-link.md` for 단일/AT 모드 워크플로우 상세

---

## Phase 5.5: 연결 강화 ⭐ NEW

**CRITICAL**: 노트 생성 후 반드시 연결 강화 실행

| 조건 | 설명 |
|------|------|
| Obsidian 노트 생성 완료 시 | 자동으로 연결 강화 실행 |
| 사용자 연결 수준 "보통"/"최대" | 기본 활성화 |
| 사용자 연결 수준 "최소" | 스킵 (태그만 추가) |

**관련성 점수 기준:**

| 기준 | 점수 |
|------|------|
| 제목 키워드 일치 | +3 |
| 태그 일치 | +2 |
| 동일 폴더 | +2 |
| 본문 키워드 일치 | +1 |

임계값: 3점 이상인 노트만 연결

> See `references/phase-3-5-transform-save-link.md` for 6단계 연결 강화 워크플로우 상세

---

## Phase 6: 검증 및 보고

```
□ 콘텐츠가 정확하게 추출되었는가?
□ 원자적 아이디어가 적절히 식별되었는가?
□ 메타데이터가 완전하고 정확한가?
□ 기존 노트와의 연결이 발견되었는가?
□ 출력 형식이 사용자 선호도와 일치하는가?
□ 파일이 올바른 위치에 저장되었는가?
□ CLI, mcp__obsidian__create_note, 또는 Write 도구를 실제로 호출했는가?
□ JSON 출력만 하고 끝내지 않았는가?
```

> See `references/phase-3-5-transform-save-link.md` for 보고 구조 템플릿, 에러 처리 전략 상세

---

## 에러 처리 전략 (요약)

```
1차 시도: 기본 방법
   ↓ 실패
2차 시도: 대안 방법
   ↓ 실패
3차 시도: raw 콘텐츠 저장
   ↓ 실패
→ 사용자에게 이슈 보고
```

| 에러 유형 | 대응 |
|----------|------|
| 웹 크롤링 실패 | 재시도, 스텔스 모드, 사용자 안내 |
| 파일 없음 | 정확한 경로 요청 |
| 지원 안 되는 형식 | 한계 설명, 대안 제안 |
| PDF 생성 실패 | Markdown으로 폴백 |

---

## 스킬 참조

- **km-environment-detection.md**: 환경 감지 + RAG 최적화 (Phase 0) ⭐ NEW
- **km-graphrag-workflow.md**: GraphRAG 구축 워크플로우 (Mode G, Phase G0-G6)
- **km-graphrag-ontology.md**: GraphRAG 온톨로지 설계 (Mode G, Phase G1)
- **km-graphrag-search.md**: GraphRAG 검색 쿼리 (Mode G, Phase G4-G5)
- **km-graphrag-report.md**: GraphRAG 인사이트 리포트 (Mode G, Phase G5)
- **km-graphrag-sync.md**: GraphRAG Frontmatter 동기화 (Mode G, Phase G0/G6)
- **km-social-media.md**: 소셜 미디어 스크래핑 (Phase 1, 2)
- **km-content-extraction.md**: 콘텐츠 추출 상세 (Phase 2)
- **km-export-formats/SKILL.md**: 출력 형식 상세 (Phase 5)
- **km-image-pipeline.md**: 이미지 저장 + 임베딩 (Phase 5.25)
- **km-link-strengthening.md**: 연결 강화 (Phase 5.5)
- **km-link-audit.md**: 연결 감사 (수동 실행)
- **zettelkasten-note.md**: Obsidian 노트 형식
- **drawio-diagram.md**: 다이어그램 생성
- **pdf.md, xlsx.md, docx.md, pptx.md**: 문서 처리
- **notion-*.md**: Notion 연동

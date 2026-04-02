# km-export-formats: Obsidian 저장 절차 상세

> 참조 문서: Obsidian Zettelkasten + 3-Tier 계층 내보내기 상세

---

## 5A. Obsidian (Zettelkasten) 내보내기

### 사용 스킬
`zettelkasten-note.md` 참조

### 생성 절차

```
Step 1: 노트 ID 생성
  - 형식: YYYYMMDDHHmm
  - 예: 202601031430

Step 2: YAML 프론트매터 생성
  ---
  id: [타임스탬프]
  title: [노트 제목]
  category: [카테고리]
  tags: [tag1, tag2, ...]
  created: YYYY-MM-DD
  source: [원본 소스]
  ---

Step 3: 콘텐츠 구조화
  # [제목]

  ## 핵심 개념
  [원자적 아이디어 설명]

  ## 상세 설명
  [상세 설명]

  ## 연결된 개념
  - [[관련-노트-1]]
  - [[관련-노트-2]]

  ## 참고문헌
  [소스 정보]

Step 3.5: 이미지 저장 및 임베딩 (이미지 추출 활성 시)
  - 참조 스킬: km-image-pipeline.md
  - 디렉토리 생성:
    Bash: mkdir -p /mnt/c/Users/treyl/Documents/Obsidian/Second_Brain/Resources/images/{topic-folder}/
  - 웹 이미지 다운로드:
    Bash: curl -sLo "/mnt/c/Users/treyl/Documents/Obsidian/Second_Brain/Resources/images/{topic-folder}/{NN}-{descriptive-name}.{ext}" "{url}"
  - PDF 이미지 복사:
    Bash: cp km-temp/{name}/images/{file} "/mnt/c/Users/treyl/Documents/Obsidian/Second_Brain/Resources/images/{topic-folder}/{NN}-{descriptive-name}.{ext}"
  - 다운로드 실패(403/404) 시 Playwright 스크린샷 폴백:
    mcp__playwright__browser_take_screenshot({ ref: "{element-ref}", filename: "{path}" })
  - 노트 콘텐츠에 임베드 구문 삽입 (본문 흐름 배치):
    개념 설명 → (빈 줄) → ![[Resources/images/{topic-folder}/{filename}]] → (빈 줄) → 상세 설명
  - 검증: Glob("Second_Brain/Resources/images/{topic-folder}/*") → 파일 존재 확인

Step 4: Vault에 저장
  - 경로: Library/Zettelkasten/[category]/[title] - YYYY-MM-DD-HHmm.md
  - CRITICAL: vault root가 이미 Second_Brain 폴더
  - "Second_Brain/" 접두사 절대 사용 금지!
  - Obsidian MCP 또는 Write 도구 사용
```

### 경로 규칙

```
✅ 올바른 경로:
   Library/Zettelkasten/AI-연구/노트제목 - 2026-01-03-1430.md
   Library/Research/연구문서.md
   Mine/Threads/스레드-정리.md  (tofukyung 작성 시)
   Library/Threads/스레드-정리.md  (외부 자료 시)

❌ 잘못된 경로 (중첩 폴더 생성됨!):
   Second_Brain/Library/Zettelkasten/AI-연구/...
   Second_Brain/Research/...
```

### 저장 도구 호출 (3-Tier)

```
Tier 1: Obsidian CLI (최우선)
Bash: "/mnt/c/Program Files/Obsidian/Obsidian.com" create path="Library/Zettelkasten/AI-연구/노트제목 - 2026-01-03-1430.md" content="[전체 노트 내용]"

CLI 실패 시:
Tier 2: Obsidian MCP
mcp__obsidian__create_note
- path: "Library/Zettelkasten/AI-연구/노트제목 - 2026-01-03-1430.md"
- content: "[전체 노트 내용]"

MCP 실패 시:
Tier 3: Write 도구
Write
- file_path: "C:\Users\treyl\Documents\Obsidian\Second_Brain\Zettelkasten\AI-연구\노트제목 - 2026-01-03-1430.md"
- content: "[전체 노트 내용]"
```

---

## 3-Tier 계층적 내보내기 ⭐ NEW

대용량 문서(연구보고서, 논문, 책)를 체계적으로 정리하는 3단계 계층 구조입니다.

### 구조 개요

```
Research/[프로젝트명]/
├── [제목]-MOC.md                    ← 레벨 1: 메인 MOC
│
├── 01-[챕터1명]/
│   ├── [챕터1]-MOC.md               ← 레벨 2: 카테고리 MOC
│   ├── [원자노트1].md               ← 레벨 3: 원자적 노트
│   ├── [원자노트2].md
│   └── [원자노트3].md
│
├── 02-[챕터2명]/
│   ├── [챕터2]-MOC.md
│   ├── [원자노트4].md
│   └── [원자노트5].md
│
└── ... (추가 챕터)
```

### 생성 워크플로우 (CRITICAL)

**Phase 1: 문서 구조 분석**
```
1. 전체 문서 읽기
2. 챕터/섹션 구조 파악
3. 각 챕터별 핵심 개념 추출
4. 폴더 구조 계획 수립
```

**Phase 2: 원자적 노트 생성 (Bottom-Up)**
```
각 챕터별로:
1. 핵심 개념 목록화 (개념당 1노트)
2. 원자적 노트 생성 (병렬 처리 가능)
3. 노트 간 wikilinks 추가
```

**Phase 3: 카테고리 MOC 생성 (각 챕터당 1개)**
```
각 챕터별로:
1. 챕터 개요 작성
2. 해당 챕터의 원자 노트들 링크
3. 핵심 발견사항 요약
```

**Phase 4: 메인 MOC 생성**
```
1. 문서 전체 개요
2. 모든 카테고리 MOC 링크
3. 주요 발견/인사이트 요약
4. 메타데이터 (출처, 날짜 등)
```

### 노트 템플릿

#### 레벨 1: 메인 MOC

```markdown
---
created: YYYY-MM-DDTHH:mm:ss
tags: [MOC, 주제, 연구보고서]
type: main-moc
source: [원본 출처]
---

# [문서제목] - MOC

## 개요
[문서 전체 요약 2-3문단]

## 핵심 발견
1. [발견 1]
2. [발견 2]
3. [발견 3]

## 챕터별 정리

### 1. [[챕터1-MOC|챕터1 제목]]
[챕터1 한줄 요약]

### 2. [[챕터2-MOC|챕터2 제목]]
[챕터2 한줄 요약]

### 3. [[챕터3-MOC|챕터3 제목]]
[챕터3 한줄 요약]

## 메타데이터
- **출처**: [URL/파일명]
- **발행일**: YYYY-MM-DD
- **저자/기관**: [저자명]
- **정리일**: YYYY-MM-DD

---

## 📍 네비게이션

### 현재 위치
```
📚 [문서제목] ← 현재 보고 있는 문서
```

### 전체 목차
| # | 챕터 | 노트 수 |
|---|------|---------|
| 1 | [[01-챕터명/챕터1-MOC\|챕터1]] | N개 |
| 2 | [[02-챕터명/챕터2-MOC\|챕터2]] | N개 |
| 3 | [[03-챕터명/챕터3-MOC\|챕터3]] | N개 |
```

#### 레벨 2: 카테고리 MOC

```markdown
---
created: YYYY-MM-DDTHH:mm:ss
tags: [MOC, 주제, 챕터명]
type: category-moc
parent: "[[메인-MOC]]"
chapter: N
---

# [챕터제목] - MOC

## 개요
[챕터 요약 1-2문단]

## 핵심 내용

### [[원자노트1]]
[한줄 요약]

### [[원자노트2]]
[한줄 요약]

### [[원자노트3]]
[한줄 요약]

## 주요 데이터/통계
[해당 챕터의 핵심 수치]

## 관련 노트
- [[다른챕터-MOC]] - [연결 이유]

---

## 📍 네비게이션

### 현재 위치
```
📚 [[메인-MOC|문서제목]]
  └── 📂 [현재 챕터명] ← 현재 위치
```

### 이 챕터의 노트
| # | 노트 | 요약 |
|---|------|------|
| 1 | [[원자노트1]] | 요약 |
| 2 | [[원자노트2]] | 요약 |
| 3 | [[원자노트3]] | 요약 |

### 전체 목차
| # | 챕터 | 현재 |
|---|------|------|
| 1 | [[챕터1-MOC\|챕터1]] | ✅ |
| 2 | [[챕터2-MOC\|챕터2]] | ⬜ |
| 3 | [[챕터3-MOC\|챕터3]] | ⬜ |

---
← [[메인-MOC|메인으로]]
```

#### 레벨 3: 원자적 노트

```markdown
---
created: YYYY-MM-DDTHH:mm:ss
tags: [주제, 키워드1, 키워드2]
type: atomic
parent: "[[챕터-MOC]]"
source: [원본 출처]
chapter: N
---

# [개념 제목]

## 핵심 내용
[2-3문장으로 핵심 설명]

## 상세 설명
[필요시 추가 설명]

## 데이터/근거
[통계, 인용, 차트 등]

## 관련 노트
- [[관련노트1]] - [연결 이유]
- [[관련노트2]] - [연결 이유]

---

## 📍 네비게이션

### 현재 위치
```
📚 [[메인-MOC|문서제목]]
  └── 📂 [[챕터-MOC|챕터명]]
        └── 📄 [현재 노트] ← 현재 위치
```

### 같은 챕터의 노트
| # | 노트 | 현재 |
|---|------|------|
| 1 | [[노트1]] | ⬜ |
| 2 | [[노트2]] | ✅ |
| 3 | [[노트3]] | ⬜ |

### 전체 목차
| # | 챕터 | 현재 |
|---|------|------|
| 1 | [[챕터1-MOC\|챕터1]] | ✅ |
| 2 | [[챕터2-MOC\|챕터2]] | ⬜ |
| 3 | [[챕터3-MOC\|챕터3]] | ⬜ |

---
← [[챕터-MOC|챕터로]] | [[메인-MOC|메인으로]]
```

### 병렬 생성 전략

```
Step 1: 모든 원자 노트 병렬 생성 (N개 동시)
  [도구 1] Bash: "/mnt/c/Program Files/Obsidian/Obsidian.com" create path="..." content="..." (원자노트1)
  [도구 2] Bash: "/mnt/c/Program Files/Obsidian/Obsidian.com" create path="..." content="..." (원자노트2)
  [도구 3] Bash: "/mnt/c/Program Files/Obsidian/Obsidian.com" create path="..." content="..." (원자노트3)
  ... (최대 10개 병렬)
  CLI 실패 시: mcp__obsidian__create_note (Tier 2) → Write (Tier 3)

Step 2: 모든 카테고리 MOC 병렬 생성
  [도구 1] Bash: CLI create (챕터1-MOC)
  [도구 2] Bash: CLI create (챕터2-MOC)
  ... (챕터 수만큼)

Step 3: 메인 MOC 생성
  [도구 1] Bash: CLI create (메인-MOC)
```

### 파일명 규칙

| 레벨 | 파일명 패턴 | 예시 |
|------|-------------|------|
| 메인 MOC | `[제목]-MOC.md` | `Our-Life-with-AI-2026-MOC.md` |
| 카테고리 MOC | `[챕터명]-MOC.md` | `AI-채택-현황-MOC.md` |
| 원자 노트 | `[개념명].md` | `AI-채택률-2023-2025-추이.md` |

### 폴더명 규칙

```
[NN]-[챕터명]/

예시:
01-채택현황/
02-교육학습/
03-인식태도/
04-사회적영향/
05-거버넌스신뢰/
```

### 검증 체크리스트

```
□ 모든 원자 노트가 생성되었는가?
□ 각 카테고리 MOC가 해당 원자 노트를 링크하는가?
□ 메인 MOC가 모든 카테고리 MOC를 링크하는가?
□ 양방향 링크 (parent 필드)가 설정되었는가?
□ 폴더 구조가 올바른가?
□ 태그가 일관성 있게 적용되었는가?
□ 네비게이션 푸터가 모든 노트에 포함되었는가? ⭐
```

---

## 네비게이션 푸터 (MANDATORY) ⭐ NEW

**모든 형식(Obsidian, Notion, Markdown 등)에 필수 적용**

### 목적
- 현재 읽고 있는 위치를 명확히 표시
- 같은 챕터의 다른 노트로 쉽게 이동
- 전체 문서 구조를 한눈에 파악

### 네비게이션 푸터 구조

```markdown
---

## 📍 네비게이션

### 현재 위치
```
📚 [[메인-MOC|문서제목]]
  └── 📂 [[챕터-MOC|현재 챕터명]]
        └── 📄 [현재 노트 제목] ← 현재 위치
```

### 같은 챕터의 노트
| # | 노트 | 상태 |
|---|------|------|
| 1 | [[노트1]] | ⬜ |
| 2 | [[노트2]] | ✅ 현재 |
| 3 | [[노트3]] | ⬜ |

### 전체 목차
| # | 챕터 | 현재 |
|---|------|------|
| 1 | [[챕터1-MOC\|챕터1]] | ✅ |
| 2 | [[챕터2-MOC\|챕터2]] | ⬜ |
| 3 | [[챕터3-MOC\|챕터3]] | ⬜ |

---

← [[챕터-MOC|챕터로]] | [[메인-MOC|메인으로]]
```

### 레벨별 네비게이션 내용

| 노트 레벨 | 포함 내용 |
|----------|----------|
| **메인 MOC** | 현재 위치 + 전체 목차 (챕터 목록) |
| **카테고리 MOC** | 현재 위치 + 이 챕터의 노트 목록 + 전체 목차 |
| **원자 노트** | 현재 위치 + 같은 챕터 노트 목록 + 전체 목차 |

### Notion 변환 규칙

Notion에서는 wikilinks 대신 Notion 링크로 변환:

| Obsidian | Notion |
|----------|--------|
| `[[노트명]]` | `[노트명](notion-page-url)` |
| `[[폴더/노트명\|표시명]]` | `[표시명](notion-page-url)` |
| `✅ 현재` | 볼드 처리 + 배경색 |

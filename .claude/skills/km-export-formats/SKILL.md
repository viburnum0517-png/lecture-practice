---
name: km-export-formats
description: Use when needing Knowledge Manager 출력 형식 및 내보내기 절차. Obsidian/Notion/Markdown/PDF/블로그 등 다양한 포맷으로 노트 저장 시 사용.
---

# Knowledge Manager 출력 형식 스킬

> Knowledge Manager 에이전트의 다양한 출력 형식 및 내보내기 절차

---

## 🚨 FILE SAVE PROTOCOL (최우선 - 반드시 읽기!)

**모든 노트/파일 생성 시 반드시 도구를 실제로 호출해야 합니다!**

### ✅ MUST DO (필수 행동) — 3-Tier 저장 프로토콜

**Tier 1: Obsidian CLI (최우선)**
```bash
"/mnt/c/Program Files/Obsidian/Obsidian.com" create path="Library/Zettelkasten/카테고리/노트제목 - YYYY-MM-DD-HHmm.md" content="[노트 전체 내용]"
```

**Tier 2: Obsidian MCP (CLI 실패 시)**
```tool-call
mcp__obsidian__create_note
- path: "Library/Zettelkasten/카테고리/노트제목 - YYYY-MM-DD-HHmm.md"
- content: "[노트 전체 내용]"
```

**Tier 3: Write 도구 (MCP 실패 시)**
```tool-call
Write
- file_path: "C:\Users\treyl\Documents\Obsidian\Second_Brain\Zettelkasten\카테고리\노트제목.md"
- content: "[노트 전체 내용]"
```

### ❌ NEVER DO (절대 금지!)

```
❌ JSON 형식으로 출력만 하고 끝내기
❌ "저장하겠습니다"라고만 말하고 도구 호출 안 함
❌ 노트 내용을 대화창에만 표시하고 파일 생성 안 함
❌ CLI/create_note/Write 도구 호출 없이 다음 단계 진행
```

### 저장 후 필수 검증

```
□ CLI, mcp__obsidian__create_note, 또는 Write 도구를 실제로 호출했는가?
□ 도구 응답에서 성공 메시지 확인했는가?
  - CLI: exit code 0 + 파일 경로 출력
  - MCP: "created successfully" / "Note created at..."
  - Write: 에러 없는 정상 응답
□ 모든 생성해야 할 노트에 대해 도구 호출을 완료했는가?
```

⚠️ **JSON 출력만 하고 끝내면 작업 실패로 간주됩니다!**
⚠️ **도구 호출 결과 확인 없이 "저장 완료"라고 보고하면 안 됩니다!**

---

## 지원 출력 형식 개요

| 형식 | 스킬 | 주요 용도 |
|------|------|----------|
| Obsidian | zettelkasten-note | 개인 지식 관리, 연결 노트 |
| Notion | notion-knowledge-capture | 팀 협업, 데이터베이스 |
| Markdown | 기본 | 범용, 이식성 |
| PDF | pdf | 공유, 보관, 인쇄 |
| 블로그 | 기본 | Medium, WordPress 게시 |
| 다이어그램 | drawio-diagram | 시각화, 아키텍처 |

---

## 형식별 상세 절차

| 형식 | 참조 파일 | 핵심 사항 |
|------|----------|----------|
| **Obsidian (Zettelkasten)** | `references/obsidian.md` | 3-Tier 저장, 경로 규칙, 이미지 임베딩 |
| **Obsidian (3-Tier 계층)** | `references/obsidian.md` | Research/ 폴더, MOC 구조, 네비게이션 푸터 |
| **Notion** | `references/notion.md` | PowerShell 직접 호출 (MCP 버그 주의!) |
| **Markdown** | `references/other-formats.md` | 표준 변환, wikilink 제거 |
| **PDF** | `references/other-formats.md` | reportlab/pandoc 사용 |
| **블로그 (Medium/WP)** | `references/other-formats.md` | 플랫폼 호환 변환 |
| **다이어그램** | `references/other-formats.md` | drawio MCP 사용 |
| **스킬 조합 예시** | `references/other-formats.md` | PDF→Obsidian+Notion 등 조합 |

> See `references/obsidian.md` for Obsidian/3-tier 저장 절차 상세
> See `references/notion.md` for Notion 저장 절차 (PowerShell 방식) 상세
> See `references/other-formats.md` for PDF, 블로그, 다이어그램, 병렬 처리, 스킬 조합 예시 상세

---

## ⚠️ Notion 저장 주의사항

**MCP 도구(`mcp__notion__API-post-page`)는 파라미터 직렬화 버그로 사용 금지!**
→ PowerShell 직접 호출 사용. 상세: `references/notion.md`

---

## 병렬 출력 처리 핵심 원칙

```
핵심 규칙:
- 독립적인 도구 호출은 같은 메시지에서 병렬 실행
- 의존성 있는 작업은 순차 처리 (예: 폴더 생성 → 파일 저장)
- 일부 실패해도 나머지 작업은 계속 진행

병렬 가능 (동시 실행):
├── Obsidian 노트 A + Obsidian 노트 B
├── Obsidian 노트 + Notion 페이지
├── 다이어그램 + 텍스트 노트
└── PDF 생성 + Markdown 저장

순차 필수 (의존성):
├── 폴더 생성 → 해당 폴더에 파일 저장
├── 메인 노트 생성 → MOC에 링크 추가
└── Notion 페이지 생성 → 블록 추가
```

> See `references/other-formats.md` for 병렬 출력 처리 상세 예시

---

## 출력 품질 체크리스트

```
□ 콘텐츠가 정확하게 변환되었는가?
□ 구조가 원본과 일치하는가?
□ 메타데이터가 완전한가?
□ 링크/참조가 유효한가?
□ 포맷이 대상 플랫폼에 적합한가?
□ 파일이 올바른 위치에 저장되었는가?

## 파일 저장 검증 (필수!)
□ CLI, mcp__obsidian__create_note, 또는 Write 도구를 실제로 호출했는가?
□ 도구 호출 결과에서 성공 메시지 확인했는가? (CLI exit 0 / MCP success / Write 정상)
□ JSON 출력만 하고 끝내지 않았는가?
□ 모든 파일이 실제로 생성되었음을 확인했는가?

## 이미지 파이프라인 검증 (이미지 추출 활성 시!)
□ Image Catalog의 모든 이미지가 다운로드/복사 되었는가?
□ Resources/images/{topic-folder}/ 폴더에 파일이 실제로 존재하는가?
□ 노트 내 ![[Resources/images/...]] 구문과 실제 파일이 1:1 매핑되는가?
□ 본문 흐름 배치 규칙을 따르는가? (개념→빈줄→이미지→빈줄→상세, 연속 배치 없음)
□ Notion 외부 URL 이미지가 image 블록으로 삽입되었는가?
□ 로컬 전용 이미지는 텍스트 설명(callout)으로 대체되었는가?
```

---

## 스킬 참조

- **zettelkasten-note.md**: Obsidian 노트 형식 상세
- **pdf.md**: PDF 처리 상세
- **xlsx.md**: Excel 처리 상세
- **docx.md**: Word 처리 상세
- **pptx.md**: PowerPoint 처리 상세
- **drawio-diagram.md**: 다이어그램 생성 상세
- **notion-knowledge-capture.md**: Notion 지식 캡처
- **notion-research-documentation.md**: Notion 리서치 문서화

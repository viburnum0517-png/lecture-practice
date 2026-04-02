---
name: zettelkasten-note
description: Use when creating Zettelkasten-style notes in Obsidian vault using obsidian MCP
---

# Zettelkasten Note Skill

제텔카스텐 기법에 따라 Obsidian vault에 메모를 생성합니다.

## 제텔카스텐 원칙 (요약)

1. **원자성 (Atomicity)**: 하나의 노트에는 하나의 아이디어만 담는다
2. **연결성 (Connectivity)**: 다른 노트와의 연결을 항상 고려한다
3. **자기 설명성**: 노트 자체만으로 내용을 이해할 수 있어야 한다
4. **고유 식별자**: 각 노트는 고유한 ID를 가진다

> See references/philosophy.md for 철학/원칙 상세 및 콘텐츠 풍부화 가이드라인

## 사용자 상호작용 워크플로우

1. 크롤링된 콘텐츠 분석 후 추출할 핵심 아이디어 목록 제시
2. 콘텐츠 복잡도에 따라 노트 유형 결정:
   - 단일 개념 → 일반 Zettelkasten 노트
   - 복잡한 주제/여러 개념 → MOC + 개별 노트들
   - 도구/제품 소개 → 도구/제품 노트
3. 각 아이디어에 대한 제텔카스텐 노트 초안 생성
4. 기존 노트와의 연결점 제안 (실제 기존 노트 검색)
5. 사용자 승인 후 Obsidian에 저장

> See references/templates.md for 노트 유형별 전체 템플릿

## 파일명 규칙

파일명: `[노트제목] - YYYY-MM-DD-HHmm.md`

예시:
- `AI 내성의 개념 - 2025-10-30-1306.md`
- `AI-Induced Psychosis Research - MOC - 2025-11-13-1500.md`
- `Agent Kit - 2025-10-08-1457.md`

## 저장 위치

### Mine vs Library 라우팅 (CRITICAL)

노트 저장 전 반드시 원저자를 확인:
- 원저자 = tofukyung(김재경) → `Mine/` 하위 (얼룩소/, Threads/, Essays/, Lectures/, Projects/)
- 원저자 ≠ tofukyung → `Library/Zettelkasten/[카테고리]/` (기본)

### 외부 자료 원자 노트 (Library)

카테고리에 따라 다음 폴더에 저장:
- `Second_Brain/Library/Zettelkasten/[카테고리]/`

주요 카테고리 (기존 사용):
- `AI-성능최적화`: AI 성능 관련
- `AI-도구`: AI 도구 및 서비스
- `AI-연구`: AI 연구 논문 및 발견
- `AI-Safety`: AI 안전 관련

새 카테고리가 필요하면 적절한 이름으로 생성합니다.

## 태그 체계

### 기본 태그 형식 (배열)
```yaml
tags: [주제1, 주제2, cognition, self-awareness]
```

### 계층형 태그 (# 접두사)
```yaml
tags:
  - "#개념/AI/에이전트"
  - "#유형/정의"
  - "#출처/YouTube"
```

### 주제 태그
- AI, introspection, cognition, safety, alignment
- AI-Safety, psychosis, red-teaming, MOC

### 유형 태그
- `#유형/프레임워크`: 사고 프레임워크
- `#유형/정의`: 개념 정의
- `#유형/사례`: 실제 사례
- `map-of-content`: MOC 노트

### 출처 태그
- `#출처/YouTube`
- `#출처/논문`
- `#출처/블로그`
- `#출처/공식문서`

## Obsidian 도구 사용법 (3-Tier Fallback)

노트 생성/읽기/검색 시 다음 우선순위를 따릅니다.

### 도구 우선순위

| 작업 | Tier 1: Obsidian CLI | Tier 2: Obsidian MCP | Tier 3: Write/Read/Grep |
|------|---------------------|---------------------|------------------------|
| 노트 생성 | `"$OBSIDIAN_CLI" create path="{path}" content="{content}"` | `mcp__obsidian__create_note` | `Write(file_path)` |
| 노트 읽기 | `"$OBSIDIAN_CLI" read path="{path}"` | `mcp__obsidian__read_note` | `Read(file_path)` |
| 노트 검색 | `"$OBSIDIAN_CLI" search query="{q}" format=json` | `mcp__obsidian__search_vault` | `Grep(pattern)` |
| Frontmatter 설정 | `"$OBSIDIAN_CLI" property:set path="{path}" name="{key}" value="{val}"` | `mcp__obsidian__update_note` | `Edit(file_path)` |

```bash
OBSIDIAN_CLI="/mnt/c/Program Files/Obsidian/Obsidian.com"
```

### 새 노트 생성

```bash
# 1순위: Obsidian CLI
"$OBSIDIAN_CLI" create path="Library/Zettelkasten/[카테고리]/[파일명].md" content="[마크다운 내용]"

# CLI 실패 시: Obsidian MCP fallback
mcp__obsidian__create_note({ path: "Library/Zettelkasten/[카테고리]/[파일명].md", content: "[마크다운 내용]" })

# MCP 실패 시: Write 도구 fallback
Write(file_path="/mnt/c/Users/treyl/Documents/Obsidian/Second_Brain/Library/Zettelkasten/[카테고리]/[파일명].md", content="[마크다운 내용]")
```

### Frontmatter 조작

```bash
# 1순위: CLI property:set
"$OBSIDIAN_CLI" property:set path="Library/Zettelkasten/[카테고리]/[파일명].md" name="tags" value="[AI, MCP]"
"$OBSIDIAN_CLI" property:set path="Library/Zettelkasten/[카테고리]/[파일명].md" name="status" value="evergreen"

# CLI 실패 시: MCP update_note fallback
mcp__obsidian__update_note({ path: "...", edits: [{ oldText: "...", newText: "..." }] })

# MCP 실패 시: Edit 도구 fallback
Edit(file_path="...", old_string="...", new_string="...")
```

> **경로 규칙**: CLI/MCP 경로는 vault root 기준 상대 경로 (예: `Library/Zettelkasten/AI-연구/note.md`). Write/Read/Grep은 절대 경로 사용.

## 연결 도출 방법

1. **키워드 매칭**: 기존 노트의 태그와 제목에서 관련 키워드 검색
2. **개념적 연결**: 상위/하위 개념, 원인/결과, 비교/대조 관계 파악
3. **시간적 연결**: 발전 과정, 이전/이후 관계
4. **적용적 연결**: 이론과 실제 적용 사례 연결

### Wikilink 형식
- `[[파일명]]` - 기본 링크
- `[[id 파일명]]` - ID 기반 링크 (예: `[[202510301307 Concept Injection 방법론]]`)
- `[[파일명 - 날짜]]` - 날짜 포함 링크 (예: `[[AI 내성의 개념 - 2025-10-30-1306]]`)

## 기존 노트 검색 방법

연결 노트를 찾을 때 기존 Vault의 노트들을 검색합니다:
- `Library/Zettelkasten/` 하위 모든 폴더 검색
- 태그, 제목, 키워드로 관련성 판단
- 검색된 실제 노트 파일명을 연결에 사용

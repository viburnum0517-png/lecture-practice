# Overview: 도구 우선순위, 파이프라인 매핑, 상태 머신

## Obsidian 도구 우선순위 (3-Tier Fallback)

```bash
OBSIDIAN_CLI="/mnt/c/Program Files/Obsidian/Obsidian.com"
VAULT="/mnt/c/Users/treyl/Documents/Obsidian/Second_Brain"
GRAPHRAG_ROOT=".team-os/graphrag"
```

| 작업 | Tier 1: Obsidian CLI | Tier 2: Obsidian MCP | Tier 3: Raw |
|------|---------------------|---------------------|-------------|
| 노트 읽기 | `"$OBSIDIAN_CLI" read path="{path}"` | `mcp__obsidian__read_note` | `Read(file_path)` |
| 노트 검색 | `"$OBSIDIAN_CLI" search query="{q}" format=json` | `mcp__obsidian__search_vault` | `Grep(pattern)` |
| Backlinks 조회 | `"$OBSIDIAN_CLI" backlinks path="{path}" format=json` | (CLI 전용) | `Grep(\[\[파일명\]\])` |
| Frontmatter 쓰기 | `"$OBSIDIAN_CLI" property:set path="{path}" name="{key}" value="{val}"` | `mcp__obsidian__update_note` | `Edit(file_path)` |
| 노트 생성 | `"$OBSIDIAN_CLI" create path="{path}" content="{content}"` | `mcp__obsidian__create_note` | `Write(file_path)` |

> **Python 배치** 내에서는 직접 파일 I/O 사용 (open/write). 그래프 DB 조작은 Python 스크립트에서만.

---

## 6단계 인덱싱 파이프라인 매핑

GraphRAG 이론의 6단계를 Mode G의 Phase로 매핑:

| GraphRAG 6단계 | Mode G Phase | 핵심 구현 |
|---------------|-------------|---------|
| 1단계: 텍스트 청킹 | G2 (청크 분할) | 600토큰 / 100토큰 오버랩 |
| 2단계: 엔티티/관계 추출 | G2 (ABox 구성) | Hub→LLM+Self-Reflection / 일반→메타데이터 |
| 3단계: KG 구축 | G2 (SQLite 저장) | TBox+ABox → Knowledge Graph |
| 4단계: 계층적 커뮤니티 탐지 | G3 (Louvain C0-C3) | 연결 보장 + 정제 단계 |
| 5단계: 커뮤니티 요약 | G3 (LLM 요약) | 6개 분석공간 매핑 + TDA |
| 6단계: 맵-리듀스 | G5 (보고서 생성) | Global/Local 분기 |

---

## 상태 머신

```
[INIT] ──────────────────────────────────────────────┐
   │                                                  │
   ▼                                                  │
[G0: 환경 감지]                                       │
   │ DB 없음          DB 있음                         │
   ▼                  ▼                               │
[G1: TBox 구축] → [TBox 갱신]                         │
   │                  │                               │
   ▼                  ▼                               │
[G2: ABox 구성/KG 구축] ← [증분 갱신]                 │
   │                                                  │
   ▼                                                  │
[G3: 계층적 커뮤니티 탐지 + 6개 분석공간 매핑]          │
   │                                                  │
   ▼                                                  │
[G4: Global/Local 검색 분기 활성화] ────────────────▶ │
   │                                                  │
   ▼                                                  │
[G5: 맵-리듀스 보고서 생성]                            │
   │                                                  │
   ▼                                                  │
[G6: Frontmatter 동기화 + 메타온톨로지 귀납] ─────── [DONE]
```

## 진입점 분기 테이블

| 사용자 표현 | 진입 Phase | 설명 |
|------------|-----------|------|
| "그래프 처음 만들어줘" / "GraphRAG 초기화" | G0 → G6 전체 | 풀 빌드 |
| "그래프 업데이트" / "새 노트 반영해줘" | G0 → G2(증분) → G3 → G6 | 증분 갱신 |
| "~에 대해 검색해줘" / "인사이트 찾아줘" | G4 → G5 | 검색만 (기존 그래프 사용) |
| "frontmatter 동기화" | G6만 | 동기화만 |
| "온톨로지 갱신" | G1만 | TBox 재설계 |

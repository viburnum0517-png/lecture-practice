---
name: km-environment-detection-phase4-5
description: Phase 4: 적응형 동작 설정 + Phase 5: 병렬 검색 활성화 (Task/Agent Teams) + 벤치마크 + 에러 처리
---

# Phase 4: 적응형 동작 설정

### 4.1 감지 결과 기반 동작 분기

감지된 티어와 **실제 설치된 도구**에 따라 km-workflow 동작이 자동 적응됩니다.

```
감지 결과 저장 → km-workflow Phase 2/5.5에서 참조
```

### 4.2 MCP 서버 가용성 확인

**CRITICAL**: 티어만으로 판단하지 않음. 실제 MCP 서버 존재 여부를 확인.

#### GraphRAG 의존성 확인

```bash
# GraphRAG Python 의존성 체크
python3 -c 'import networkx; import community; print("GraphRAG deps OK")' 2>/dev/null
```

| 결과 | 상태 | 영향 |
|------|------|------|
| `GraphRAG deps OK` | ✅ GraphRAG 사용 가능 | Mode G 풀 기능 활성화 |
| ImportError | ❌ 의존성 미설치 | Mode G 제한 (그래프 구축 불가) |

**의존성 미설치 시 안내:**
```
GraphRAG 의존성이 설치되지 않았습니다.
Mode G (GraphRAG) 사용을 위해 설치하세요:
  pip install networkx python-louvain
```

```bash
# Step 1: Obsidian CLI 확인 (우선)
OBSIDIAN_CLI="/mnt/c/Program Files/Obsidian/Obsidian.com"
"$OBSIDIAN_CLI" version 2>/dev/null
# 응답 있으면 → obsidian_method = "cli"

# Step 2: CLI 실패 시 MCP 확인
# mcp__obsidian__list_notes({}) 호출
# 응답 있으면 → obsidian_method = "mcp"

# Step 3: 둘 다 실패 → obsidian_method = "filesystem"

# Step 4: MCP 서버 목록 확인 (추가 도구)
claude mcp list
```

확인 항목:
- Obsidian CLI v1.12+ → `obsidian_method = "cli"` (검색/역링크/고아노트 네이티브)
- Obsidian MCP → `obsidian_method = "mcp"` (search_vault, update_note 사용 가능)
- `chroma` → 벡터 유사도 검색 사용 가능
- `neo4j` → 그래프 순회 검색 사용 가능

### 4.3 검색 전략 자동 선택

| 사용 가능한 도구 | 검색 전략 | Phase 2 동작 | Phase 5.5 동작 |
|-----------------|----------|-------------|---------------|
| obsidian CLI | **Keyword + Backlinks (네이티브)** | `search` + `backlinks` + `links` | CLI backlinks + append |
| obsidian MCP만 | **Keyword + Wikilink** | search_vault + Grep `\[\[키워드\]\]` | 키워드 매칭 + wikilink 역추적 |
| obsidian + chroma | **+ Vector** | 위 + Chroma similarity search | 벡터 유사도 기반 연결 추천 추가 |
| obsidian + chroma + neo4j | **+ Graph** | 위 + Neo4j 그래프 순회 | 3축 하이브리드 연결 강화 |

### 4.4 사용자 요약 출력 (세션 시작 시)

```markdown
---

### 📋 Knowledge Manager 현재 설정

| 검색 기능 | 상태 |
|----------|------|
| 키워드 검색 | ✅ 활성 |
| Wikilink 관계 탐색 | ✅ 활성 |
| 벡터 유사도 검색 | {✅ 활성 / ❌ 미설치} |
| 그래프 순회 검색 | {✅ 활성 / ❌ 미설치} |
| 로컬 AI 임베딩 | {✅ 활성 / ❌ 미설치} |

> 현재 모드: **{Basic/Standard/Advanced}**
> {미설치 기능이 있으면: "환경 감지" 또는 "RAG 설정"을 입력하면 업그레이드 가이드를 볼 수 있습니다.}

---
```

---

## Phase 5: 병렬 검색 활성화 (환경별 자동 분기)

> **검증 결과 (2026-02-06)**: 병렬 검색은 환경에 따라 두 가지 모드로 동작합니다.

### 5.1 병렬 검색이란?

Knowledge Manager의 검색 Phase(Phase 2)에서 **여러 검색 작업을 동시에 실행**하여 속도를 2x 이상 향상시킵니다.
환경에 따라 서로 다른 병렬화 메커니즘이 자동으로 선택됩니다.

### 5.2 환경별 병렬화 모드 (자동 감지)

| 환경 | 병렬화 모드 | 메커니즘 | 검증 상태 |
|------|-----------|---------|----------|
| **VS Code / SDK** | 병렬 Task 서브에이전트 | Task 도구 병렬 호출 (읽기 전용) | ✅ 검증됨 (2026-02-06) |
| **터미널 CLI** (`claude` interactive) | Agent Teams | Teammate 생성 + Mailbox 통신 | ✅ 검증됨 (2026-02-06) |

#### 환경 감지 로직

```
Phase 0에서 감지:
1. 실행 환경 확인 (VS Code extension vs 터미널 CLI)
2. 터미널 CLI + interactive 모드 → Agent Teams 사용 가능
3. VS Code / SDK / Task 내부 → 병렬 Task 서브에이전트 사용
```

> **IMPORTANT**: Task 도구의 `team_name` 파라미터는 Agent Teams를 활성화하지 **않습니다**.
> `team_name`은 메타데이터 라벨일 뿐이며, 실제 Teammate 인스턴스를 생성하지 않습니다 (2026-02-06 파일시스템 모니터링으로 검증).

### 5.3 모드 A: 병렬 Task 서브에이전트 (VS Code / SDK — 기본)

이 모드가 대부분의 사용자 환경에서 **기본 실행 모드**입니다.

#### 동작 방식 (GraphRAG 근사 패턴)

```
Main Agent (Coordinator + Generator)
    │
    ├── Task 1 @graph-navigator (Explore, sonnet[1m])
    │   → wikilink 체인 2-hop 추적 → 관계 그래프 반환
    │
    ├── Task 2 @retrieval-specialist (Explore, sonnet[1m])
    │   → 키워드+태그+폴더 넓은 검색 → 고립 노트 발견
    │
    └── Task 3 @deep-reader (Explore, sonnet[1m]/opus[1m]) — Complex만
        → Hub 노트 실제 읽기 → 요약 + 간극 분석

    → 모든 Task를 하나의 메시지에서 병렬 호출
    → Main이 Graph ∩ Retrieval 교차 검증 → 노트 생성
```

> **핵심**: 단순 검색 병렬이 아닌 **Graph + Retrieval + Reading** 역할 분리.
> Neo4j 없이 wikilink 체인 추적으로 그래프 탐색을 근사합니다.

#### 핵심 규칙

- Task 서브에이전트는 **읽기(Explore) 전용** — 쓰기 작업 위임 금지
- 모든 파일 생성/수정은 **Main이 직접 실행** (Bug-2025-12-12-2056 방지)
- 순차 대비 약 **2x 속도 향상** (실측: 순차 355-391초 → 병렬 161-183초)

#### 사용자 알림 (Phase 0에서 표시)

```markdown
---

### 검색 모드: 병렬 Task 서브에이전트

| 항목 | 설명 |
|------|------|
| **모드** | 병렬 Task 서브에이전트 (Sonnet 1M, 필요 시 Opus 1M) |
| **효과** | 검색 속도 ~2x, 컨텍스트 격리 |
| **환경** | VS Code / SDK |

> 터미널 CLI에서는 Agent Teams 모드가 자동 활성화됩니다.

---
```

### 5.4 모드 B: Agent Teams (터미널 CLI 전용)

**터미널 CLI** (`claude` interactive 모드)에서만 사용 가능한 고급 병렬화입니다.

#### 동작 방식 (GraphRAG 근사 패턴)

```
Main Agent (Coordinator + Generator)
    │
    ├── @graph-navigator (Teammate)
    │   → wikilink 체인 2-hop 추적 → 관계 그래프
    │   → Mailbox로 결과 전달
    │
    ├── @retrieval-specialist (Teammate)
    │   → 키워드+태그 넓은 검색 → 고립 노트 발견
    │   → Mailbox로 결과 전달
    │
    └── @deep-reader (Teammate, Complex)
        → Hub 노트 실제 읽기 → 요약 + 간극 분석
        → Mailbox로 결과 전달

Main은 Shift+↑/↓로 Teammate 전환 가능
Teammate는 독립 인스턴스 (쓰기도 안전)
```

#### Agent Teams 설정

`settings.local.json`의 `env` 섹션:
```json
{
  "env": {
    "CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS": "1"
  }
}
```

> 이 설정은 **터미널 CLI에서만 효과**가 있습니다.
> VS Code에서는 이 설정이 있어도 Agent Teams가 동작하지 않습니다.

#### 제한사항

```
- 터미널 CLI interactive 모드 전용 (VS Code, SDK 미지원)
- Research Preview (실험 기능)
- 세션 복원(/resume) 시 Teammate 소실
- Windows Terminal: split-pane 미지원 (in-process 모드)
- 1 세션 = 1 팀만 가능
- "Agent Teams 끄기"로 순차 모드 복귀 가능
```

### 5.5 검색 전략 자동 선택 (병렬화 반영)

| 사용 가능한 도구 | 순차 모드 | 병렬 모드 (Task / Agent Teams) |
|-----------------|----------|-------------------------------|
| obsidian CLI | Backlinks → Search | Backlinks ∥ Search |
| obsidian MCP만 | Wikilink → Keyword | Wikilink ∥ Keyword |
| + chroma | Wikilink → Keyword → Vector | Wikilink ∥ Keyword ∥ Vector |
| + neo4j | 모두 순차 | 4축 동시 검색 |

---

## 참고: 검색 정확도 벤치마크

| 검색 방식 | 관련 노트 발견율 | 검색 시간 | 필요 인프라 |
|----------|-----------------|----------|-----------|
| 키워드 only | ~60% | <1초 | 없음 |
| + Wikilink Grep | ~80% | <2초 | 없음 |
| + Vector (Chroma) | ~92% | 2-3초 | Chroma |
| + Graph (Neo4j) | ~97% | 3-5초 | Neo4j + Ollama |

> 출처: DMR Benchmark 기반 추정 (Efficient Agents Survey, 2024)

---

## 에러 처리

| 상황 | 대응 |
|------|------|
| 시스템 명령어 실행 실패 | OS 감지 재시도 → 실패 시 사용자에게 직접 스펙 질문 |
| GPU 감지 불가 | "GPU 정보를 감지하지 못했습니다. dGPU가 있으신가요?" |
| MCP 서버 연결 실패 | "서버가 설치되었지만 연결 실패. 재시작 후 재시도" |
| 설치 중 오류 | 에러 메시지 표시 + 수동 설치 가이드 링크 제공 |

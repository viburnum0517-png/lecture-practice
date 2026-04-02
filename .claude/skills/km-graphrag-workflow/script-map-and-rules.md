# Python 스크립트 연동 맵 + 실행 주체 규칙 + 참조

## Python 스크립트 연동 맵

| Phase | 스크립트 경로 | 용도 |
|-------|-------------|------|
| G0 | `.team-os/graphrag/scripts/detect_changes.py` | 증분 변경 감지 |
| G1 | `.team-os/graphrag/scripts/load_ontology.py` | TBox 로드/저장 |
| G1 | `.team-os/graphrag/scripts/sample_vault.py` | 샘플 노트 추출 (vault 분석) |
| G2 | `.team-os/graphrag/scripts/entity_extractor.py` | ABox 추출 (Self-Reflection 포함) |
| G2 | `.team-os/graphrag/scripts/build_graph.py` | KG 구축 (배치) |
| G3 | `.team-os/graphrag/scripts/community_detector.py` | Louvain 계층 커뮤니티 탐지 |
| G4 | `.team-os/graphrag/scripts/graph_search.py` | Global/Local 검색 분기 |
| G6 | `/tmp/sync_frontmatter.py` (임시 생성) | Frontmatter 동기화 |
| G6 | `.team-os/graphrag/scripts/induce_meta_ontology.py` | 메타온톨로지 귀납 |

> **CRITICAL**: G6 배치 스크립트는 `/tmp/`에 생성 후 실행. vault 내 스크립트 배치 금지.
> G0-G5 인프라 스크립트는 infra-worker 영역 (`.team-os/graphrag/`) -- 수정 금지.

---

## CRITICAL: 실행 주체 규칙

| 허용 | 금지 |
|------|------|
| Lead가 Python 스크립트 생성 + 직접 Bash 실행 | Agent Teams 팀원에게 Write/Bash 위임 |
| Explore 에이전트에게 그래프 분석 위임 (읽기 전용) | Task 에이전트에게 DB 쓰기 위임 |

> **Why**: Agent Teams worktree 버그 -- 팀원의 파일 수정이 TeamDelete 시 유실됨 (Bug-2026-02-25-1700).

---

## 참조 스킬

| 스킬 | 용도 |
|------|------|
| `km-graphrag-ontology.md` | G1 TBox 설계 + DA 검증 상세 |
| `km-batch-python.md` | G6 배치 실행 프로토콜 |
| `km-archive-reorganization.md` | Phase 패턴 참조 (R0-R5) |
| `km-rules-engine.md` | DA 검증 패턴 |
| `km-workflow.md` | 기존 KM 워크플로우 (Phase 0-6) |

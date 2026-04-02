# Phase G0: 환경 감지 + 그래프 로드

**목적**: Python 의존성 확인, 기존 DB 탐지, 빌드 전략 결정, config 로드.

## G0-1. Python 의존성 확인

```bash
python3 -c "import networkx, community, sqlite3; print('OK')" 2>&1
```

| 패키지 | pip 설치 | 용도 |
|--------|---------|------|
| networkx | `pip install networkx` | 그래프 자료구조 |
| python-louvain | `pip install python-louvain` | Louvain 커뮤니티 탐지 |
| sqlite3 | 표준 라이브러리 | 그래프 DB |

> **현재 구현**: Louvain (python-louvain) — multi-resolution으로 C0-C3 계층 생성.
> **향후 전환 예정**: Leiden (leidenalg + python-igraph) — 연결 보장 + 정제 단계 추가.
> Louvain은 연결 안 된 커뮤니티가 생성될 수 있으나, 현재 TDA β₀ 검증으로 보완 중.

실패 시:
```bash
pip install networkx leidenalg python-igraph
```

## G0-2. DB 존재 확인

```bash
ls .team-os/graphrag/graph.db 2>/dev/null && echo "EXISTS" || echo "NEW"
```

| 결과 | 전략 |
|------|------|
| `EXISTS` | 증분 갱신 (변경된 노트만 처리) |
| `NEW` | 풀 빌드 (전체 vault 처리) |

## G0-3. config.yaml 로드

기본 config 구조:
```yaml
vault_path: "/mnt/c/Users/treyl/Documents/Obsidian/Second_Brain"
db_path: ".team-os/graphrag/graph.db"
ontology_path: ".team-os/graphrag/ontology.json"
batch_size: 100
batch_delay: 2.0
hub_threshold: 5          # backlinks 5+ → Hub 노트
llm_extraction: true
community_algorithm: "leiden"  # leiden 또는 louvain
community_resolution: 1.0      # Leiden resolution
community_levels: 4             # C0(루트) ~ C3(리프)
chunk_size_tokens: 600          # 청킹 크기 (이론 기반: 600토큰)
chunk_overlap_tokens: 100       # 오버랩 (이론 기반: 100토큰)
reports_path: "Library/Research/GraphRAG-Analysis"
helpfulness_threshold: 0.4      # 맵-리듀스 필터 임계값
default_community_level: 1      # 글로벌 검색 기본 레벨 (C1 = 균형점)
```

## G0-4. 증분 갱신 시: 변경 노트 감지

```bash
python3 .team-os/graphrag/scripts/detect_changes.py \
  --db .team-os/graphrag/graph.db \
  --vault "$VAULT"
```

산출물: `.team-os/graphrag/artifacts/changed_files.txt`

# Phase G6: Frontmatter 동기화 + 메타온톨로지 귀납

**목적**: 그래프 분석 결과를 각 노트 frontmatter에 동기화.
**반복 빌드 시**: 메타온톨로지 귀납 패턴 수집.
**실행 프로토콜**: `km-batch-python.md` 참조

## 동기화 필드 (확장)

| 필드 | 타입 | 설명 | 예시 |
|------|------|------|------|
| `graph_entity` | string | TBox 클래스 | `concept` |
| `graph_community` | integer | 소속 커뮤니티 ID | `3` |
| `graph_community_level` | integer | 커뮤니티 레벨 (C0~C3) | `2` |
| `graph_connections` | integer | 연결된 엣지 수 | `12` |
| `graph_centrality` | float | 복합 중심성 점수 | `0.042` |
| `graph_analysis_spaces` | list | 주요 분석공간 | `["structural", "hierarchy"]` |

## 메타온톨로지 귀납 (반복 빌드 시)

```python
def induce_meta_ontology_patterns(db_path: str, build_history: list) -> dict:
    """
    반복 빌드에서 메타온톨로지 패턴 귀납
    이론: 메타온톨로지-3층-추상화 §귀납-메커니즘

    Level 0 (Raw) → Level 1 (Domain Ontology) → Level 2 (Meta-Ontology)
    이 함수는 Level 1 → Level 2 귀납을 수행
    """
    meta_patterns = {
        "recurring_classes": [],      # 여러 빌드에서 반복 등장
        "recurring_relations": [],    # 반복 등장 관계 패턴
        "hub_patterns": [],           # Hub 노드의 공통 특성
        "universal_candidates": [],   # Level 3 후보 (도메인 무관 원칙)
    }

    # 분석: 반복 등장 패턴
    for build in build_history:
        # 클러스터 구조가 유사하게 유지되는 클래스 → 메타온톨로지 후보
        pass

    # 메타온톨로지 신호 저장
    with open(".team-os/graphrag/meta-ontology-signals.json", "w") as f:
        json.dump(meta_patterns, f, ensure_ascii=False, indent=2)

    return meta_patterns
```

빌드 이력이 3회 이상 쌓이면 메타온톨로지 패턴 리포트 생성:
```bash
# G6 종료 시 자동 실행 (빌드 횟수 >= 3)
python3 .team-os/graphrag/scripts/induce_meta_ontology.py \
  --db .team-os/graphrag/graph.db \
  --history .team-os/graphrag/build-history.json
```

## Python 스크립트 (Frontmatter 동기화)

```python
# /tmp/sync_frontmatter.py
#!/usr/bin/env python3
import argparse, glob, os, re, sqlite3, yaml

def get_graph_data(db_path):
    conn = sqlite3.connect(db_path)
    data = {}

    for row in conn.execute("""
        SELECT n.source_note, n.class, n.community_id, n.community_level,
               n.centrality, c.analysis_spaces,
               COUNT(e.id) as conn_count
        FROM nodes n
        LEFT JOIN edges e ON e.source = n.id OR e.target = n.id
        LEFT JOIN communities c ON c.id = n.community_id
                               AND c.level = n.community_level
        GROUP BY n.id
    """):
        source_note, entity_class, comm_id, comm_level, centrality, spaces, conn_count = row
        analysis_spaces = json.loads(spaces or "[]")
        data[source_note] = {
            "graph_entity": entity_class,
            "graph_community": comm_id,
            "graph_community_level": comm_level,
            "graph_connections": conn_count,
            "graph_centrality": round(centrality or 0, 4),
            "graph_analysis_spaces": list(analysis_spaces.keys())[:3],
        }

    conn.close()
    return data
```

## 실행 순서

```bash
# 1. Dry-run
python3 /tmp/sync_frontmatter.py --dry-run --db .team-os/graphrag/graph.db "$VAULT"

# 2. 사용자 승인 후 실행
python3 /tmp/sync_frontmatter.py --db .team-os/graphrag/graph.db "$VAULT"

# 3. 메타온톨로지 귀납 (빌드 횟수 >= 3)
python3 .team-os/graphrag/scripts/induce_meta_ontology.py --db .team-os/graphrag/graph.db

# 4. 즉시 커밋
cd /home/tofu/AI && git add -A && git commit -m "Phase G6: graph frontmatter sync + meta-ontology" && git push
```

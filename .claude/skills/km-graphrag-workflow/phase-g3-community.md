# Phase G3: 계층적 커뮤니티 탐지 + 6개 분석공간 매핑

**목적**: Leiden 알고리즘으로 C0-C3 계층 커뮤니티 탐지 → 6개 분석공간 매핑 → TDA 계산 → DA 검증.

이론: 6단계 파이프라인의 4~5단계 (계층적 커뮤니티 탐지 + 커뮤니티 요약).

## G3-1. NetworkX + Leiden 그래프 로드

```python
# .team-os/graphrag/scripts/detect_communities.py
import networkx as nx
import leidenalg
import igraph as ig
import sqlite3

def load_graph_from_db(db_path):
    conn = sqlite3.connect(db_path)
    G_nx = nx.Graph()

    for row in conn.execute("SELECT id, name, class FROM nodes"):
        G_nx.add_node(row[0], name=row[1], node_class=row[2])

    # confidence 임계값 이상의 엣지만 포함 (메타엣지 규칙 적용)
    for row in conn.execute(
        "SELECT source, target, weight, confidence FROM edges WHERE confidence >= 0.7"
    ):
        if G_nx.has_node(row[0]) and G_nx.has_node(row[1]):
            G_nx.add_edge(row[0], row[1], weight=row[2])

    conn.close()
    return G_nx
```

## G3-2. Leiden 계층적 커뮤니티 탐지 (C0~C3)

```python
def detect_communities_leiden(G_nx, resolution=1.0, n_levels=4):
    """
    Leiden 알고리즘: Louvain 대비 2가지 우위
    1. 연결 보장 (Connectivity Guarantee): 모든 커뮤니티가 내부적으로 연결됨
    2. 정제 단계 (Refinement Phase): 더 의미 있는 클러스터 형성

    n_levels: C0(루트)~C3(리프) = 4계층
    """
    # NetworkX → igraph 변환 (leidenalg 요구사항)
    node_list = list(G_nx.nodes())
    G_ig = ig.Graph(
        n=len(node_list),
        edges=[(node_list.index(u), node_list.index(v)) for u, v in G_nx.edges()],
        directed=False
    )

    # 계층별 커뮤니티 탐지
    community_hierarchy = {}
    for level in range(n_levels):
        # resolution이 낮을수록 큰 커뮤니티 (C0 방향)
        level_resolution = resolution * (0.5 ** (n_levels - 1 - level))
        partition = leidenalg.find_partition(
            G_ig,
            leidenalg.RBConfigurationVertexPartition,
            resolution_parameter=level_resolution,
            n_iterations=10
        )
        community_hierarchy[f"C{level}"] = {
            node_list[i]: partition.membership[i]
            for i in range(len(node_list))
        }

    return community_hierarchy

# C0~C3 계층 특성 (이론 기반)
COMMUNITY_LEVELS = {
    "C0": {"size": "매우 큼", "coverage": "전체 코퍼스", "token_cost": "최소 (-97%)", "detail": "낮음"},
    "C1": {"size": "큼", "coverage": "광범위", "token_cost": "중간", "detail": "중간"},
    "C2": {"size": "중간", "coverage": "부분", "token_cost": "중간", "detail": "높음"},
    "C3": {"size": "작음", "coverage": "세부 주제", "token_cost": "최대", "detail": "가장 높음"},
}
```

## G3-3. 중심성 계산 (위상학적 지표)

```python
def calculate_centrality(G):
    """PageRank + Betweenness 복합 중심성"""
    pagerank = nx.pagerank(G, weight='weight')
    betweenness = nx.betweenness_centrality(G, normalized=True)

    # 복합 중심성 = 0.7 * pagerank + 0.3 * betweenness
    centrality = {
        node: 0.7 * pagerank.get(node, 0) + 0.3 * betweenness.get(node, 0)
        for node in G.nodes()
    }
    return centrality
```

## G3-4. TDA 계산: beta-0, beta-1 (위상학적 데이터 분석)

```python
def calculate_tda_betti_numbers(G, community_nodes):
    """
    위상학적 지표 계산
    beta-0 (베티 수 0): 연결 컴포넌트 수 → 커뮤니티 분절성 측정
    beta-1 (베티 수 1): 1차원 루프 수 → 순환 구조/지식 피드백 루프

    이론: 위상학적-지능-패러다임-전환 §위상학적-개념
    """
    subgraph = G.subgraph(community_nodes)

    # beta-0: 연결 컴포넌트 수 (1이면 완전 연결 = Leiden 보장)
    betti_0 = nx.number_connected_components(subgraph)

    # beta-1: 루프 수 = 엣지 수 - 노드 수 + beta-0 (오일러 공식)
    n_nodes = len(subgraph.nodes())
    n_edges = len(subgraph.edges())
    betti_1 = max(0, n_edges - n_nodes + betti_0)

    return betti_0, betti_1

# beta-0 = 1: Leiden 보장 (연결 커뮤니티)
# beta-1 > 0: 순환 지식 구조 존재 (풍부한 내부 연결)
```

## G3-5. 6개 분석공간 매핑

```python
def map_community_to_analysis_spaces(community_id, community_nodes, G, level):
    """
    커뮤니티를 6개 분석공간으로 매핑
    이론: 6개-분석공간-개요, 위상학적-지능-패러다임-전환
    """
    subgraph = G.subgraph(community_nodes)

    analysis_spaces = {
        # 1. 계층공간: C0~C3 레벨이 계층 위치
        "hierarchy": {
            "level": level,  # C0=0 (루트), C3=3 (리프)
            "depth": nx.dag_longest_path_length(subgraph) if nx.is_directed_acyclic_graph(subgraph) else None,
        },
        # 2. 시간공간: precedes 관계로 시간 순서 추적
        "temporal": {
            "has_precedes_relations": any(
                G[u][v].get("relation") == "precedes"
                for u, v in subgraph.edges()
            ),
        },
        # 3. 재귀공간: Self-reference 패턴
        "recursive": {
            "has_cycles": not nx.is_dag(nx.DiGraph(subgraph)),
            "betti_1": calculate_tda_betti_numbers(G, community_nodes)[1],
        },
        # 4. 구조공간: 엣지 밀도
        "structural": {
            "edge_density": nx.density(subgraph),
            "betti_0": calculate_tda_betti_numbers(G, community_nodes)[0],
        },
        # 5. 인과공간: extends/created_by 방향 관계
        "causal": {
            "causal_relations": sum(
                1 for u, v in subgraph.edges()
                if G[u][v].get("relation") in ["extends", "created_by", "precedes"]
            ),
        },
        # 6. 다중공간: 다른 커뮤니티와의 연결 (Cross-space)
        "cross_space": {
            "inter_community_edges": sum(
                1 for n in community_nodes
                for neighbor in G.neighbors(n)
                if neighbor not in community_nodes
            ),
        }
    }
    return analysis_spaces
```

## G3-6. LLM 커뮤니티 요약 (6개 분석공간 컨텍스트 포함)

```python
COMMUNITY_SUMMARY_PROMPT = """
다음 커뮤니티의 주요 노드와 분석공간 데이터를 보고 핵심 주제를 요약하세요.

커뮤니티 레벨: {level} (C0=전체, C3=세부)
주요 노드 (중심성 상위 10개):
{top_nodes}

분석공간 데이터:
- 계층공간: C{level} 레벨 (추상화 수준)
- 구조공간: 엣지 밀도 {edge_density:.2f}, beta-0={betti_0} (연결성)
- 재귀공간: 순환 구조 {has_cycles}, beta-1={betti_1} (피드백 루프)
- 인과공간: 인과 관계 수 {causal_count}
- 다중공간: 타 커뮤니티 연결 수 {inter_community}

요약 형식:
- 커뮤니티 이름: (10자 이내)
- 핵심 주제: (1-2문장)
- 대표 개념: (3-5개 키워드)
- 분석공간 특성: (계층/구조/인과 중 가장 두드러진 것)
"""
```

커뮤니티 크기 10개 미만: LLM 요약 스킵, 노드 목록으로 대체.

## G3-7. DA 검증

```
검증 기준:
- 전체 노드 중 커뮤니티 미할당 노드 < 5%
- beta-0 = 1 (Leiden 보장: 모든 커뮤니티가 연결됨)
- 최대 커뮤니티 크기 < 전체의 50% (resolution 재조정 기준)
- C0~C3 계층 모두 존재
- LLM 요약 실패율 < 10%

→ ACCEPTABLE: communities 테이블 업데이트
→ CONCERN: beta-0 > 1 → Leiden resolution 조정 후 재실행
           최대 커뮤니티 50% 초과 → resolution 1.2로 증가
```

## G3-8. DB 업데이트

```sql
-- 계층별 커뮤니티 데이터 저장
UPDATE nodes SET community_id = ?, community_level = ?, centrality = ? WHERE id = ?;

INSERT OR REPLACE INTO communities
  (id, level, name, summary, analysis_spaces, tda_betti_0, tda_betti_1,
   member_count, hub_node, updated_at)
VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, datetime('now'));
```

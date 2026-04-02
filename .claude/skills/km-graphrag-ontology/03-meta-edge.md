---
name: km-graphrag-ontology-meta-edge
description: GraphRAG 메타엣지: 4가지 의미, N-ary Reification(관계의 노드화), Named Graph(Quad), 하이퍼그래프 표현. km-graphrag-ontology 서브파일.
---

# 3. 메타엣지 (Meta-Edge)

← [02-abox-extraction.md](02-abox-extraction.md) | → [04-build-methodology.md](04-build-methodology.md)

---

메타엣지는 일반 엣지보다 한 층 위의 **"관계에 대한 관계"** 또는 **"엣지 생성 규칙"**이다.

## 메타엣지의 4가지 의미

| 의미 | 설명 | Mode G 구현 |
|------|------|------------|
| **엣지에 대한 엣지** | 관계 자체를 노드로 만드는 Reification | N-ary 관계, Named Graph |
| **엣지 생성 규칙** | "어떤 조건에서 관계를 생성할 것인가" | `MIN_CONFIDENCE = 0.7` 등 메타 파라미터 |
| **엣지 간 관계** | 두 관계 타입이 어떻게 다른가 | TBox의 공리 정의 |
| **판단 기준 자체** | 시스템의 관계 허용 기준 | 온톨로지 공리 집합 |

---

## N-ary 관계: Reification (관계의 노드화)

단순한 A→B 이진 관계로 표현 불가한 고차 관계:

```python
# 예: "김재경이 GraphRAG를 2026-03-16에 세미나에서 발표했다"
# → 3항 관계: person × event × concept

# 방법 1: Reification (관계를 노드로)
class RelationNode:
    """관계 자체를 노드로 표현"""
    id: str          # "presentation-2026-03-16"
    type: str        # "presentation_event"
    participants: list  # [("person", "김재경"), ("concept", "GraphRAG"), ("event", "세미나")]
    date: str        # "2026-03-16"
    properties: dict

# Reification 예시
reified_relation = {
    "id": "graphrag-seminar-2026",
    "type": "reified:presentation",
    "source": "Mine/Essays/GraphRAG-세미나-발표.md",
    "participants": [
        {"role": "presenter", "entity": "person:김재경"},
        {"role": "topic", "entity": "concept:GraphRAG"},
        {"role": "venue", "entity": "event:세미나-2026-03"}
    ]
}
```

---

## Named Graph (Quad): 컨텍스트 추가

```python
# RDF Triple → Quad (Named Graph)
# Triple: (subject, predicate, object)
# Quad:   (subject, predicate, object, context)

class NamedGraphEdge:
    """관계에 컨텍스트를 추가한 확장 엣지"""
    source: str
    target: str
    relation: str
    weight: float
    # Named Graph 컨텍스트
    context: str     # "Mine/얼룩소/시리즈-A.md" → 이 노트의 관점에서 본 관계
    confidence: float  # 추출 신뢰도
    timestamp: str   # 관계가 확인된 날짜

# 레버리지 효과: 메타엣지 파라미터 하나 변경 → 전체 그래프 재구조화
META_EDGE_RULES = {
    "min_confidence": 0.7,  # 이 기준 변경 → 포함/제외 관계 수 대폭 변동
    "max_age_days": 180,    # 이 기준 변경 → 오래된 관계 제거/포함
    "min_cooccurrence": 2,  # 이 기준 변경 → 희귀 관계 포함 여부
}
```

---

## 하이퍼그래프 표현 (3+ 노드 관계)

```python
class HyperEdge:
    """N개 노드를 동시에 연결하는 하이퍼엣지"""
    id: str
    nodes: list[str]    # 2개 이상의 노드
    relation: str       # 관계 타입
    weight: float

    # 예: "GraphRAG + Leiden + 커뮤니티 탐지" 세 개념의 공동 등장
    # → HyperEdge(nodes=["GraphRAG", "Leiden", "커뮤니티-탐지"], relation="co_topic")
```

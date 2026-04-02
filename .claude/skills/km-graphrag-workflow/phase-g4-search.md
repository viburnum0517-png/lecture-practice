# Phase G4: Global/Local 검색 분기 활성화

**목적**: 쿼리 복잡도 자동 분류 (L0-L3) → Global/Local Search 분기.
이론: `GraphRAG-Global-vs-Local-Search`

## 핵심 이분법

| 구분 | 로컬 서치 (L0-L2) | 글로벌 서치 (L3) |
|------|-----------------|----------------|
| **쿼리 유형** | 특정 엔티티/관계에 대한 질문 | 코퍼스 전체 아우르는 주제 질문 |
| **탐색 방식** | 그래프 홉(hop) 기반 직접 탐색 | 커뮤니티 요약 맵-리듀스 |
| **결과 특성** | 정밀하고 구체적 | 포괄적이고 종합적 |
| **처리 비용** | 낮음 (범위 제한) | 높음 (전체 커뮤니티) |
| **적합 예시** | "GraphRAG를 개발한 곳은?" | "vault의 주요 테마는?" |

## 쿼리 복잡도 분류기 (L0-L3)

```python
from enum import Enum

class QueryLevel(Enum):
    L0 = "direct_lookup"     # 단순 직접 조회
    L1 = "relation_hop"      # 1-2홉 관계 탐색
    L2 = "complex_relation"  # 복합 관계 + DRIFT
    L3 = "global"            # 전체 코퍼스 수준

DEPTH_MAP = {
    QueryLevel.L0: 1,
    QueryLevel.L1: 2,
    QueryLevel.L2: 3,
    QueryLevel.L3: None,  # 맵-리듀스
}

def classify_query_complexity(query: str) -> QueryLevel:
    """
    쿼리 텍스트로 복잡도 자동 분류
    이론: GraphRAG-Global-vs-Local-Search §검색-전략-선택-기준
    """
    query_lower = query.lower()

    # L3: 글로벌 쿼리 패턴 (코퍼스 전체 범위)
    global_keywords = [
        "전체", "전반", "현황", "landscape", "overview", "전체적으로",
        "주요 테마", "핵심 주제", "주된 내용", "전체 분석"
    ]
    if any(kw in query_lower for kw in global_keywords):
        return QueryLevel.L3

    # L2: 복합 관계 (DRIFT 적용)
    complex_keywords = [
        "비즈니스 임팩트", "영향", "통합", "연계", "시사점", "어떻게 연결"
    ]
    if any(kw in query_lower for kw in complex_keywords):
        return QueryLevel.L2

    # L1: 관계 탐색
    relation_keywords = [
        "개발한", "만든", "사용하는", "관련", "연결", "관계"
    ]
    if any(kw in query_lower for kw in relation_keywords):
        return QueryLevel.L1

    # L0: 직접 조회
    return QueryLevel.L0
```

## 검색 라우터

```python
def search(query: str, depth: int = None) -> SearchResult:
    """
    쿼리 복잡도 → 검색 전략 자동 선택
    이론: GraphRAG-Global-vs-Local-Search §Mode-G-적용-포인트
    """
    complexity = classify_query_complexity(query)

    if complexity == QueryLevel.L3:
        # 글로벌 서치: 커뮤니티 맵-리듀스
        return global_search(query, community_level=DEFAULT_COMMUNITY_LEVEL)
    elif complexity == QueryLevel.L2:
        # DRIFT: 글로벌 개요 → 로컬 드릴다운
        global_ctx = global_search(query, community_level=0)  # C0 빠른 개요
        return drift_search(query, global_ctx, depth=3)
    else:
        # 로컬 서치: 홉 기반
        effective_depth = depth or DEPTH_MAP[complexity]
        return local_search(query, depth=effective_depth)
```

## 검색 스크립트 연동

```bash
python3 .team-os/graphrag/scripts/graph_search.py \
  --query "{사용자 쿼리}" \
  --db .team-os/graphrag/graph.db \
  --auto-level          # L0-L3 자동 분류
```

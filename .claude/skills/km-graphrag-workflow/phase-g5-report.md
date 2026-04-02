# Phase G5: 맵-리듀스 보고서 생성

**목적**: Global/Local 검색 결과 기반 보고서 생성.
글로벌 쿼리: 맵-리듀스 3단계 적용. 로컬 쿼리: ReACT 루프.
이론: `GraphRAG-Map-Reduce-쿼리-전략`

## 글로벌 서치: 맵-리듀스 3단계

```python
async def global_search(query: str, community_level: int = 1) -> SearchResult:
    """
    맵-리듀스 글로벌 쿼리
    이론: GraphRAG-Map-Reduce-쿼리-전략 §3단계

    community_level: C0(최소 비용/최대 추상화) ~ C3(최대 비용/최대 정밀도)
    기본값: C1 (균형점)
    C0의 97% 토큰 절감 효과 활용 가능
    """

    # === Phase 1: Map (병렬 중간 답변 생성) ===
    community_summaries = load_community_summaries(level=community_level)

    # 각 커뮤니티 요약에 대해 LLM이 중간 답변 + 유용성 점수 생성
    MAP_PROMPT = """
    쿼리: {query}
    커뮤니티 요약: {community_summary}

    이 커뮤니티 요약이 쿼리에 얼마나 관련 있는지 평가하고 중간 답변을 작성하세요.

    출력:
    {{
        "intermediate_answer": "이 커뮤니티 관점의 답변",
        "helpfulness_score": 0~1,  # 1=직접 관련, 0.5=간접, 0=무관
        "community_id": {community_id},
        "analysis_space": "가장 관련된 분석공간"
    }}
    """

    # asyncio로 완전 병렬화
    import asyncio
    map_tasks = [
        generate_intermediate_answer(query, summary, MAP_PROMPT)
        for summary in community_summaries
    ]
    intermediate_results = await asyncio.gather(*map_tasks)

    # === Phase 2: 필터링 (Helpfulness Score 기준) ===
    HELPFULNESS_THRESHOLD = 0.4  # config에서 로드

    useful_results = [
        r for r in intermediate_results
        if r.helpfulness_score > HELPFULNESS_THRESHOLD
    ]
    useful_results.sort(key=lambda r: r.helpfulness_score, reverse=True)
    useful_results = useful_results[:MAX_RESULTS]

    # === Phase 3: Reduce (최종 답변 종합) ===
    REDUCE_PROMPT = """
    쿼리: {query}

    다음 {n}개 커뮤니티의 중간 답변(유용성 점수 기준 정렬):
    {sorted_intermediate_answers}

    이 답변들을 종합하여 일관되고 포괄적인 최종 답변을 작성하세요.
    각 인사이트에 출처 커뮤니티를 명시하세요.
    """
    final_answer = await synthesize_final_answer(query, useful_results, REDUCE_PROMPT)
    return SearchResult(answer=final_answer, sources=useful_results)
```

## 분석공간별 필터 (G5 보조)

```python
def filter_by_analysis_space(results: list, target_space: str) -> list:
    """
    6개 분석공간 중 특정 공간에 집중하여 필터링

    target_space: "hierarchy" | "temporal" | "recursive" |
                  "structural" | "causal" | "cross_space"
    """
    space_community_map = {
        "hierarchy": "C0 루트 커뮤니티 우선 (전체 개요)",
        "temporal": "precedes 관계가 많은 커뮤니티 우선",
        "structural": "엣지 밀도 높은 커뮤니티 우선",
        "causal": "인과 관계(extends/created_by) 많은 커뮤니티 우선",
        "cross_space": "inter_community_edges 많은 커뮤니티 우선",
    }
    # 분석공간별 가중치 조정하여 필터
    return sorted(results,
                  key=lambda r: r.analysis_spaces.get(target_space, {}).get("score", 0),
                  reverse=True)
```

## 로컬 서치: ReACT 루프

```
Thought: 특정 엔티티에 대한 질문 → L0~L2 분류
Act: local_search(query, depth=N홉)
Observe: 서브그래프 결과 (엔티티, 관계, 커뮤니티)

Thought: 추가 컨텍스트 필요 시
Act: DRIFT(query, global_ctx)  # L2만
Observe: 확장 컨텍스트

Thought: 충분한 정보 수집 → 보고서 생성
```

최대 3회 Act-Observe 반복.

## 보고서 템플릿

```markdown
---
title: "{주제} GraphRAG 분석"
type: graphrag-report
query: "{원본 쿼리}"
search_level: "{L0|L1|L2|L3}"
community_level: "{C0|C1|C2|C3}"
communities: [{관련 커뮤니티 ID}]
analysis_spaces: [{주요 분석공간}]
date: "{ISO-8601}"
tags: [graphrag, analysis]
---

# {주제} GraphRAG 분석

## 핵심 인사이트

{상위 3-5개 인사이트 (커뮤니티/노드 증거 포함, 분석공간 태그)}

## 커뮤니티 맵

| 커뮤니티 | 레벨 | 핵심 주제 | 분석공간 | 관련도 |
|---------|------|---------|---------|-------|
| {커뮤니티명} | C{n} | {요약} | {공간} | {점수} |

## 주요 노드 (중심성 TOP 10)

| 노드 | 클래스 | 커뮤니티 | 중심성 | beta-0/beta-1 |
|------|-------|---------|-------|------|
| [[{노트명}]] | {class} | {커뮤니티} | {점수} | {값} |

## 검색 과정

| 단계 | 방법 | 관찰 |
|------|------|------|
| 1 | {local/global} L{n} | {Observe 요약} |

---
← [[GraphRAG-Analysis-MOC|분석 목록]]
```

## 저장 경로

```
Library/Research/GraphRAG-Analysis/{YYYY-MM-DD}-{주제}-graphrag.md
```

## DA 검증

```
검증 기준:
- 인사이트 최소 3개
- 각 인사이트에 그래프 증거 (노드/커뮤니티) 포함
- 유용성 점수 > helpfulness_threshold인 커뮤니티만 포함
- 깨진 [[wikilink]] 0개

→ ACCEPTABLE: 보고서 저장
→ CONCERN: 누락 섹션 보완 후 재검증
```

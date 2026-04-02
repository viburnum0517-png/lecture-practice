---
name: km-graphrag-ontology-llm-extension
description: GraphRAG LLM 동적 확장 프롬프트(G1-3), vault 특화 확장 클래스 예시, 3층 추상화(도메인→메타→Universal Principals), 온톨로지 앵커링. km-graphrag-ontology 서브파일.
---

# 5-7. LLM 동적 확장 · 3층 추상화 · 온톨로지 앵커링

← [04-build-methodology.md](04-build-methodology.md) | → [06-schema-and-pitfalls.md](06-schema-and-pitfalls.md)

---

## 5. LLM 동적 확장 프롬프트

### 확장 프롬프트 (G1-3에서 사용)

```
당신은 Obsidian vault의 지식 그래프 온톨로지 전문가입니다.
TBox-ABox 이중 구조 설계 전문가로, 4구성요소(클래스/속성/관계/공리)로 온톨로지를 정의합니다.

## 현재 TBox

### 클래스 (10개)
concept, person, tool, project, series, event, organization, technique, model, paper

### 관계 타입 (8개)
extends, contrasts, cites, belongs_to, precedes, used_by, created_by, related_to

### 주요 공리
- 모든 model은 created_by로 organization/person에 연결
- contrasts는 항상 양방향

## 분석할 vault 샘플 노트 (20개)

{sample_notes_content}

## 작업

1. 각 샘플 노트에서 등장하는 주요 개념/관계를 파악하세요.
2. 기존 10개 클래스로 분류하기 어려운 개념을 식별하세요.
3. 기존 8개 관계 타입으로 표현하기 어려운 관계를 식별하세요.
4. 신규 타입을 4구성요소로 제안하세요 (클래스 최대 5개, 관계 최대 4개).

## 제안 기준

**제안 가능:**
- 샘플 노트 중 최소 2개 이상에서 등장
- 기존 타입과 의미 중복 < 50%
- vault 도메인 특성 반영 (AI/PKM/글쓰기)

**제안 불가:**
- 기존 클래스의 하위 개념 (예: "llm_model" → model 하위)
- 단 1개 노트에서만 등장
- 너무 광범위 ("thing", "item")

## 출력 형식 (JSON)

{
  "analysis": {
    "coverage_with_base_ontology": "X%",
    "uncovered_patterns": ["패턴1"],
    "axiom_gaps": ["누락된 공리"]
  },
  "proposed_classes": [
    {
      "id": "타입ID",
      "label": "한국어 레이블",
      "properties": ["속성1", "속성2"],
      "description": "설명 (1문장)",
      "examples": ["예시1"],
      "axioms": ["이 클래스에 적용되는 규칙"],
      "evidence_notes": ["근거 노트 경로"],
      "distinct_from_existing": "기존 클래스와의 차이점"
    }
  ],
  "proposed_relations": [
    {
      "id": "타입ID",
      "label": "한국어 레이블",
      "directed": true,
      "source_classes": ["허용 source 클래스"],
      "target_classes": ["허용 target 클래스"],
      "axiom": "이 관계의 공리",
      "evidence_notes": ["근거 노트 경로"]
    }
  ]
}
```

### 확장 클래스 예시 (tofukyung vault 특화)

| 클래스 ID | 레이블 | 속성 | 공리 | 배경 |
|---------|--------|------|------|------|
| `essay` | 에세이 | author, platform | author는 반드시 person | Mine/Essays 콘텐츠 |
| `thread_post` | 스레드 글 | platform, date | platform ∈ {Threads, Twitter} | Mine/Threads |
| `workflow` | 워크플로우 | phases, tools | 최소 2개 이상의 단계 필요 | km-workflow 스킬 문서 |
| `dataset` | 데이터셋 | size, modality | created_by person/organization 필수 | 논문 관련 노트 |
| `implements` | 구현 관계 | — | source: project/tool, target: concept/technique | `tofu-at → Agent Teams 패턴` |

---

## 6. 3층 추상화 — 도메인 → 메타 → Universal Principals

> **이론적 배경**: `메타온톨로지-3층-추상화`

```
Level 3: Universal Principals (범용 원리)
         "도메인에 상관없이" 적용 가능
         예: "Core-Edge 소통이 시스템 성공을 결정한다"
              ↑ 귀납적 추상화 (반복 빌드 후 패턴 발견)
Level 2: Meta-Ontology (메타온톨로지)
         "온톨로지를 추출하기 위한 온톨로지"
         도메인 공통 패턴 집합
              ↑ 도메인 비교 및 귀납
Level 1: Domain-Specific Ontology — 이 스킬이 정의하는 레이어
         Second_Brain vault의 AI/강의/업무 지식
              ↑ 실전 경험 축적
Level 0: Raw Data (Obsidian 노트들)
```

### 반복 빌드 시 메타온톨로지 귀납

GraphRAG를 반복 실행하면서 **메타온톨로지 패턴**이 귀납적으로 드러난다:

```python
# 반복 빌드에서 관찰할 메타온톨로지 신호
META_ONTOLOGY_SIGNALS = {
    # 여러 도메인에서 반복 등장하는 클래스 패턴
    "recurring_classes": [],     # 반복 등장 클래스 → Level 2 후보
    "recurring_relations": [],   # 반복 등장 관계 → Level 2 후보
    "universal_patterns": [],    # 도메인 무관 패턴 → Level 3 후보

    # 예시 귀납 패턴:
    # "Hub 노트는 항상 여러 도메인을 bridge한다"
    # → Level 2: "브리지 개념은 cross-domain 관계를 많이 가진다"
    # → Level 3: "Core 요소는 Edge 요소보다 연결 수가 높다"
}
```

---

## 7. 온톨로지 앵커링 — 프롬프트 해석 가이드레일

> **이론적 배경**: `도메인-온톨로지-구축-5단계` §프롬프트-앵커링

온톨로지는 단순 스키마가 아니라 **AI의 프롬프트 해석 공간을 제한하는 가이드레일**이다.

```python
# G4 검색 시 온톨로지 앵커링 적용
def anchor_query_to_ontology(query: str, ontology: dict) -> str:
    """
    쿼리를 온톨로지 클래스/관계로 재해석하여 시멘틱 드리프트 방지

    예: "GraphRAG에 대해 알려줘"
    → 온톨로지 없음: 일반적인 GraphRAG 설명 생성
    → 온톨로지 앵커링:
       - 클래스 탐지: concept(GraphRAG), technique(Leiden), tool(NetworkX)
       - 관계 탐지: extends(GraphRAG → RAG), used_by(Leiden → GraphRAG)
       - 공리 적용: "GraphRAG는 AI/ML 도메인에 한정"
    """
    # 쿼리에서 언급된 클래스/관계 식별
    anchors = {
        "classes": [],
        "relations": [],
        "axiom_constraints": []
    }

    all_class_ids = [c["id"] for c in ontology["tbox"]["classes"]]
    for class_id in all_class_ids:
        if class_id in query.lower():
            anchors["classes"].append(class_id)

    return f"""
    쿼리: {query}
    온톨로지 앵커:
    - 탐지된 클래스: {anchors['classes']}
    - 도메인: {DOMAIN_SCOPE['primary_domains']}
    - 적용 공리: {anchors['axiom_constraints']}

    이 온톨로지 컨텍스트 내에서만 답변하세요.
    """
```

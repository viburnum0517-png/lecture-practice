---
name: km-graphrag-ontology-tbox
description: GraphRAG TBox 레이어: 온톨로지 4구성요소(클래스/속성/관계/공리), 10개 클래스, 8개 관계 타입, 공리, JSON 스키마. km-graphrag-ontology 서브파일.
---

# 1. TBox — 개념 정의 레이어

← [SKILL.md](SKILL.md) | → [02-abox-extraction.md](02-abox-extraction.md)

---

## 온톨로지의 4구성요소

TBox는 4가지 구성요소로 완성된다:

```
1. 클래스 (Classes/Concepts)
   도메인의 핵심 개념 범주
   예: concept, person, tool, project...

2. 속성 (Properties)
   각 클래스가 가지는 특성
   예: concept.domain, person.affiliation, tool.version

3. 관계 (Relations)
   클래스 간 연결 타입
   예: extends, created_by, belongs_to...

4. 공리 (Axioms)
   도메인 규칙과 제약
   예: "모든 model은 반드시 organization 또는 person에 의해 생성된다"
```

---

## TBox: 클래스 정의 (10개)

| # | 클래스 | 속성 | 설명 | vault 예시 |
|---|--------|------|------|-----------|
| 1 | **concept** | domain, abstraction_level | 추상적 개념, 이론 | `강화학습`, `RAG`, `Context Engineering` |
| 2 | **person** | affiliation, role | 인물 (연구자, 저자, 사상가) | `Andrej Karpathy`, `김재경`, `Hinton` |
| 3 | **tool** | version, category, platform | 소프트웨어, 프레임워크, API | `Claude Code`, `Obsidian`, `NetworkX` |
| 4 | **project** | status, scope | 프로젝트, 이니셔티브, 시스템 | `얼룩소 아카이브`, `GraphRAG`, `tofu-at` |
| 5 | **series** | episode_count, frequency | 연재 시리즈, 시퀀스 | `MW 강의 시리즈`, `AI-연구 노트 시리즈` |
| 6 | **event** | date, venue | 이벤트, 발표, 컨퍼런스, 출시 | `NeurIPS 2024`, `GPT-4 출시 (2023-03)` |
| 7 | **organization** | type, country | 기업, 연구소, 학교, 팀 | `Anthropic`, `OpenAI`, `카카오` |
| 8 | **technique** | complexity, paradigm | 알고리즘, 방법론, 기법 | `Louvain`, `LoRA`, `Chain-of-Thought` |
| 9 | **model** | provider, version, modality | AI/ML 모델, 아키텍처 | `Claude Opus 4.5`, `GPT-5.2`, `BERT` |
| 10 | **paper** | authors, year, venue | 학술 논문, 기술 보고서 | `Attention Is All You Need` |

---

## TBox: 관계 타입 정의 (8개)

| # | 관계 | 방향 | 공리 | source → target 예시 |
|---|------|------|------|---------------------|
| 1 | **extends** | A → B | A는 B와 동일한 클래스 범주 | `LoRA → PEFT` |
| 2 | **contrasts** | A ↔ B | 대조 관계는 반드시 대칭 | `RAG ↔ Fine-tuning` |
| 3 | **cites** | A → B | 인용 출처 B는 반드시 존재해야 함 | `노트A → 노트B` |
| 4 | **belongs_to** | A → B | B는 반드시 series, project, organization 중 하나 | `GPT-5.2 → OpenAI` |
| 5 | **precedes** | A → B | A와 B는 같은 클래스여야 함 | `GPT-4 → GPT-5.2` |
| 6 | **used_by** | A → B | A는 tool 또는 technique, B는 person/project/org | `NetworkX → GraphRAG` |
| 7 | **created_by** | A → B | B는 반드시 person 또는 organization | `Claude Code → Anthropic` |
| 8 | **related_to** | A ↔ B | 의미적 관련성 (약한 관계, 방향 없음) | `Obsidian ↔ PKM` |

---

## TBox: 공리 (Axioms)

```python
# ontology.json의 axioms 섹션
AXIOMS = [
    "모든 model은 created_by 관계로 organization 또는 person에 연결되어야 한다",
    "paper는 person 저자(created_by)가 최소 1명 이상 있어야 한다",
    "series는 최소 2개 이상의 노트를 belongs_to로 포함해야 한다",
    "contrasts 관계는 항상 양방향(반드시 B→A도 존재)이어야 한다",
    "precedes 관계에서 source와 target은 동일한 클래스여야 한다",
    "used_by의 source는 tool 또는 technique만 허용된다",
]
```

---

## TBox JSON 스키마

```json
{
  "tbox": {
    "classes": [
      {
        "id": "concept",
        "label": "개념",
        "description": "추상적 개념, 아이디어, 이론",
        "properties": ["domain", "abstraction_level"],
        "examples": ["강화학습", "RAG", "Context Engineering"],
        "extraction_hint": "~이란, ~개념, ~이론, ~방법론 패턴에 해당하는 추상 명사"
      }
    ],
    "relations": [
      {
        "id": "extends",
        "label": "확장",
        "directed": true,
        "source_classes": ["concept", "technique", "model"],
        "target_classes": ["concept", "technique", "model"],
        "weight_default": 1.5,
        "axiom": "source와 target은 동일한 클래스 범주",
        "extraction_hint": "~를 발전시킨, ~의 확장, ~에서 영감 받은"
      }
    ],
    "axioms": []
  }
}
```

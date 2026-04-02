---
name: km-graphrag-ontology-schema-pitfalls
description: GraphRAG ontology.json 최종 스키마(전체 구조), 온톨로지 설계 5대 함정(DA 적용), 참조 스킬. km-graphrag-ontology 서브파일.
---

# 8-9. ontology.json 스키마 · 5대 함정 · 참조 스킬

← [05-llm-extension.md](05-llm-extension.md) | → [SKILL.md](SKILL.md)

---

## 8. ontology.json 최종 스키마

```json
{
  "version": "2.0",
  "created_at": "2026-03-16T00:00:00Z",
  "updated_at": "2026-03-16T00:00:00Z",
  "vault": "Second_Brain",
  "domain_scope": {
    "primary": ["AI/ML", "강의", "글쓰기", "업무"],
    "boundary": "Obsidian vault 내 AI/강의/업무 관련 지식"
  },
  "tbox": {
    "classes": [
      {
        "id": "concept", "label": "개념",
        "properties": ["domain", "abstraction_level"],
        "axioms": [],
        "examples": ["강화학습", "RAG"]
      }
    ],
    "relations": [
      {
        "id": "extends", "label": "확장",
        "directed": true,
        "source_classes": ["concept", "technique", "model"],
        "target_classes": ["concept", "technique", "model"],
        "weight_default": 1.5,
        "axiom": "source와 target은 동일한 클래스 범주"
      }
    ],
    "axioms": [
      "모든 model은 created_by로 organization/person에 연결",
      "contrasts는 항상 양방향"
    ]
  },
  "abox_extraction_rules": {
    "frontmatter_to_class": "infer_class() 함수 적용",
    "wikilink_to_cites": "모든 [[...]] → cites 관계",
    "tag_to_belongs_to": "모든 #태그 → belongs_to 관계"
  },
  "meta_edge_rules": {
    "min_confidence": 0.7,
    "max_age_days": 180,
    "min_cooccurrence": 2
  },
  "extensions": {
    "classes": [],
    "relations": [],
    "da_approved": false,
    "coverage": 0.0
  },
  "meta_ontology_signals": {
    "recurring_classes": [],
    "recurring_relations": [],
    "universal_patterns": []
  }
}
```

저장 경로: `.team-os/graphrag/ontology.json`

---

## 온톨로지 설계 5대 함정 (DA 적용)

| 함정 | 증상 | 대응 |
|------|------|------|
| 과도한 일반화 | 모든 도메인에 쓰려다 어디서도 안 맞음 | 스코핑 단계에서 vault 도메인으로 한정 |
| 공리 누락 | AI가 예외 케이스에서 오판 | "이 규칙이 깨지는 경우" 반드시 명시 |
| 속성 폭발 | 수백 개 속성으로 관리 불가 | 실제 판단에 영향 주는 속성만 (클래스당 5개 이하) |
| 관계 방향 오류 | A→B인지 B→A인지 혼동 | 모든 관계에 방향과 공리 명시 |
| 정적 유지 | 도메인 변화에 온톨로지 미반영 | 버전 관리 체계 + 변경 이유 필수 기록 |

---

## 참조 스킬

| 스킬 | 관계 |
|------|------|
| `km-graphrag-workflow.md` | G1 Phase에서 이 스킬 호출 |
| `km-rules-engine.md` | DA 검증 패턴 상세 |
| `km-batch-python.md` | G6 frontmatter 동기화 프로토콜 |

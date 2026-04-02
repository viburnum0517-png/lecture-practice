# Phase G1: TBox 구축 (온톨로지 생성/갱신)

**목적**: TBox 구성요소(클래스/속성/관계/공리) 정의 + ABox 추출 규칙 수립 + 5단계 방법론 적용.
**상세 스킬**: `km-graphrag-ontology.md` 참조

## TBox/ABox 구조 확립

```
G1 = TBox 레이어 구축
G2 = ABox 레이어 구성 (실제 데이터)
G1 + G2 완료 = Knowledge Graph 완성
```

## G1-1. 스코핑: 도메인 범위 확정

```python
# vault 도메인 경계 명시 (5단계 방법론 1단계)
DOMAIN_SCOPE = {
    "vault": "Second_Brain",
    "primary_domains": ["AI/ML", "강의", "글쓰기", "업무"],
    "boundary": "Obsidian vault 내 AI/강의/업무 관련 지식",
}
```

## G1-2. vault 분석 (2단계: 인터뷰 대체)

```bash
# 자주 사용되는 태그 → 클래스 후보
python3 .team-os/graphrag/scripts/sample_vault.py \
  --vault "$VAULT" \
  --n 20 \
  --strategy stratified
```

## G1-3. 기본 TBox 로드 (3단계: 초안)

```python
# .team-os/graphrag/scripts/load_ontology.py
import json

# TBox 기본값 (온톨로지 없으면 이 값 사용)
DEFAULT_TBOX = {
    "classes": [
        "concept", "person", "tool", "project", "series",
        "event", "organization", "technique", "model", "paper"
    ],
    "relations": [
        "extends", "contrasts", "cites", "belongs_to",
        "precedes", "used_by", "created_by", "related_to"
    ],
    "axioms": [
        "모든 model은 created_by로 organization/person에 연결",
        "contrasts는 항상 양방향"
    ]
}

# ABox 추출 규칙
DEFAULT_ABOX_RULES = {
    "frontmatter_to_class": True,
    "wikilink_to_cites": True,
    "tag_to_belongs_to": True,
    "named_graph_context": True,  # Named Graph 컨텍스트 추가
}
```

## G1-4. LLM 동적 확장 (4단계: 검증 포함)

**프롬프트 참조**: `km-graphrag-ontology.md` &sect;LLM 동적 확장 프롬프트

- 20개 샘플 노트 → LLM 분석
- 기존 TBox로 표현 불가한 도메인 특화 개념 탐지
- 4구성요소(클래스/속성/관계/공리)로 신규 타입 제안

## G1-5. DA 검증 (검증 루프)

```
DA 기준 (km-graphrag-ontology.md §DA 검증 루프):
- 의미적 일관성: 공리 간 모순 없음
- 완전성: 샘플 노트 90% 이상 TBox로 표현 가능
- 최대 3회 수정 루프

→ ACCEPTABLE: ontology.json 저장 + 동결
→ CONCERN: 이슈 수정 후 재검증
```

## G1-6. ontology.json 저장 (5단계: 버전 관리)

```bash
# .team-os/graphrag/ontology.json
{
  "version": "2.0",
  "tbox": { "classes": [...], "relations": [...], "axioms": [...] },
  "abox_extraction_rules": { ... },
  "meta_edge_rules": { "min_confidence": 0.7, "max_age_days": 180 },
  "extensions": { "classes": [], "relations": [], "da_approved": false }
}
```

변경 이력: `.team-os/graphrag/ontology-changelog.md`에 날짜 + 이유 + 성능 지표 기록.

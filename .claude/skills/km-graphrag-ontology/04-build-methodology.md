---
name: km-graphrag-ontology-build-methodology
description: GraphRAG 5단계 온톨로지 구축 방법론: 스코핑→vault 분석→초안→DA 검증→반복 정제. validate_ontology_da() 함수 포함. km-graphrag-ontology 서브파일.
---

# 4. 5단계 온톨로지 구축 방법론

← [03-meta-edge.md](03-meta-edge.md) | → [05-llm-extension.md](05-llm-extension.md)

> **이론적 배경**: `도메인-온톨로지-구축-5단계` §온톨로지-구축-프로세스

---

## 전체 흐름

```
[1단계: 스코핑] → [2단계: vault 분석/인터뷰] → [3단계: 초안] → [4단계: 검증] → [5단계: 정제]
```

---

## 1단계 — 스코핑: 온톨로지 범위 확정

```python
# G1-0: vault 도메인 경계 설정
DOMAIN_SCOPE = {
    "vault": "Second_Brain",
    "primary_domains": ["AI/ML", "강의", "글쓰기", "업무"],
    "boundary": "Obsidian vault 내 AI/강의/업무 관련 지식",
    "ai_decisions": [
        "어떤 개념이 어떤 도메인에 속하는가?",
        "두 노트는 어떤 관계인가?",
        "이 아이디어는 어떤 커뮤니티에 속하는가?"
    ]
}
```

> **핵심 원칙**: 온톨로지가 없으면 AI는 "GraphRAG란?"을 일반적으로 처리한다.
> 온톨로지가 있으면 AI는 도메인(AI/ML), 관계(extends Leiden), 커뮤니티(Graph Algorithms)를 기반으로 정밀하게 처리한다.

---

## 2단계 — vault 분석 (인터뷰 대체)

인터뷰 대신 **vault 구조 분석**으로 암묵지 추출:

```bash
# 자주 사용되는 태그 → 클래스 후보
"/mnt/c/Program Files/Obsidian/Obsidian.com" \
  tags --vault "/mnt/c/Users/treyl/Documents/Obsidian/Second_Brain" \
  format=json | jq 'sort_by(.count) | reverse | .[0:20]'

# 자주 등장하는 wikilink → 관계 후보
# [[A]]와 [[B]]가 같은 노트에 자주 등장 → related_to 관계 후보
```

```python
# 샘플 20개 노트 분석 (계층적 샘플링)
SAMPLING_STRATEGY = {
    "Mine/얼룩소": 4,
    "Mine/Essays": 2,
    "Library/Zettelkasten/AI-연구": 5,
    "Library/Zettelkasten/AI-도구": 3,
    "Library/Research": 4,
    "Library/Papers": 2,
}
# → 클래스 후보, 속성 후보, 관계 패턴 추출
```

---

## 3단계 — 초안: 4구성요소로 구조화

인터뷰/분석 결과를 4구성요소로 분류:

```
클래스: 자주 등장하는 개념 범주 → 10개 기본 클래스
속성: 각 클래스의 특성 → frontmatter 필드에서 추출
관계: 노트 간 연결 패턴 → wikilink, tag, 본문 관계
공리: 도메인 규칙 → "항상 ~해야 한다", "반드시 ~이어야 한다"
```

> **70% 완성도 원칙**: 처음부터 완벽할 필요 없다. 빠른 초안 → 피드백 → 정제.

---

## 4단계 — 검증: DA 검증 루프

```python
def validate_ontology_da(proposed_types, base_types, sample_notes):
    """
    온톨로지 확장 제안 DA 검증
    이론적 근거: 도메인-온톨로지-구축-5단계 §검증-체크리스트
    """
    issues = []

    for entity_class in proposed_types.get("classes", []):
        # 의미적 일관성: 공리 간 모순 없음
        if has_axiom_contradiction(entity_class, base_types):
            issues.append(f"[{entity_class['id']}] 공리 모순 발견")

        # 완전성: 최소 2개 샘플 노트에서 등장
        if len(entity_class.get("evidence_notes", [])) < 2:
            issues.append(f"[{entity_class['id']}] 증거 노트 부족 (최소 2개)")

        # ID 형식 검증
        import re
        if not re.match(r'^[a-z][a-z0-9_]*$', entity_class['id']):
            issues.append(f"[{entity_class['id']}] ID 형식 오류 (소문자+언더스코어)")

        # 기존 클래스와 중복 체크
        existing_ids = [t['id'] for t in base_types['tbox']['classes']]
        if entity_class['id'] in existing_ids:
            issues.append(f"[{entity_class['id']}] 기존 클래스와 중복")

    # 커버리지 검증: 샘플 노트의 90% 이상 온톨로지로 표현 가능
    coverage = calculate_coverage(sample_notes, base_types, proposed_types)
    if coverage < 90:
        issues.append(f"커버리지 부족: {coverage}% (최소 90% 필요)")

    # 최대 타입 수 초과
    if len(proposed_types.get("classes", [])) > 5:
        issues.append("신규 클래스 최대 5개 초과")
    if len(proposed_types.get("relations", [])) > 4:
        issues.append("신규 관계 타입 최대 4개 초과")

    return {
        "status": "ACCEPTABLE" if not issues else "CONCERN",
        "issues": issues,
        "coverage": coverage
    }
```

### DA 검증 루프

```
1. LLM 확장 제안 수신
2. validate_ontology_da() 실행
3. CONCERN 시:
   a. issues 목록 → 수정 요청
   b. 최대 3회 반복
   c. 3회 후에도 CONCERN → 기본 온톨로지만 사용
4. ACCEPTABLE 시:
   - 기본 + 확장 머지
   - ontology.json 저장 + 동결
```

---

## 5단계 — 반복 정제: 버전 관리

```markdown
## 온톨로지 변경 이력 (`.team-os/graphrag/ontology-changelog.md`)

| 버전 | 날짜 | 변경 내용 | 변경 이유 | 성능 지표 | DA 결과 |
|------|------|----------|----------|----------|--------|
| 1.0  | 2026-03-16 | 초기 기본 온톨로지 (10+8) | 초기 구축 | coverage: 87% | ACCEPTABLE |
| 1.1  | {날짜} | vault 특화 확장 추가 | {이유} | {지표} | {결과} |
```

> **경고**: 이전 버전을 항상 보존. 변경 이유 필수 기록. 정적 유지 금지.

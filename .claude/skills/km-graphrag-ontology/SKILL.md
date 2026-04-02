---
name: km-graphrag-ontology
description: Use when needing GraphRAG 온톨로지 설계 스킬. TBox(개념 정의)/ABox(인스턴스 사실) 분리 + 4구성요소 정의 + 메타엣지 + 5단계 구축 방법론 + 3층 추상화(도메인→메타→Universal Principals).
---

# GraphRAG Ontology Skill — TBox/ABox 기반 이론 재정립

vault 지식 그래프의 온톨로지를 **TBox(개념 정의) + ABox(인스턴스 사실)** 이중 구조로 설계.
TBox v3: 14개 엔티티 클래스 + 13개 관계 타입 + 7개 공리(Axiom) + 메타엣지 체계.

> **Source of Truth**: 현재 런타임 값은 `.team-os/graphrag/config.yaml`이 권위 소스입니다.
> 이 스킬 파일은 설계 방법론 참조용이며, 실제 클래스/관계/공리 수는 config.yaml을 확인하세요.
>
> **이론적 배경**: `온톨로지-TBox와-ABox`, `도메인-온톨로지-구축-5단계`, `메타엣지-정의와-4가지-의미`, `메타온톨로지-3층-추상화`

---

## 핵심 공식

```
TBox (개념 정의: 클래스 + 속성 + 관계 + 공리)
+
ABox (인스턴스 사실: 실제 엔티티 + 관계 데이터)
= Knowledge Graph (추론 가능한 완전한 지식 표현)
```

TBox만 있으면 빈 스키마. ABox만 있으면 의미 없는 레코드 집합.
**둘의 결합이 지식 그래프다.**

---

## 서브파일 목록

| 파일 | 내용 |
|------|------|
| [01-tbox-foundation.md](01-tbox-foundation.md) | TBox 레이어: 4구성요소, 설계 방법론, JSON 스키마 (현재 수치는 config.yaml 참조) |
| [02-abox-extraction.md](02-abox-extraction.md) | ABox 레이어: 인스턴스 추출, Frontmatter→ABox, Wikilink→관계 |
| [03-meta-edge.md](03-meta-edge.md) | 메타엣지: 4가지 의미, Reification, Named Graph, 하이퍼그래프 |
| [04-build-methodology.md](04-build-methodology.md) | 5단계 구축 방법론: 스코핑→분석→초안→검증→정제 + DA 검증 루프 |
| [05-llm-extension.md](05-llm-extension.md) | LLM 동적 확장 프롬프트, 3층 추상화, 온톨로지 앵커링 |
| [06-schema-and-pitfalls.md](06-schema-and-pitfalls.md) | ontology.json 최종 스키마, 5대 함정, 참조 스킬 |

---

## 빠른 참조

### TBox v3 현재 수치 (config.yaml 기준)
- **클래스 14개**: concept, person, tool, project, series, event, organization, technique, model, paper, framework, methodology, platform, policy
- **관계 13개**: extends, contrasts, cites, belongs_to, precedes, used_by, created_by, related_to, co_occurs, implements, depends_on, inspires, criticizes
- **공리 7개**: A1(비공백 name) A2(belongs_to 전이) A3(co_occurs 하이퍼엣지) A4(비반사) A5(DAG) A6(타입 제약) A7(시간 컨텍스트)

### 저장 경로
- 온톨로지: `.team-os/graphrag/ontology.json`
- 변경 이력: `.team-os/graphrag/ontology-changelog.md`

### 참조 스킬
| 스킬 | 관계 |
|------|------|
| `km-graphrag-workflow.md` | G1 Phase에서 이 스킬 호출 |
| `km-rules-engine.md` | DA 검증 패턴 상세 |
| `km-batch-python.md` | G6 frontmatter 동기화 프로토콜 |

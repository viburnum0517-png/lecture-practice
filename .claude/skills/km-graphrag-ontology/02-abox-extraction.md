---
name: km-graphrag-ontology-abox
description: GraphRAG ABox 레이어: 인스턴스 추출 규칙, Frontmatter→ABox 변환, Wikilink→관계 추출 코드. km-graphrag-ontology 서브파일.
---

# 2. ABox — 인스턴스 사실 레이어

← [01-tbox-foundation.md](01-tbox-foundation.md) | → [03-meta-edge.md](03-meta-edge.md)

---

ABox는 TBox에 정의된 클래스/관계를 사용하여 **실제 vault의 구체적 사실**을 기록한다.

## ABox 구성 프로세스

```
Obsidian 노트 → ABox 인스턴스 추출
│
├── Frontmatter → 클래스 분류 (entity_type, tags)
├── 본문 텍스트 → LLM 엔티티 추출 (Hub 노트)
├── Wikilink [[...]] → cites 관계
└── #태그 → belongs_to 관계
```

---

## 추출 규칙: Frontmatter → ABox

```python
def frontmatter_to_abox(frontmatter: dict, note_path: str) -> dict:
    """Obsidian frontmatter에서 ABox 인스턴스 생성"""
    instance = {
        "id": note_path,
        "class": infer_class(frontmatter),  # TBox 클래스 중 하나
        "properties": {
            "title": frontmatter.get("title", os.path.basename(note_path)),
            "tags": frontmatter.get("tags", []),
            "created": frontmatter.get("created", ""),
            "source": frontmatter.get("source", ""),
        }
    }
    return instance

def infer_class(frontmatter: dict) -> str:
    """TBox 클래스 자동 추론"""
    tags = frontmatter.get("tags", [])

    if "paper" in tags or "arxiv" in tags:
        return "paper"
    if "tool" in tags or "software" in tags:
        return "tool"
    if "person" in tags or "researcher" in tags:
        return "person"
    if "model" in tags or "LLM" in tags:
        return "model"
    # 기본값
    return "concept"
```

---

## 추출 규칙: Wikilink → ABox 관계

```python
def wikilinks_to_abox_relations(content: str, source_path: str) -> list:
    """Wikilink → ABox cites 관계"""
    import re
    relations = []

    # [[노트]] → cites
    for link in re.findall(r'\[\[([^\]|#]+)', content):
        relations.append({
            "source": source_path,
            "target": link,
            "relation": "cites",
            "weight": 1.0,
            "context": "wikilink"
        })

    return relations
```

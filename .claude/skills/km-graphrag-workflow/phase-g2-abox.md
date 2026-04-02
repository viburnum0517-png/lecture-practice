# Phase G2: ABox 구성 + Knowledge Graph 구축

**목적**: Obsidian 노트 → ABox 인스턴스 추출 + TBox와 결합 → Knowledge Graph.
이론: 6단계 파이프라인의 1~3단계 (청킹→엔티티 추출→KG 구축).

## G2-1. Hub 노트 식별

```python
# Hub 노트 기준: backlinks >= hub_threshold (기본 5)
def get_backlink_count(path, vault):
    result = subprocess.run(
        ["/mnt/c/Program Files/Obsidian/Obsidian.com",
         "backlinks", f"path={path}", "format=json"],
        capture_output=True, text=True
    )
    data = json.loads(result.stdout or "[]")
    return len(data)
```

## G2-2. Hub 노트 → LLM ABox 추출 (Self-Reflection 포함)

**Hub 노트**: 텍스트 청킹(600토큰/100토큰 오버랩) + LLM 추출 + Self-Reflection

```python
# Self-Reflection: "놓친 엔티티가 있는가?" 재확인 → 재현율(Recall) 향상
EXTRACTION_PROMPT = """
다음 노트에서 TBox에 정의된 클래스와 관계에 맞는 ABox 인스턴스를 추출하세요.

TBox (클래스/관계/공리):
{tbox_json}

노트 내용:
{note_content}

## 1차 추출 (JSON):
{
  "entities": [
    {"id": "노트경로|엔티티명", "class": "concept|person|...",
     "name": "엔티티명", "source_note": "경로", "properties": {}}
  ],
  "relations": [
    {"source": "id1", "target": "id2", "relation": "extends|cites|...",
     "weight": 1.0, "confidence": 0.9,
     "context": "출처 노트 경로",  # Named Graph 컨텍스트
     "axiom_validated": true}
  ]
}

## Self-Reflection: 놓친 엔티티가 있는가?
위 결과를 검토하고 누락된 중요 엔티티나 관계를 추가로 추출하세요.
특히 TBox 공리를 위반하는 관계는 제거하세요.
"""
```

## G2-3. 일반 노트 → 메타데이터 기반 ABox 추출

```python
def extract_abox_from_metadata(note_path, content, frontmatter):
    """
    Wikilink → cites 관계
    Tags → belongs_to 관계
    Frontmatter → 클래스 분류
    Named Graph 컨텍스트 자동 추가
    """
    import re
    instances = []
    relations = []

    # 클래스 분류 (ABox 인스턴스)
    entity_class = infer_class_from_frontmatter(frontmatter)
    instances.append({
        "id": note_path,
        "class": entity_class,
        "source_note": note_path,
        "properties": extract_properties(frontmatter)
    })

    # [[다른 노트]] → cites 관계 + Named Graph 컨텍스트
    wikilinks = re.findall(r'\[\[([^\]|#]+)', content)
    for link in wikilinks:
        relations.append({
            "source": note_path, "target": link,
            "relation": "cites", "weight": 1.0,
            "confidence": 1.0,              # wikilink = 확실한 인용
            "context": note_path,           # Named Graph: 이 노트의 관점
        })

    # #태그 → belongs_to 관계
    tags = frontmatter.get("tags", [])
    for tag in tags:
        relations.append({
            "source": note_path, "target": f"tag:{tag}",
            "relation": "belongs_to", "weight": 0.5,
            "confidence": 1.0, "context": note_path,
        })

    return instances, relations
```

## G2-4. N-ary 관계 처리 (Reification)

```python
# 3항 이상의 관계를 노드로 Reify
class ReifiedRelation:
    """관계 자체를 노드로 표현 (N-ary 관계 처리)"""
    def to_db_record(self):
        return {
            "id": self.id,
            "type": f"reified:{self.relation_type}",
            "participants": json.dumps(self.participants),
            "source_note": self.context,
            "is_reified": True
        }

def reify_nary_relation(entities, relation_type, context, properties=None):
    """
    N개 엔티티를 하나의 관계 노드로 묶기
    예: 세미나 발표 (presenter=A, topic=B, venue=C)
    """
    reified = ReifiedRelation(
        id=f"reified-{relation_type}-{hash(str(entities))}",
        relation_type=relation_type,
        participants=entities,
        context=context,
        properties=properties or {}
    )
    return reified
```

## G2-5. 배치 실행 (100개씩)

```python
def build_graph_batched(note_files, batch_size=100, delay=2.0):
    import time
    graph_data = {"nodes": [], "edges": [], "reified_nodes": []}

    for i in range(0, len(note_files), batch_size):
        batch = note_files[i:i+batch_size]
        print(f"  Batch {i//batch_size + 1}: {len(batch)} notes")

        for note in batch:
            is_hub = note in hub_notes
            if is_hub:
                # LLM + Self-Reflection (6단계 파이프라인 2단계)
                entities, relations = extract_abox_with_llm(note, tbox)
            else:
                # 메타데이터 기반 (빠른 처리)
                entities, relations = extract_abox_from_metadata(note, ...)

            graph_data["nodes"].extend(entities)
            graph_data["edges"].extend(relations)

        if i + batch_size < len(note_files):
            time.sleep(delay)

    return graph_data
```

## G2-6. SQLite DB 저장 (확장 스키마)

```sql
-- TBox 레이어 (스키마 정보)
CREATE TABLE tbox (
    id TEXT PRIMARY KEY,
    class_name TEXT,       -- 클래스 ID
    property_name TEXT,    -- 속성명
    axiom TEXT,            -- 공리
    updated_at TEXT
);

-- ABox 레이어 (인스턴스 = 노드)
CREATE TABLE nodes (
    id TEXT PRIMARY KEY,
    name TEXT,
    class TEXT,            -- TBox 클래스 참조
    source_note TEXT,
    properties TEXT,       -- JSON
    community_id INTEGER,
    community_level INTEGER,   -- C0~C3
    centrality REAL,
    betti_0 REAL,          -- TDA: β₀ 연결 컴포넌트
    created_at TEXT
);

-- ABox 레이어 (관계 = 엣지)
CREATE TABLE edges (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    source TEXT,
    target TEXT,
    relation TEXT,         -- TBox 관계 참조
    weight REAL,
    confidence REAL,       -- 추출 신뢰도
    context TEXT,          -- Named Graph 컨텍스트 (출처 노트)
    is_reified INTEGER DEFAULT 0,  -- Reified 관계 여부
    created_at TEXT,
    FOREIGN KEY(source) REFERENCES nodes(id),
    FOREIGN KEY(target) REFERENCES nodes(id)
);

-- 커뮤니티 요약
CREATE TABLE communities (
    id INTEGER PRIMARY KEY,
    level INTEGER,         -- C0=0, C1=1, C2=2, C3=3
    name TEXT,
    summary TEXT,
    analysis_spaces TEXT,  -- JSON: 6개 분석공간 매핑
    tda_betti_0 REAL,      -- β₀: 연결 컴포넌트 수
    tda_betti_1 REAL,      -- β₁: 1차원 루프 수 (순환 구조)
    member_count INTEGER,
    hub_node TEXT,
    helpfulness_scores TEXT,  -- JSON: 쿼리별 유용성 점수 캐시
    updated_at TEXT
);
```

## G2-7. 증분 갱신 모드

```python
# changed_files.txt 기준으로 해당 노트만 재처리
# 1. 기존 노드/엣지 삭제 (해당 source_note)
# 2. 새 노드/엣지 삽입
# 3. Reified 관계 재구성
# 4. 영향받는 커뮤니티 재계산 (G3)
```

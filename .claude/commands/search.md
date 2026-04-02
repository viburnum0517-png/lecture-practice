---
description: "vault 통합 검색 — GraphRAG 기반, quick(즉답) / deep(분석) 답변 깊이 선택"
allowedTools: Bash, Read, Glob, Grep
---

# /search — vault 통합 검색

$ARGUMENTS

<routing>
## Phase 0: 모드 결정

query = "$ARGUMENTS"

IF query가 비어있으면:
  → "사용법: `/search <질문>` or `/search --deep <질문>`"
  → "예시: `/search MCP란?` | `/search --deep 프롬프트 엔지니어링 기법 비교`"
  → 종료

### 플래그 파싱
- `--quick` 또는 `-q` → **QUICK** (플래그 제거 후 나머지가 query)
- `--deep` 또는 `-d` → **DEEP** (플래그 제거 후 나머지가 query)
- 플래그 없음 → **AUTO**

### AUTO 라우팅

DEEP: 문장형 5단어+, "~하려면/방법/비교/차이/관계/영향", 분석 요청("설명해줘/정리해줘"), 복수 개념("A vs B"), 방법론("어떻게/왜")
QUICK: 그 외 (키워드 1-3개, 정의형 "~란?", 노트 찾기)
</routing>

<search_engine>
## 공통 검색 엔진 — GraphRAG (QUICK/DEEP 동일)

**모든 검색은 GraphRAG를 사용합니다.** Obsidian 텍스트 검색이 아닙니다.

### 1차 — FastAPI 서버 (port 8400):
```bash
QUERY_ENCODED=$(python3 -c "import urllib.parse,sys; print(urllib.parse.quote(sys.argv[1]))" "${QUERY}")
curl -s "http://127.0.0.1:8400/api/search?q=${QUERY_ENCODED}&top_k=${TOP_K}&mode=hybrid&dense_weight=0.3&sparse_weight=0.4&decomposed_weight=0.15&entity_weight=0.15" --connect-timeout 3
```

### 2차 — CLI fallback (서버 미실행 시):
```bash
cd /home/tofu/AI && PYTHONPATH=".team-os/graphrag/scripts" python3 .team-os/graphrag/scripts/graph_search.py hybrid "${QUERY}" --rerank --top-k ${TOP_K} --json 2>/dev/null
```

### 3차 — 비상 폴백 (GraphRAG 전체 불가 시):
Obsidian MCP → Grep 순서로 폴백. 이 경우 답변에 "GraphRAG 서버 미실행으로 텍스트 검색 결과입니다" 명시.

### 모드별 파라미터
- **QUICK**: top_k=5, 노트 읽기 1-2개
- **DEEP**: top_k=10, 노트 읽기 3-5개
</search_engine>

<quick_mode>
## QUICK 모드 — 즉답 (3-5줄)

### 노트 읽기
검색 결과 상위 1-2개의 source_note만 Read:
- vault 경로: `/mnt/c/Users/treyl/Documents/Obsidian/Second_Brain/{source_note}`
- 실패 시: `/home/tofu/AI/{source_note}` 시도
- frontmatter + 첫 문단/핵심 섹션만 추출

### 출력
```
**답변:**
[3~5줄 직접 답변. 노트 내용 기반.]

**근거 노트:**
1. **[노트 제목]** — [핵심 한 줄] (`경로`)
2. **[노트 제목]** — [핵심 한 줄] (`경로`)
```
</quick_mode>

<deep_mode>
## DEEP 모드 — 상세 분석

### 노트 읽기 (CRITICAL)
검색 결과 상위 3-5개의 source_note를 실제 Read:
- vault 경로: `/mnt/c/Users/treyl/Documents/Obsidian/Second_Brain/{source_note}`
- 실패 시: `/home/tofu/AI/{source_note}` 시도
- 각 노트에서 제목, 요약, 핵심 섹션 추출

### 답변 합성
읽은 노트 내용을 종합하여 **질문에 직접 답변**. 번호 목록, 테이블, 단계별 설명 활용.

### 출력
```
## {질문 요약}

{답변 본문. 구조화된 분석.}

### 출처
1. [[노트1]] — {핵심 정보 1줄} (`경로`)
2. [[노트2]] — {핵심 정보 1줄} (`경로`)
3. [[노트3]] — {핵심 정보 1줄} (`경로`)
```
</deep_mode>

<constraints>
## 제약

- **읽기 전용**: 노트 생성/수정 금지
- **hallucination 금지**: 반드시 실제 노트 내용 기반
- **노트에 없는 내용**: "vault에 관련 자료가 없습니다" 명시
- **출처 필수**: 실제 읽은 노트 경로 표기
- **질문/스킬/에이전트 스폰 금지**: 직접 검색만 수행
- **상태 메시지 금지**: 바로 결과 출력
- Read 실패 시 건너뛰고 다음 노트 시도
- QUICK: 5줄 이내 + 출처 1-2개
- DEEP: 제한 없음 + 출처 3-5개

### 결과 없음
```
vault에서 "{query}" 관련 자료를 찾지 못했습니다.
/knowledge-manager로 자료를 수집해보세요.
```
</constraints>

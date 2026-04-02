---
name: km-environment-detection-phase3
description: Phase 3: Standard (Chroma 벡터검색) + Advanced (Neo4j+Ollama) 자동 설치 프로세스 및 부분 설치 지원
---

# Phase 3: 기능 활성화 (자동 설치 지원)

### 3.1 활성화 제안 프롬프트

**CRITICAL**: 사용자에게 선택권을 부여. 강제 설치 절대 금지.

```markdown
---

### ⚡ 추가 기능 활성화

현재 시스템에서 다음 기능을 추가로 활성화할 수 있습니다:

{Standard/Advanced 해당 기능 목록}

활성화하시겠습니까?
1. **자동 설치** - 지금 바로 설치를 진행합니다 (단계별 진행 상황 표시)
2. **나중에** - 지금은 현재 모드로 사용 (언제든 "RAG 설정"으로 재실행 가능)
3. **상세 정보** - 각 기능의 장단점 자세히 보기

> 어떤 선택이든 Knowledge Manager의 핵심 기능은 동일하게 작동합니다.
> 설치 중 문제가 생기면 자동으로 이전 상태로 복원됩니다.
```

### 3.2 자동 설치 프로세스 (Standard: Chroma 벡터 검색)

**대상**: Standard 이상 티어 (RAM 16GB+ 또는 dGPU 보유)

**사용자가 "자동 설치" 선택 시**, 아래 단계를 **Bash 도구로 실제 실행**:

#### Step 1: 사전 검사 (Pre-flight Check)

```bash
# Python 존재 확인
python --version 2>/dev/null || python3 --version 2>/dev/null

# pip 존재 확인
pip --version 2>/dev/null || pip3 --version 2>/dev/null

# Node.js/npx 존재 확인
npx --version 2>/dev/null
```

**사용자에게 표시:**
```markdown
### 📋 사전 검사 결과

| 항목 | 상태 | 필요 버전 |
|------|------|----------|
| Python | {✅ 3.x.x / ❌ 미설치} | 3.8+ |
| pip | {✅ 있음 / ❌ 미설치} | - |
| Node.js/npx | {✅ 있음 / ❌ 미설치} | 18+ |

{모두 ✅이면 → "모든 사전 조건이 충족되었습니다. 설치를 진행합니다."}
{하나라도 ❌이면 → "다음 항목을 먼저 설치해주세요: [미설치 목록]" + 설치 링크}
```

#### Step 2: Chroma 설치

```bash
# Chroma DB 설치
pip install chromadb

# 설치 확인
python -c "import chromadb; print(f'Chroma {chromadb.__version__} installed')"
```

**사용자에게 표시:**
```markdown
⏳ **[1/3]** Chroma DB 설치 중...
✅ **[1/3]** Chroma DB v{버전} 설치 완료
```

#### Step 3: MCP 서버 등록

```bash
# Claude Code에 Chroma MCP 서버 추가
claude mcp add chroma -- npx -y chroma-mcp --db-path ./chroma_data
```

**사용자에게 표시:**
```markdown
⏳ **[2/3]** MCP 서버 등록 중...
✅ **[2/3]** Chroma MCP 서버 등록 완료
```

#### Step 4: 연결 확인

```bash
# MCP 서버 연결 상태 확인
claude mcp list
```

**사용자에게 표시:**
```markdown
⏳ **[3/3]** 연결 확인 중...
✅ **[3/3]** Chroma MCP 서버 연결 성공!

---

### 🎉 벡터 검색 활성화 완료!

| 기능 | 이전 | 이후 |
|------|------|------|
| 관련 노트 발견율 | ~80% | **~92%** |
| 검색 방식 | 키워드 + wikilink | + **시맨틱 유사도** |
| 검색 시간 | <2초 | 2-3초 |

이제 "이 노트와 비슷한 내용 찾아줘" 같은 시맨틱 검색이 가능합니다.
Knowledge Manager가 자동으로 벡터 검색을 활용합니다.
```

#### 설치 실패 시 복원

```markdown
❌ Chroma 설치 중 오류가 발생했습니다.

**에러**: {에러 메시지}

자동 복원을 진행합니다...
✅ 이전 상태로 복원 완료. Knowledge Manager는 Basic 모드로 정상 작동합니다.

> 수동 설치를 원하시면 "RAG 설정 상세"를 입력해주세요.
```

### 3.3 자동 설치 프로세스 (Advanced: Neo4j + Ollama)

**대상**: Advanced 티어 (RAM 32GB+ AND dGPU VRAM 8GB+)

#### Step 1: 사전 검사 (Standard 검사 포함)

```bash
# Standard 사전 검사 (위와 동일)
# + 추가 검사:

# GPU VRAM 확인 (NVIDIA)
nvidia-smi --query-gpu=memory.total --format=csv,noheader 2>/dev/null

# Docker 확인 (Neo4j 컨테이너용, 선택)
docker --version 2>/dev/null
```

**사용자에게 표시:**
```markdown
### 📋 Advanced 사전 검사 결과

| 항목 | 상태 | 용도 |
|------|------|------|
| Standard 전체 | ✅ 통과 | Chroma 기반 |
| NVIDIA GPU | {✅ VRAM {X}GB / ⚠️ 미감지} | Ollama 추론 |
| Docker | {✅ 있음 / ⚠️ 없음 (직접 설치도 가능)} | Neo4j 컨테이너 |
```

#### Step 2: Neo4j 설치 (Docker 우선, 직접 설치 폴백)

**Docker 사용 가능 시:**
```bash
# Neo4j 컨테이너 실행
docker run -d --name neo4j-km \
  -p 7474:7474 -p 7687:7687 \
  -e NEO4J_AUTH=neo4j/knowledge-manager \
  neo4j:latest

# 연결 대기 (최대 30초)
sleep 10
curl -s http://localhost:7474 > /dev/null && echo "Neo4j ready"
```

**Docker 없으면:**
```markdown
Neo4j Desktop을 설치해주세요:
→ https://neo4j.com/download/
→ 설치 후 로컬 DB를 생성하고 시작해주세요 (bolt://localhost:7687)
→ 완료되면 "계속"을 입력해주세요.
```

**사용자에게 표시:**
```markdown
⏳ **[1/5]** Neo4j 그래프 DB 설정 중...
✅ **[1/5]** Neo4j 실행 확인 (bolt://localhost:7687)
```

#### Step 3: Neo4j MCP 등록

```bash
claude mcp add neo4j -- npx -y neo4j-mcp --uri bolt://localhost:7687 --user neo4j --password knowledge-manager
```

```markdown
⏳ **[2/5]** Neo4j MCP 서버 등록 중...
✅ **[2/5]** Neo4j MCP 서버 등록 완료
```

#### Step 4: Ollama + 임베딩 모델

```bash
# Ollama 존재 확인
ollama --version 2>/dev/null
```

**Ollama 없으면:**
```markdown
Ollama를 설치해주세요:
→ https://ollama.ai
→ 설치 후 "계속"을 입력해주세요.
```

**Ollama 있으면:**
```bash
# 임베딩 모델 다운로드
ollama pull nomic-embed-text

# 확인
ollama list
```

```markdown
⏳ **[3/5]** Ollama 임베딩 모델 다운로드 중...
✅ **[3/5]** nomic-embed-text 다운로드 완료 (~274MB)
```

#### Step 5: Chroma 설치 (Standard 과정 실행)

```markdown
⏳ **[4/5]** Chroma 벡터 DB 설치 중...
✅ **[4/5]** Chroma 설치 및 MCP 등록 완료
```

#### Step 6: 전체 연결 확인

```bash
claude mcp list
# chroma: connected
# neo4j: connected
```

```markdown
⏳ **[5/5]** 전체 시스템 연결 확인 중...
✅ **[5/5]** 모든 서비스 연결 성공!

---

### 🎉 풀 RAG 파이프라인 활성화 완료!

| 기능 | 이전 | 이후 |
|------|------|------|
| 관련 노트 발견율 | ~80% | **~97%** |
| 검색 방식 | 키워드 + wikilink | + **벡터 + 그래프** |
| 관계 탐색 | 직접 연결만 | **다단계 (A→B→C)** |
| 임베딩 | 없음 | **로컬 AI (Ollama)** |
| 검색 시간 | <2초 | 3-5초 |

이제 3축 하이브리드 검색이 가능합니다:
- **키워드** → 정확한 용어 매칭
- **벡터** → "비슷한 의미" 탐색
- **그래프** → "관계 경로" 추적

Knowledge Manager가 자동으로 최적의 검색 전략을 선택합니다.
```

### 3.4 부분 설치 지원

Advanced 티어지만 일부만 설치하고 싶을 때:

```markdown
### 선택적 설치

어떤 기능을 활성화하시겠습니까? (복수 선택 가능)

| # | 기능 | 설치 시간 | 디스크 | 효과 |
|---|------|----------|--------|------|
| A | Chroma (벡터 검색) | ~5분 | ~200MB | 발견율 80%→92% |
| B | Neo4j (그래프 검색) | ~10분 | ~500MB | 관계 탐색 가능 |
| C | Ollama (로컬 임베딩) | ~10분 | ~2-4GB | 클라우드 API 불필요 |

> 예시: "A" → Chroma만 설치, "A,C" → Chroma + Ollama, "전부" → A+B+C
```

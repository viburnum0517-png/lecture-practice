---
name: autoresearch-skill
description: autoresearch 패턴으로 스킬 품질을 자율 개선. 클론 후 업그레이드 + 보호 콘텐츠 식별 + keep/discard 루프.
---

# /autoresearch-skill - 스킬 자율 개선 루프

karpathy/autoresearch 패턴을 스킬 파일(.md)에 적용합니다.
코드 실험 대신 **스킬 품질 메트릭** 기반 keep/discard 판정.

$ARGUMENTS

## 사용법

```
/autoresearch-skill                           # 대화형으로 대상 선택
/autoresearch-skill deep-research.md          # 특정 스킬 지정
/autoresearch-skill deep-research.md 10       # 10회 iteration
/autoresearch-skill results                   # 결과 조회
```

## CRITICAL: 보호 콘텐츠 규칙

**줄 수 감소보다 기능 보존이 우선합니다.**

### 절대 삭제/압축 금지 콘텐츠 (Protected Content)

| 유형 | 식별 패턴 | 이유 |
|------|----------|------|
| AskUserQuestion JSON 템플릿 | `AskUserQuestion`, `"question":`, `"options":` | Claude가 그대로 복사하는 실행 템플릿 |
| Bash/Python 실행 코드 | ` ```bash`, ` ```python` + 실제 명령어 | 재구성 시 오류 위험 |
| SQL 쿼리 | `SELECT`, `JOIN`, `sqlite3` | 정확한 구문 필요 |
| API 호출 템플릿 | `mcp__`, `curl`, `fetch(` | 엔드포인트/파라미터 정확도 |
| JSON 스키마/구조 | `{"key":`, 중첩 객체 | 구조 변형 시 파싱 실패 |
| 조건 분기 로직 | `if/else`, `→`, 의사결정 트리 | 로직 손실 위험 |

### 안전하게 압축 가능한 콘텐츠

| 유형 | 압축 방법 |
|------|----------|
| 장황한 설명문 | 핵심만 남기고 축약 |
| 중복 빈 줄 | 제거 |
| CHANGELOG/버전 히스토리 | 최신 버전만 유지 |
| 같은 내용의 반복 예시 | 대표 1개만 유지 |
| 서술형 규칙 → 테이블 | 테이블로 변환 |

---

## 실행 순서

### Step 0: 대상 파일 결정

`$ARGUMENTS` 처리:
- 파일명 지정 → `.claude/commands/` 또는 `.claude/skills/`에서 탐색
- "results" → Step 6으로 이동
- 비어있음 → AskUserQuestion으로 대상 선택

### Step 1: 클론 및 백업 (필수)

```bash
TAG=$(date +%Y%m%d-%H%M)
BACKUP_DIR="/tmp/autoresearch-skills/backups"
RESULTS_DIR="/tmp/autoresearch-skills/results"
mkdir -p "$BACKUP_DIR" "$RESULTS_DIR"

# 원본 백업 (롤백용)
cp "$TARGET_FILE" "$BACKUP_DIR/$(basename $TARGET_FILE .md)-$TAG.md"

# results.tsv 초기화
SKILL_NAME=$(basename "$TARGET_FILE" .md)
echo -e "iteration\tscore\tstatus\tdescription" > "$RESULTS_DIR/$SKILL_NAME.tsv"
```

**반드시 백업 파일 경로를 사용자에게 알려줄 것.**

### Step 2: 보호 콘텐츠 식별 (CRITICAL)

대상 파일을 읽고 보호 콘텐츠를 **먼저** 식별합니다.

```
보호 콘텐츠 스캔:
1. AskUserQuestion JSON 블록 → 시작/끝 줄 번호 기록
2. ```bash / ```python 코드 블록 중 실행 가능한 것 → 줄 번호 기록
3. SQL 쿼리 포함 블록 → 줄 번호 기록
4. API 호출 템플릿 → 줄 번호 기록
5. JSON 스키마/구조 정의 → 줄 번호 기록
6. 조건 분기 의사결정 트리 → 줄 번호 기록
```

**출력 형식:**
```markdown
## 🛡️ 보호 콘텐츠 목록

| # | 유형 | 줄 범위 | 설명 |
|---|------|--------|------|
| 1 | AskUserQuestion JSON | L157-L212 | 이미지 생성 옵션 4개 질문 |
| 2 | Python one-liner | L340-L342 | sqlite3 관계 조회 쿼리 |
| ... | | | |

총 보호 줄 수: {N}줄 / 전체 {M}줄 ({N/M*100}%)
압축 가능 줄 수: {M-N}줄
```

**사용자에게 보호 목록을 보여주고 확인받은 후 진행.**

### Step 3: 베이스라인 측정

평가기를 실행하여 현재 점수를 측정합니다.

**평가 항목 (0-100):**

| 카테고리 | 배점 | 측정 기준 |
|---------|------|----------|
| Frontmatter | 0-15 | name, description 필드 완성도 |
| Structure | 0-25 | H1/H2/H3 계층, 논리적 구조, 개요 섹션 |
| Content Quality | 0-25 | 코드 블록, 테이블, 예시, 규칙, 에러 처리 |
| Clarity | 0-20 | 번호 단계, 명령형 동사, 불릿, 모호성 없음 |
| Skills 2.0 준수 | 0-15 | 줄 수(≤500), 트리거 정보, 안티패턴 |

```bash
python3 /tmp/autoresearch-skills/evaluate_skill.py "$TARGET_FILE"
# 출력: skill_quality: {점수}
```

평가기가 없으면 위 기준으로 수동 채점 (각 항목 세부 기준은 evaluate_skill.py 참조).

베이스라인을 TSV에 기록:
```bash
echo -e "0\t{score}\tbaseline\tbaseline measurement" >> "$RESULTS_DIR/$SKILL_NAME.tsv"
```

### Step 4: 개선 루프 (N회 반복)

```
기본 반복 횟수: 5회 ($ARGUMENTS에서 지정 가능)

LOOP (i = 1..N):
  1. 현재 점수와 카테고리별 갭 분석
  2. 가장 큰 갭을 선택 (보호 콘텐츠 건드리지 않는 개선)
  3. 파일 수정 (한 번에 하나의 개선)

  ⚠️ 수정 전 체크:
  - 수정할 줄이 보호 콘텐츠 범위에 포함되는가? → 건너뛰기
  - 코드 블록 내부를 삭제/압축하려는가? → 건너뛰기
  - AskUserQuestion 구조를 변경하려는가? → 건너뛰기

  4. 평가기 재실행
  5. 판정:
     - new_score > old_score → KEEP
     - new_score <= old_score → DISCARD (마지막 good 버전으로 복원)
  6. TSV 기록: iteration\tscore\tstatus\tdescription
```

**개선 우선순위 (보호 콘텐츠 밖에서):**

| 우선순위 | 개선 유형 | 예상 효과 |
|---------|----------|----------|
| 1 | Frontmatter 추가/보완 | +5~15점 |
| 2 | 안티패턴/금지행동 섹션 추가 | +4~5점 |
| 3 | 에러 처리 섹션 추가 | +4~5점 |
| 4 | 트리거/when-to-use 추가 | +5점 |
| 5 | 서술 → 테이블 변환 | +3~5점 |
| 6 | 중복 빈 줄/CHANGELOG 제거 | +2~6점 (줄 수 감소) |
| 7 | 예시/사용법 섹션 보강 | +4~5점 |

### Step 5: 기능 검증 (CRITICAL)

루프 완료 후 **반드시** 실행:

```
검증 체크리스트:
□ 보호 콘텐츠 목록의 모든 항목이 수정 후에도 존재하는가?
□ AskUserQuestion JSON 블록이 원본과 동일한가?
□ 실행 코드 블록이 원본과 동일한가?
□ 워크플로우 단계 수가 동일한가?
□ 조건 분기 로직이 모두 보존되었는가?
```

검증 방법:
1. 보호 콘텐츠 목록의 각 항목을 Grep으로 확인
2. 원본 백업과 diff로 삭제된 보호 콘텐츠 확인
3. 하나라도 누락 시 → **즉시 원본 복원** + 해당 iteration discard

### Step 6: 결과 보고

```markdown
## autoresearch-skill 결과

**대상**: {스킬명}
**점수**: {baseline} → {final} (+{delta})
**줄 수**: {before} → {after}줄
**보호 콘텐츠**: {N}줄 보존 확인 ✅

### Iteration Log
| # | Score | Status | Description |
|---|-------|--------|-------------|
| 0 | {baseline} | baseline | baseline measurement |
| 1 | ... | keep/discard | ... |
| ... | | | |

### 보호 콘텐츠 검증
| # | 유형 | 상태 |
|---|------|------|
| 1 | AskUserQuestion JSON | ✅ 보존 |
| 2 | Python one-liner | ✅ 보존 |
| ... | | |

### 원본 백업
{backup_path}
```

---

## 핵심 규칙

- **보호 > 점수** — 보호 콘텐츠 삭제하면서 점수 올리기 금지
- **클론 필수** — 백업 없이 수정 시작 금지
- **단일 개선** — iteration당 하나의 변경만
- **keep/discard** — 점수 개선 시 keep, 동일/악화 시 discard
- **검증 필수** — 루프 완료 후 보호 콘텐츠 검증 생략 금지
- **모든 실험 기록** — TSV에 빠짐없이

## 금지 행동

| # | 금지 사항 |
|---|----------|
| 1 | ❌ 보호 콘텐츠 식별 없이 루프 시작 |
| 2 | ❌ AskUserQuestion JSON 블록 압축/삭제 |
| 3 | ❌ 실행 가능한 코드 블록(bash/python/sql) 산문으로 교체 |
| 4 | ❌ 백업 없이 파일 수정 |
| 5 | ❌ 검증 단계 생략 |
| 6 | ❌ 점수 올리기 위해 기능적 내용 삭제 |

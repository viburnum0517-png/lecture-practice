---
description: "인터뷰 기반 PRD 생성기 — 한 문장 → 5-6 인터뷰 → 4개 설계 문서"
allowedTools: AskUserQuestion, Read, Write, Glob, Grep, WebSearch, WebFetch, Agent, Bash
---

# /prd — 인터뷰 기반 PRD 생성기

> **Version**: 1.0.0
> 한 줄 아이디어를 5-6번의 인터뷰로 구체화하여 4개의 설계 문서를 자동 생성합니다.
> 참조 스킬: `prd-interview.md`, `prd-documents.md`

$ARGUMENTS

<mindset priority="HIGHEST">
천천히, 최선을 다해 작업하세요.

핵심 역할: **바이브 코더 눈높이의 PRD 생성기**
1. 사용자의 한 줄 아이디어를 분석
2. 5-6번의 인터뷰로 빈칸을 채움
3. 리서치를 병행하여 실현 가능한 설계 도출
4. 4개의 설계 문서를 자동 생성

<tone rule="ABSOLUTE">
바이브 코더 눈높이 — 기술 용어 없이 설명합니다.

| 원칙 | 설명 |
|------|------|
| AI가 리드 | 사용자가 고민하지 않도록, AI가 선택지를 제시하고 사용자가 결정 |
| 기술 용어 금지 | "REST API" → "서버에서 데이터 가져오기", "ORM" → "DB 연결 도구" |
| 복잡도 힌트 | 각 기능에 난이도 힌트 표시 (간단해요/좀 복잡해요/많이 복잡해요) |
| 비유 활용 | 추상 개념을 일상 비유로 전달 |
| 열린 질문 최소화 | "어떻게 할까요?" 대신 "A vs B 중 어떤 게 좋으세요?" |
</tone>

<mandatory_interaction rule="NEVER_SKIP">
AskUserQuestion 호출은 워크플로우 필수 입력입니다 — 권한 승인이 아닙니다.
bypassPermissions 모드와 무관하게, $ARGUMENTS 유무와 무관하게,
아래 Turn의 AskUserQuestion은 반드시 실행해야 합니다:

| Turn | 질문 주제 | 스킵 조건 |
|------|----------|----------|
| Turn 1 | 아이디어 명확화 (갭 분석 기반) | 스킵 불가 |
| Turn 2 | 기능 선택 + MVP 조합 | 스킵 불가 |
| Turn 3 | 데이터 모델 확인 | 스킵 불가 |
| Turn 4 | Phase 분리 확인 | 스킵 불가 |
| Turn 5 | 기술 스택 선택 | 스킵 불가 |

Why: 각 Turn은 이전 Turn의 응답에 의존합니다.
사용자 응답 없이 다음 Turn으로 진행하면 안 됩니다.
</mandatory_interaction>

절대 금지:
- 인터뷰 없이 문서 직접 생성 X
- 여러 Turn의 질문을 한꺼번에 묶어서 질문 X
- 사용자 응답 대기 없이 다음 Turn 진행 X
- 기술 용어로 사용자 혼란 유발 X
- 리서치 결과 없이 기능 추천 X
</mindset>

---

## Turn 0: 입력 분석 + 라우팅

```
IF $ARGUMENTS가 비어있음:
  AskUserQuestion(
    "어떤 앱/서비스를 만들고 싶으신가요?

    한 줄이면 충분합니다. 예시:
    - '반려동물 산책 기록 앱'
    - '팀 점심 메뉴 투표 서비스'
    - '중고 교재 거래 플랫폼'
    - '프리랜서 프로젝트 관리 도구'

    아이디어를 자유롭게 말씀해 주세요."
  )
  → 응답 대기 → idea에 저장

ELIF $ARGUMENTS가 존재:
  idea = $ARGUMENTS
```

---

## Turn 1: 아이디어 분석 + 동적 질문 생성

### Step 1-A: 갭 분석 (Gap Analysis)

사용자 입력에서 다음 5가지 항목의 존재 여부를 추출합니다:

| 항목 | 설명 | 예시 |
|------|------|------|
| **문제** | 해결하려는 문제/불편함 | "산책 기록이 없어서 불편" |
| **대상** | 사용자/타겟 | "반려동물 보호자" |
| **도메인** | 서비스 분야 | "펫케어", "교육", "이커머스" |
| **플랫폼** | 웹/모바일/데스크톱 | "모바일 앱" |
| **제약** | 예산/기간/기술 제약 | "혼자 개발", "2주 내" |

```
gap_result = {
  problem:  "입력에서 추출" 또는 "불명확",
  target:   "입력에서 추출" 또는 "불명확",
  domain:   "입력에서 추출" 또는 "불명확",
  platform: "입력에서 추출" 또는 "불명확",
  constraints: "입력에서 추출" 또는 "불명확"
}
```

### Step 1-B: 도메인 감지 (Domain Detection)

갭 분석의 domain 결과를 기반으로 도메인별 질문 템플릿을 로드합니다.
(참조: prd-interview.md의 도메인별 질문 템플릿)

| 도메인 | 추가 질문 예시 |
|--------|--------------|
| 이커머스 | 결제, 재고, 배송 |
| 소셜 | 팔로우, 피드, 알림 |
| 교육 | 진도, 퀴즈, 인증서 |
| SaaS | 구독, 팀, 권한 |
| 게임 | 점수, 랭킹, 보상 |
| 콘텐츠 | 에디터, 공유, 검색 |

### Step 1-C: 동적 질문 생성

```
unclear_items = gap_result에서 "불명확"인 항목들 필터링
domain_questions = 도메인별 필수 확인 질문 (1-2개)
questions = unclear_items + domain_questions

IF len(questions) > 3:
  questions = 우선순위 상위 3개만 선택

AskUserQuestion(
  "아이디어를 잘 이해했습니다! 몇 가지만 확인할게요.

  {questions를 번호 목록으로 포맷}

  각 질문에 간단히 답해주시면 됩니다.
  잘 모르겠으면 '알아서 해줘'라고 하셔도 돼요!"
)
→ 응답 대기 → clarification에 저장
```

### Step 1-D: 백그라운드 리서치 Batch 1

**질문 대기 중** 병렬로 실행:

```
[Background Research Batch 1]
WebSearch("{domain} app features 2026")
WebSearch("{domain} app UX trends")
→ research_batch_1에 저장 (상위 경쟁 앱 기능 목록, 최신 트렌드)
```

---

## Turn 2: 기능 선택

### Step 2-A: 기능 추천 생성

리서치 결과 + 사용자 입력을 기반으로 4개 핵심 기능을 도출합니다.

```
각 기능에 복잡도 힌트를 포함:

| 기능 | 설명 | 복잡도 |
|------|------|--------|
| {기능1} | {한 줄 설명} | 간단해요 🟢 |
| {기능2} | {한 줄 설명} | 간단해요 🟢 |
| {기능3} | {한 줄 설명} | 좀 복잡해요 🟡 |
| {기능4} | {한 줄 설명} | 많이 복잡해요 🔴 |

복잡도 기준 (참조: prd-interview.md):
- 간단해요 🟢: AI 코딩으로 1-2일 안에 완성
- 좀 복잡해요 🟡: AI 코딩으로 약 1주 소요
- 많이 복잡해요 🔴: AI 코딩으로 2주 이상 소요
```

### Step 2-B: MVP 조합 제안

```
3가지 MVP 조합 제시:

🅰️ 최소 MVP: {기능1} + {기능2}
   → "가장 빠르게 만들 수 있어요. 핵심만 먼저 검증!"
   → 예상 기간: {X}일

🅱️ 균형 MVP: {기능1} + {기능2} + {기능3}
   → "핵심 + 편의 기능. 사용자 만족도 UP"
   → 예상 기간: {X}일

🅲️ 최대 MVP: {기능1} + {기능2} + {기능3} + {기능4}
   → "풀 스펙! 시간은 좀 걸리지만 완성도 높아요"
   → 예상 기간: {X}일

AskUserQuestion(
  "{위 테이블 + MVP 조합 포맷}

  어떤 조합이 마음에 드세요? (A/B/C)
  기능을 추가하거나 빼고 싶으면 말씀해 주세요!"
)
→ 응답 대기 → selected_features에 저장
```

### Step 2-C: 백그라운드 리서치 Batch 2

**질문 대기 중** 병렬로 실행:

```
[Background Research Batch 2]
선택된 기능들에서 데이터 엔티티 추출:
- 각 기능의 핵심 데이터 객체 식별
- 객체 간 관계 분석
→ data_entities에 저장
```

---

## Turn 3: 데이터 모델 확인

### Step 3-A: ASCII ERD 생성

리서치 Batch 2 결과를 기반으로 데이터 모델을 시각화합니다.

```
[User]          [Post]           [Comment]
├─ id           ├─ id            ├─ id
├─ name         ├─ title         ├─ content
├─ email        ├─ content       ├─ user_id → [User]
└─ created_at   ├─ user_id → [User]  └─ post_id → [Post]
                └─ created_at

+ 필드 테이블:

| 엔티티 | 필드 | 타입 | 설명 |
|--------|------|------|------|
| User | id | 자동 | 고유 번호 |
| User | name | 텍스트 | 이름 |
| ... | ... | ... | ... |
```

### Step 3-B: 확인 질문

```
AskUserQuestion(
  "{ASCII ERD + 필드 테이블}

  위 데이터 구조가 맞는지 확인해 주세요.

  - 추가할 데이터가 있나요?
  - 빼고 싶은 항목이 있나요?
  - 괜찮으면 '확인'이라고만 해주세요!"
)
→ 응답 대기 → confirmed_data_model에 저장
```

### Step 3-C: 백그라운드 리서치 Batch 3

**질문 대기 중** 병렬로 실행:

```
[Background Research Batch 3]
기능 간 의존성 분석:
- 어떤 기능이 다른 기능에 의존하는지
- 순서가 중요한 기능 식별
→ dependency_graph에 저장
```

---

## Turn 4: Phase 분리 확인

### Step 4-A: Phase 자동 분류

의존성 분석 + 복잡도를 기반으로 3개 Phase로 자동 분류합니다.

```
📦 Phase 1 — MVP (먼저 만들기)
  {핵심 기능들} → 예상 {X}일

📦 Phase 2 — 확장 (사용자 반응 보고 추가)
  {확장 기능들} → 예상 {X}일

📦 Phase 3 — 고도화 (성장 후 추가)
  {고도화 기능들} → 예상 {X}일

AskUserQuestion(
  "{위 Phase 분류}

  이 순서가 괜찮으세요?
  - 기능을 다른 Phase로 옮기고 싶으면 말씀해 주세요.
  - 괜찮으면 '확인'이라고만 해주세요!"
)
→ 응답 대기 → confirmed_phases에 저장
```

### Step 4-D: 백그라운드 리서치 Batch 4

**질문 대기 중** 병렬로 실행:

```
[Background Research Batch 4]
기술 스택 리서치:
- WebSearch("{domain} app tech stack 2026 beginner friendly")
- 무료 배포 옵션 조사
- AI 코딩 호환성 조사
→ tech_research에 저장
```

---

## Turn 5: 기술 스택 선택

### Step 5-A: 스택 옵션 제시

리서치 Batch 4 결과를 기반으로 3가지 스택 옵션을 제시합니다.

```
각 옵션에 4가지 평가 기준 포함:

| 기준 | 🅰️ {옵션A} | 🅱️ {옵션B} | 🅲️ {옵션C} |
|------|-----------|-----------|-----------|
| 💰 비용 | 무료 | 무료 | 유료 가능 |
| 🤖 AI 코딩 호환 | 최고 | 좋음 | 보통 |
| 👥 커뮤니티 | 크다 | 보통 | 작다 |
| 🚀 배포 난이도 | 쉬움 | 보통 | 어려움 |

+ 각 옵션별 한 줄 추천 이유
```

### Step 5-B: 로그인 방식 선택

```
로그인 방식도 함께 질문:

🔑 로그인 방식:
  A. 이메일/비밀번호 (기본)
  B. 소셜 로그인 (구글/카카오)
  C. 로그인 없이 시작 (나중에 추가)

AskUserQuestion(
  "{스택 옵션 테이블 + 로그인 방식}

  기술 스택은 어떤 게 좋으세요? (A/B/C)
  로그인 방식은요? (A/B/C)

  잘 모르겠으면 '추천해줘'라고 하셔도 돼요!"
)
→ 응답 대기 → selected_stack, selected_auth에 저장
```

---

## Turn 6: 문서 생성

### Step 6-A: 4개 문서 생성

모든 인터뷰 결과를 종합하여 4개 문서를 생성합니다.
(참조: prd-documents.md의 각 문서 템플릿)

```
출력 경로: .team-os/artifacts/PRD/

생성 순서:
1. 01_PRD.md          ← 제품 요구사항 문서
2. 02_DATA_MODEL.md   ← 데이터 모델 설계서
3. 03_PHASES.md       ← 단계별 개발 계획
4. 04_PROJECT_SPEC.md ← 프로젝트 기술 명세서

각 문서는 prd-documents.md의 템플릿을 따르되,
인터뷰에서 수집한 실제 데이터로 채웁니다.
```

### Step 6-B: 출력 디렉토리 생성 + 문서 작성

```
Bash("mkdir -p .team-os/artifacts/PRD")

Write(".team-os/artifacts/PRD/01_PRD.md", ...)
Write(".team-os/artifacts/PRD/02_DATA_MODEL.md", ...)
Write(".team-os/artifacts/PRD/03_PHASES.md", ...)
Write(".team-os/artifacts/PRD/04_PROJECT_SPEC.md", ...)
```

---

## Turn 7: 완료 요약

### Step 7-A: 완성도 평가

```
인터뷰 결과를 기반으로 PRD 완성도를 자체 평가:

완성도: {X}/10

평가 기준:
| 항목 | 점수 | 사유 |
|------|------|------|
| 문제 정의 명확성 | {1-10} | {이유} |
| 기능 범위 적절성 | {1-10} | {이유} |
| 데이터 모델 완성도 | {1-10} | {이유} |
| 기술 스택 적합성 | {1-10} | {이유} |
| Phase 분리 합리성 | {1-10} | {이유} |
```

### Step 7-B: 최종 출력

```
사용자에게 최종 보고:

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅ PRD 생성 완료!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📊 완성도: {X}/10

📁 생성된 파일:
  .team-os/artifacts/PRD/
  ├── 01_PRD.md
  ├── 02_DATA_MODEL.md
  ├── 03_PHASES.md
  └── 04_PROJECT_SPEC.md

💡 개선 포인트:
  - {개선 가능한 부분 1}
  - {개선 가능한 부분 2}

🚀 다음 단계:
  1. PRD를 검토하고 수정할 부분이 있으면 말씀해 주세요
  2. 바로 개발을 시작하려면 01_PRD.md를 AI 코딩 도구에 붙여넣기
  3. /tofu-at으로 Agent Teams를 구성하여 병렬 개발도 가능합니다
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

---

## /tofu-at 연동 포인트

이 커맨드는 독립 실행이 기본이지만, `/tofu-at` 워크플로우에서도 호출됩니다.

```
/tofu-at 연동 시나리오:
  STEP 2.5에서 신규 프로젝트 감지 시 (기존 scan 대상 없음)
  → /prd를 자동 호출하여 PRD 생성
  → 생성된 PRD를 기반으로 Agent Teams 구성

독립 실행:
  /prd "반려동물 산책 기록 앱"
  → 인터뷰 7 Turn 실행
  → 4개 문서 생성
```

---

## Natural Language Triggers

다음 표현이 감지되면 이 커맨드를 자동 제안합니다:

| 트리거 | 예시 |
|--------|------|
| "PRD 만들어줘" | "새 앱 PRD 만들어줘" |
| "기획서 만들어줘" | "서비스 기획서 만들어줘" |
| "앱 기획해줘" | "투두 앱 기획해줘" |
| "설계 문서" | "프로젝트 설계 문서 필요해" |
| "요구사항 정리" | "앱 요구사항 정리해줘" |

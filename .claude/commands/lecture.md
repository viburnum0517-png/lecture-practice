---
description: "코딩을 모르는 제조업 실무자에게 AI를 가르치는 강의안을, AI 에이전트 팀이 만든다." — 리서치(Explore 병렬)→콘텐츠(GP 병렬)→포맷(typst+docx 병렬)→슬라이드(Lead 직접 /baoyu-slide-deck)→리뷰(DA 반론+Cross-Val 불일치 탐지+Ralph 루프)→동기화. MW2~MW4 실전 교훈 + MiroFish 벤치마크 반영. v2.3.0: 세션 밀도·런타임 동기화·도구 리터러시·몰입 플로우·프롬프트 문체·공유 산출물·정합성 게이트. "강의안 만들어줘", "MW3 강의", "슬라이드 생성", "청중 프로필" 등에 트리거.
allowedTools: Read, Write, Edit, Bash, Glob, Grep, Agent, AskUserQuestion, Skill, ToolSearch, WebFetch
---

# /lecture — 강의안 업데이트 파이프라인

> **Version**: 2.3.0 (MW4 내재화: 밀도·동기화·몰입·문체·산출물·정합성)

## 설계 철학

이 스킬은 **"AI가 가르치는 방법을 AI가 만든다"**는 재귀적 아이디어에서 출발했습니다.

**MW2에서 배운 것**: 단일 에이전트 순차 실행은 작동하지만, 핸드아웃↔실습파일 불일치 같은 교차 검증 문제를 사후에 수동으로 잡아야 했습니다. 사람이 빠뜨리는 것을 AI도 빠뜨립니다 — 같은 에이전트가 만든 것을 같은 에이전트가 검증하면 자기검열 한계에 부딪힙니다.

**MW3에서 배운 것**: 에이전트 팀(tofu-at)으로 전환하면서 세 가지가 달라졌습니다.
1. **리서치를 파이프라인 안으로** — MW3은 6주제 리서치를 별도 GPT-5.4 팀으로 수행했는데, 이것이 /lecture 바깥에서 일어나면 강의안과 리서치의 연결이 끊깁니다. 파이프라인 안에 리서치 Phase를 넣으면 "출처 없는 강의안"이 원천적으로 불가능해집니다.
2. **DA가 실제 버그를 잡았다** — 이미지 파일명 오류, 슬라이드 마커 재매핑 누락, CrossBeam 용어 불통일 등 4건의 CONCERN. 사람이 리뷰했으면 몇 건이나 잡았을지 모릅니다.
3. **Lead가 슬라이드를 직접 만들어야 한다** — /baoyu-slide-deck을 워커에 위임하면 68장 슬라이드의 일관성이 깨집니다. 슬라이드는 강의 전체 맥락을 가진 Lead만이 만들 수 있습니다.

이 스킬의 목표는 **"다음 강의안을 만들 때 이전 강의에서 배운 것이 자동으로 반영되는 것"**입니다. 수정계획서가 아니라 파이프라인 자체가 교훈을 학습합니다.

$ARGUMENTS

---

## 모델 믹스

| 역할 | 모델 | 용도 |
|------|------|------|
| Lead | Opus 1M | 팀 조율 + 슬라이드 직접 실행 |
| Research Worker | Explore | 주제별 최신 사례 수집 |
| Content Worker | Sonnet 1M | 강의안/실습자료 작성 |
| Format Worker | Haiku | typst/python-docx 변환 (기계적) |
| DA Worker | Sonnet 1M | 품질 반론 검토 |
| Cross-Val Worker | Haiku | 핸드아웃↔실습파일 대조 |

---

## STEP 0: 모드 라우팅

```
args 파싱:

패턴 A: /lecture MW3 전체           → mode=full, week=MW3
패턴 B: /lecture MW3 강의안         → mode=outline, week=MW3
패턴 C: /lecture MW3 실습자료       → mode=practice, week=MW3
패턴 D: /lecture MW3 슬라이드       → mode=slides, week=MW3
패턴 E: /lecture MW3 수정 "내용"    → mode=update, week=MW3, plan=내용
패턴 F: /lecture (빈값)             → AskUserQuestion으로 주차+모드 선택
플래그: --skip-research             → Phase 1 리서치 스킵 (기존 자료 유지)
플래그: --skip-audience             → 청중 프로필 선택 스킵 (전체 프로필 + 기본 2분)
```

### 인터랙티브 모드 (args 없음)

```
AskUserQuestion:
  질문1: "어떤 주차를 작업하시겠습니까?"
    header: "주차"
    options: [MOC에서 자동 추출한 주차 목록] 또는 "MW3", "MW4", "MW5" 등

  질문2: "어떤 작업을 하시겠습니까?"
    header: "모드"
    options:
      - "전체 (Recommended)" — 7단계 전체 파이프라인
      - "강의안만" — STEP 2+5 (콘텐츠 + 리뷰)
      - "실습자료만" — STEP 2+3+5 (생성 + 포맷 + 리뷰)
      - "슬라이드만" — STEP 4 (outline + prompts)
      - "수정" — 기존 강의안 수정 (수정계획서 입력)

  질문3: "이 강의의 청중 프로필을 선택하세요" (--skip-audience 시 스킵)
    header: "청중"
    multiSelect: true
    options:
      - lecture_config.audience_profiles에서 자동 추출
      - 예: "R&D 엔지니어 (중급)", "전략기획 (고급)", ...
      - "커스텀 프로필 직접 입력"
    결과: selected_profiles = [선택된 프로필 ID 배열]

  질문4: "교시별 Audience Hook 시간을 설정하세요"
    header: "Hook 시간"
    options:
      - "전체 동일 2분 (Recommended)"
      - "전체 동일 3분"
      - "교시별 개별 설정"
        → 선택 시 교시 수만큼 추가 질문:
          "{N}교시 Hook 시간?" → [1분, 2분, 3분, 5분]
    결과: hook_durations = { "1교시": 2, "2교시": 3, ... } 또는 전체 동일값
```

---

## STEP 0.5: 컨텍스트 로드 (자동)

```
1. MOC 로드
   Read("Mine/Lectures/성우하이텍-마스터과정-MOC.md")
   → 전체 커리큘럼 맥락 + 해당 주차 정보 추출

2. 해당 주차 강의안 로드 (존재하는 경우)
   Glob("Mine/Lectures/성우하이텍-마스터-{week}*")
   → instructor 파일 + student 파일

3. 강의 설정 로드
   lecture_config = {
     course: "성우하이텍 AI 마스터 과정",
     departments: [
       { id: "A", name: "R&D", alias: "A-RnD", focus: "CAE/시뮬레이션" },
       { id: "B", name: "전략", alias: "B-전략", focus: "시장분석/M&A" },
       { id: "C", name: "제조", alias: "C-제조", focus: "품질관리/생산" },
       { id: "D", name: "경영", alias: "D-경영", focus: "투자/예산" }
     ],
     time_slots: ["8:00~8:45", "9:00~9:45", "10:00~10:45", "11:00~11:45"],
     vault_wsl: "/home/tofu/obsidian-ai-vault/AI_Second_Brain/Mine/Lectures/",
     vault_win: "/mnt/c/Users/treyl/Documents/Obsidian/Second_Brain/Mine/Lectures/",
     slide_design: {
       theme: "화이트보드 칠판",
       character: "두부 캐릭터 (대파+마늘 머리핀, 안경, 몽글몽글)",
       colors: { accent: "#F5E6CC", blue: "#1E3A5F", black: "#1A1A1A", sky: "#A8C8E8" }
     },
     audience_profiles: [
       {
         id: "dept-rd", name: "R&D 엔지니어", level: "중급",
         characteristics: ["CAE/시뮬레이션 전문", "Python 기초 있음", "데이터 기반 의사결정 선호"],
         pain_points: ["AI 모델 정확도 vs 해석 가능성", "기존 시뮬레이션 워크플로우와 AI 통합"],
         preferred_examples: ["제조업 AI 품질 예측 사례", "디지털 트윈 연동 사례"],
         hook_style: "기술 데모 + 데이터 시각화"
       },
       {
         id: "dept-strategy", name: "전략기획", level: "고급",
         characteristics: ["시장분석/M&A 전문", "ROI 중심 사고", "경영진 보고 경험"],
         pain_points: ["AI 도입 비용 대비 효과 정량화", "경쟁사 AI 전략 벤치마킹"],
         preferred_examples: ["AI 도입 ROI 사례", "산업별 AI 전략 비교"],
         hook_style: "비즈니스 케이스 + 수치 비교"
       },
       {
         id: "dept-manufacturing", name: "제조/품질", level: "초급",
         characteristics: ["품질관리/생산 전문", "현장 중심 사고", "IT 도구 경험 제한적"],
         pain_points: ["AI가 현장 작업을 대체할까 불안", "복잡한 도구 학습 부담"],
         preferred_examples: ["공장 자동화 AI 사례", "불량 탐지 AI 사례"],
         hook_style: "현장 적용 사례 + 비포/애프터"
       },
       {
         id: "dept-management", name: "경영/투자", level: "고급",
         characteristics: ["투자/예산 의사결정권", "전략적 관점 우선", "비즈니스 임팩트 중시"],
         pain_points: ["AI 투자 의사결정 근거", "AI 거버넌스/리스크 관리"],
         preferred_examples: ["AI 투자 성과 사례", "AI 거버넌스 프레임워크"],
         hook_style: "전략 질문 + 의사결정 시나리오"
       }
     ],
     hook_defaults: {
       duration_min: 2,
       allowed_types: ["질문", "사례"],
       activity_level: "passive",   # passive(질문/사례만) | active(조별활동/발표 포함)
       rotation: true               # 교시마다 유형 로테이션
     }
   }

4. 수정계획서 로드 (mode=update 또는 mode=full일 때)
   IF args에 파일 경로 포함:
     Read(파일 경로) → update_plan
   ELIF 카카오톡 파일 감지:
     Glob("/mnt/c/Users/treyl/OneDrive/Documents/카카오톡 받은 파일/*{week}*")
     → 최신 파일 자동 로드
   ELSE:
     AskUserQuestion("수정계획서가 있으신가요?")
       - "파일 경로 입력"
       - "직접 입력"
       - "없음 (신규 작성)"

5. 청중 프로필 로드 (자동 — NEW v2.1.0)
   IF {BASE}/.lecture-config.json 존재:
     profiles = JSON 파일에서 audience_profiles 로드 (강의별 오버라이드)
   ELSE:
     profiles = lecture_config.audience_profiles (기본)

   selected = STEP 0 질문3에서 선택된 프로필 ID로 필터링
   hook_config = {
     durations: STEP 0 질문4 결과,
     allowed_types: hook_defaults.allowed_types,
     activity_level: hook_defaults.activity_level
   }
   → STEP 2 C1 워커 프롬프트에 selected + hook_config 주입
```

---

## STEP 1: 리서치 (mode: full — NEW in v2.0.0)

> MW3 교훈: 리서치 Phase 없이 강의안 작성 → 6주제를 /lecture 바깥에서 별도 수행해야 했음.

```
스킵 조건:
  - --skip-research 플래그
  - mode=update (기존 자료 유지)
  - mode=practice, slides (리서치 불필요)
  --skip-research 시 기존 리서치 로드:
    Glob("Library/Research/Lectures/{week}/R*.md")
    → 파일 있으면 읽어서 STEP 2에 주입
    → 파일 없으면 "이전 리서치 없음. 리서치를 실행하세요." 경고

실행 시:
  1. 강의 주제에서 리서치 주제 3~5개 추출
     (MOC + 수정계획서에서 핵심 키워드 도출)

  2. Explore 워커 3~5명 병렬 스폰:
     FOR each topic IN research_topics:
       Agent(
         name: "research-{N}",
         subagent_type: "Explore",
         run_in_background: true,
         prompt: "다음 주제에 대한 최신 사례/통계를 수집하세요.
           - 주제: {topic}
           - 출처 명시 필수 (URL + 날짜)
           - 성우하이텍 제조업 맥락 우선
           - 결과: Library/Research/Lectures/{week}/R{N}.md에 vault 누적 저장
                   (WSL: /home/tofu/obsidian-ai-vault/AI_Second_Brain/Library/Research/Lectures/{week}/)
                   다음 강의에서 --skip-research 시 기존 리서치 재활용"
       )

  3. 결과 통합:
     R1~RN 결과 읽기 → 강의에 쓸 핵심 포인트 추출
     → STEP 2 워커 프롬프트에 주입
```

```
🔄 STEP 1/7: 리서치 수집 중... ({N}개 주제 병렬)
✅ STEP 1/7: 완료 — {N}개 리서치 파일, 핵심 포인트 {M}개 추출
```

---

## STEP 1.5: GraphRAG 논문 매칭 (자동 — NEW v2.2.0)

> STEP 1 리서치 결과를 GraphRAG 지식 그래프와 연결하여 교시별 관련 논문/엔티티를 자동 추출.

```
스킵 조건:
  - mode=practice, slides (콘텐츠 생성 불필요한 모드)
  - GraphRAG 검색 서버 미실행 시 → 경고 출력 후 스킵

실행 시:
  1. STEP 1 리서치 결과 + MOC에서 교시별 핵심 키워드 추출 (3-5개/교시)

  2. 키워드별 GraphRAG 검색:
     FOR each session IN sessions:
       FOR each keyword IN session.keywords:
         WebFetch("http://localhost:8400/search?q={keyword}&top_k=5&mode=hybrid")
       → type=paper/research 엔티티 필터링
       → 중복 제거 + 신뢰도순 정렬

  3. 교시별 논문 참조 구성:
     paper_refs = {
       "1교시": [
         { name: "논문명", description: "1줄 설명", centrality: 0.xx, confidence: "high" },
         ...
       ],
       "2교시": [...],
     }

  4. C1 워커 프롬프트에 paper_refs 주입
     → instructor.md 교시별 [Paper Refs] 섹션 자동 생성

  폴백:
    - 검색 서버 미응답 → CLI 직접 호출 시도:
      Bash("cd .team-os/graphrag/scripts && python graph_search.py --query '{keyword}' --mode hybrid --top-k 5")
    - CLI도 실패 → "GraphRAG 연결 실패. 논문 참조 없이 진행합니다." 경고
```

```
🔄 STEP 1.5: GraphRAG 논문 매칭 중... ({N}개 교시 × {M}개 키워드)
✅ STEP 1.5: 완료 — 교시별 논문 {총N}개 매칭
```

---

## STEP 2: 콘텐츠 생성 (mode: full, outline, practice, update)

> v1의 STEP 1(강의안) + STEP 2(실습자료)를 통합. 3개 GP 워커로 병렬 실행.

```
병렬 워커 3명:

C1 — 강의안 워커 (Sonnet 1M):
  입력: MOC + 리서치 결과 + 수정계획서 + selected_profiles + hook_config
  출력: instructor.md + student.md
  규칙:
    - frontmatter (title, author, date, tags, status)
    - 시간표 (4교시 × 45분)
    - 교시별 상세 운영안 + 강사 스크립트
    - 리서치 결과 인용 시 출처 URL 필수
    - Gems 관련 내용 자동 제거
    - ✨ 교시별 [Audience Hook] 섹션 생성 (NEW v2.1.0)
    - ✨ 교시 간 [Transition] 섹션 생성 (NEW v2.1.0)

  [Audience Hook] 생성 규칙:
    위치: 각 교시 제목 바로 아래, 학습 목표 위
    포맷:
      ## [Audience Hook] ({hook_config.durations[N]}분)
      - **유형**: {allowed_types 로테이션: 질문→사례→질문→...}
      - **대상 프로필**: {selected_profiles 중 대표 1개}
      - **내용**: {프로필의 pain_points/characteristics 기반 질문 또는 사례}
      - **의도**: {이 Hook이 교시 학습 목표와 어떻게 연결되는지}
      - **[대안]**: {다른 프로필 기준 대안 1개}
    제약:
      - activity_level="passive" → 질문/사례만 (조별활동/발표/토론 금지)
      - activity_level="active" → 모든 유형 허용
      - 대안도 activity_level 제약 적용

  [Transition] 생성 규칙:
    위치: 각 교시 마지막 (상세 운영안 뒤, 다음 교시 전)
    포맷:
      ## [Transition → {N+1}교시]
      - **복습**: "지금까지 {해당 교시 핵심 키워드 2-3개}에 대해 살펴봤습니다."
      - **연결**: "{이번 교시 개념}이 {다음 교시 주제}와 어떻게 연결되는지 보겠습니다."
      - **예고**: "{다음 교시}에서는 {핵심 활동}을 직접 해보겠습니다."
    제약:
      - 마지막 교시에는 Transition 생략
      - 복습 키워드는 해당 교시 실제 내용에서 추출 (임의 생성 금지)

  [Paper Refs] 생성 규칙:
    위치: 각 교시의 [Transition] 뒤 (또는 마지막 교시의 상세 운영안 뒤)
    포맷:
      ## [Paper Refs]
      - [{논문명}] — {설명 1줄} [신뢰도: {confidence}]
      - [{논문명}] — {설명 1줄} [신뢰도: {confidence}]
      > GraphRAG 자동 매칭 결과. 수동 확인 권장.
    제약:
      - paper_refs가 비어있으면 섹션 생략
      - 신뢰도 "very_low"인 항목 제외
      - 교시당 최대 5개

C2 — 실습자료 A+B 워커 (Sonnet 1M):
  입력: 강의 주제 + 부서 맥락 (R&D, 전략)
  출력: 부서당 4파일 × 2부서 + Knowledge MD 2개

C3 — 실습자료 C+D + 핸드아웃 워커 (Sonnet 1M):
  입력: 강의 주제 + 부서 맥락 (제조, 경영)
  출력: 부서당 4파일 × 2부서 + Knowledge MD 2개
        + 통합 핸드아웃 2개

디렉토리:
  BASE = vault_wsl + "{week}-실습자료/"
  mkdir -p {BASE}/{A-RnD, B-전략, C-제조, D-경영, 강사용, 핸드아웃, 부록-Knowledge, 슬라이드}

Agent 스폰 (병렬):
  FOR each worker IN [C1, C2, C3]:
    Agent(
      name: worker.name,
      subagent_type: "general-purpose",
      model: "sonnet",
      mode: "bypassPermissions",
      run_in_background: true,
      prompt: worker.prompt
    )

결과 검증:
  Glob("{BASE}/**/*.md") → 파일 수 확인
  강사용/완성 파일 → 강사용/ 폴더 분리
```

```
🔄 STEP 2/7: 콘텐츠 생성 중... (3워커 병렬)
  ├─ C1 강의안: 🔄
  ├─ C2 실습 A+B: 🔄
  └─ C3 실습 C+D+핸드아웃: 🔄
✅ STEP 2/7: 완료 — 강의안 {N}개 + 실습 {M}개 파일
```

---

## STEP 3: 포맷 변환 — 병렬 (mode: full, practice)

> v1 대비 변경: F1(typst) + F2(docx) 동시 실행. ~15분 → ~8분 (50% 절감).

```
STEP 2 완료 대기 후 동시 시작:

F1 — typst PDF 워커 (Haiku):
  FOR each md IN (Knowledge-*.md + 핸드아웃 + AI Studio 가이드):
    typst 소스 생성 (성우하이텍 표지 템플릿) → typst compile
  오류 처리: 폰트 경고 무시, 컴파일 실패 시 재시도 3회

F2 — python-docx DOCX 워커 (Haiku):
  FOR each md IN (PRD 템플릿 + Instructions 단일문서 + 실습안내):
    python-docx 변환 (eastAsia 폰트 매핑 필수!)
  규칙: rFonts.set(qn('w:eastAsia'), '맑은 고딕') 반드시 포함

Agent 스폰 (병렬):
  Agent(name: "format-pdf", subagent_type: "general-purpose",
    model: "haiku", mode: "bypassPermissions", run_in_background: true,
    prompt: "typst PDF 변환: {파일 목록}...")
  Agent(name: "format-docx", subagent_type: "general-purpose",
    model: "haiku", mode: "bypassPermissions", run_in_background: true,
    prompt: "python-docx DOCX 변환: {파일 목록}...")

검증:
  Glob("{BASE}/**/*.pdf") → PDF 파일 수
  Glob("{BASE}/**/*.docx") → DOCX 파일 수
```

```
🔄 STEP 3/7: 포맷 변환 중... (F1+F2 병렬)
  ├─ F1 typst PDF: 🔄
  └─ F2 python-docx: 🔄
✅ STEP 3/7: 완료 — PDF {N}개 + DOCX {M}개
```

---

## STEP 4: 슬라이드 준비 (mode: full, slides)

> **CRITICAL (MW3 교훈)**: Lead(Opus)가 직접 /baoyu-slide-deck 스킬 호출.
> 워커에 위임 시 슬라이드 설계 일관성 손실 확인됨. **위임 금지.**

```
1. Lead가 직접 Skill("baoyu-slide-deck") 호출:
   - 강의안(STEP 2 결과)을 소스로 읽기
   - Step 1~4 전체 실행 (Step 5 이미지 생성은 건너뜀)
   - MW2 스펙 참조 (slide-design 설정)
   - 최대 70장, 한 주제 여러 슬라이드

2. 아웃라인 + 프롬프트 생성:
   Write("{BASE}/슬라이드/outline.md")     → 전체 아웃라인
   Write("{BASE}/슬라이드/prompts/*.md")   → 슬라이드별 프롬프트

3. 이미지 생성은 하지 않음:
   "아웃라인 + 프롬프트 준비 완료.
    이미지 생성은 /baoyu-slide-deck Step 5를 별도 실행하세요."
```

### 4-RULES: 슬라이드 아웃라인 3대 원칙 (CRITICAL — MW3 교훈)

> MW3에서 실제 발생한 문제 3건을 원천 차단하는 규칙입니다.

**원칙 1: 배경색은 Section Divider만 블루**

```
✅ Section Divider 슬라이드 → 배경: 성우하이텍 블루 (#1E3A5F)
✅ 그 외 모든 슬라이드 → 배경: 화이트보드 크림 (#FAFAF5)

❌ 금지: Content 슬라이드에 블루/진한 배경 사용
❌ 금지: Section Divider 이외에 배경색 전환

검증: 아웃라인 생성 후 **Type**: 필드가 "Section Divider"가 아닌 슬라이드에
      블루 배경이 포함되어 있으면 즉시 수정.
```

**원칙 2: 사용자 이미지 삽입 자리는 플레이스홀더만**

```
강의안에 ![[이미지파일.png]] 또는 이미지 삽입 의도가 있는 슬라이드:
  → 아웃라인에 "[사용자 이미지 삽입: {파일명 또는 설명}]" 플레이스홀더 표기
  → 프롬프트에서 해당 영역을 회색 박스 + 라벨로 처리
  → AI 이미지 생성 금지

판별 기준:
  - ![[*.png]] / ![[*.jpg]] → 사용자 이미지 (플레이스홀더)
  - 사례 사진, 스크린샷, 캡처 → 사용자 이미지 (플레이스홀더)
  - 인포그래픽, 다이어그램, 플로우차트 → AI 생성 가능
  - 두부 캐릭터 → AI 생성 (항상)

❌ 금지: 사용자가 직접 넣겠다고 한 이미지를 AI가 대체 생성
```

**원칙 3: 데이터 슬라이드는 수치를 그대로 보존**

```
강의안에 연구 데이터, 통계, 사례 테이블이 포함된 슬라이드:
  → 핵심 수치를 아웃라인 KEY CONTENT에 정확히 기재
  → 프롬프트에 "이 숫자들이 읽을 수 있는 크기로 표시되어야 한다" 명시
  → 디자인보다 정보 전달 우선

예시:
  강의안: "Kao 공장 — 월 480시간 절감, Schaeffler — 2년간 30+ 앱"
  ✅ 아웃라인: Body에 "Kao: 월 480시간 절감" / "Schaeffler: 30+ 앱" 정확히 포함
  ❌ 금지: "제조업 AI 사례를 아이콘으로 표현" (숫자 생략)

"텍스트 최소"의 의미:
  - 풀 문장, 설명 텍스트 → 제거 (OK)
  - 구체적 수치, 기업명, 연구 출처 → 보존 (CRITICAL)
  - 핵심 키워드 1-3개 → 유지
  - "감이 아닌 데이터"가 이 강의의 철학 — 슬라이드도 마찬가지
```

```
🔄 STEP 4/7: 슬라이드 준비 중... (Lead 직접 실행)
  ├─ 아웃라인: {N}장 생성
  ├─ 4-RULES 검증: 배경색 / 사용자이미지 / 데이터 보존
  └─ 프롬프트: {N}개 생성
✅ STEP 4/7: 완료 — outline + prompts {N}개 (4-RULES 통과)
```

---

## STEP 5: 리뷰 — DA + Cross-Val + Ralph (mode: full)

> v1 대비 변경: STEP 5(보완) + STEP 5.5(교차검증)를 DA/Cross-Val/Ralph 팀으로 통합.
> MW3 교훈: DA CONCERN 4건 (이미지 파일명, 슬라이드 마커, 용어 통일 등) 자동 탐지.

```
5-1. 강의안 보완 (Lead 직접):
  실습자료 참조 링크 삽입, 강사 체크리스트 업데이트, MOC 갱신
  (v1 STEP 5 내용 유지)

5-2. DA Worker (Sonnet 1M) 스폰:
  Agent(name: "da-review", subagent_type: "general-purpose", model: "sonnet",
    run_in_background: true,
    prompt: "전체 강의안 + 실습자료를 검토하고 반론을 제시하세요.
      검토 포인트:
      - 강의 목표 달성 가능성 (강의→실습 교차 구조)
      - 출처 표기 완성도 (리서치 인용 여부)
      - 슬라이드 글자 수 과다 여부
      - 부서별 난이도/분량 불균형
      - 시간 배분 현실성 (교시당 45분)
      - ✨ 청중 적합성 (P1): Hook 질문/사례가 프로필 pain_points와 관련 있는가? level에 맞는 용어 수준인가?
      - ✨ Hook 시간 현실성 (P2): 지정 시간 내 실행 가능한 Hook인가? (2분 Hook에 5분 활동 금지)
      - ✨ Transition 일관성 (P1): 복습 키워드=해당 교시 내용? 예고 주제=다음 교시 실제 내용?
      - ✨ 논문 참조 적절성 (P2): Paper Refs의 논문이 해당 교시 주제와 관련 있는가? 신뢰도 low인 참조 포함 여부
      출력: P0=즉시수정 / P1=중요 / P2=권고 분류")

5-3. Cross-Val Worker (Haiku) 스폰:
  Agent(name: "cross-val", subagent_type: "general-purpose", model: "haiku",
    run_in_background: true,
    prompt: "핸드아웃↔실습파일 일치 검증:
      - 핸드아웃 내 언급 파일명 vs 실제 존재 파일 대조
      - Step 번호/순서 일치
      - 프롬프트 텍스트 동일성
      - 부서 간 일관성 (UI 패턴, 데이터 형식)
      출력: 불일치 목록 + 자동 수정 가능 여부")

5-4. Ralph 루프 (Lead, 최대 2회):
  DA-CONCERN P0/P1 + Cross-Val 불일치 → Lead가 즉시 수정
  P2 권고 → Lead 판단으로 선택적 반영
  수정 후 Cross-Val 재실행 (불일치 0건까지)
  2회 이내 모든 P0/P1 해소 → SHIP

5-5. 검증 결과 저장:
  Write("{BASE}/강사용/{week}-리뷰-결과.md", 검증 체크리스트)
```

```
🔄 STEP 5/7: 리뷰 중...
  ├─ DA: {P0}개 즉시수정 / {P1}개 중요 / {P2}개 권고
  ├─ Cross-Val: {불일치 N건}
  └─ Ralph: {수정 M건} → SHIP
✅ STEP 5/7: 리뷰 완료 — P0/P1 {해소건수}건 수정, 불일치 0건
```

---

## STEP 6: 동기화 (모든 모드)

```
1. Windows vault 동기화:
   Bash("rsync -av {BASE}/ '{vault_win}{week}-실습자료/'")
   FOR each 강의안 in Glob("{vault_wsl}성우하이텍-마스터-{week}*"):
     Bash("cp '{강의안}' '{vault_win}'")
   Bash("cp '{vault_wsl}성우하이텍-마스터과정-MOC.md' '{vault_win}'")

2. 검증:
   Glob("{vault_win}{week}-실습자료/**/*") → 파일 수 확인

3. 최종 보고:
```

```markdown
## /lecture {week} 완료

### 산출물
| 카테고리 | 파일 수 | 위치 |
|---------|--------|------|
| 강의안 | {N}개 | Mine/Lectures/ |
| 실습자료 (부서별) | {N}개 | {week}-실습자료/{A~D}/ |
| Knowledge PDF | {N}개 | {week}-실습자료/{A~D}/ |
| 실습 DOCX | {N}개 | {week}-실습자료/{A~D}/ |
| 핸드아웃 PDF/MD | {N}개 | {week}-실습자료/핸드아웃/ |
| 강사용 정답 | {N}개 | {week}-실습자료/강사용/ |
| 슬라이드 prompts | {N}개 | {week}-실습자료/슬라이드/prompts/ |

### 리뷰
- DA: P0 {N}건 / P1 {N}건 / P2 {N}건 → 수정 {M}건
- Cross-Val: 불일치 {N}건 → 수정 {M}건
- Ralph: {회수}회 → SHIP

### 동기화
- [x] WSL vault
- [x] Windows vault

### 다음 단계
- `/baoyu-slide-deck` Step 5로 슬라이드 이미지 생성
```

---

## 공통 규칙 (전 STEP 적용)

### 출처 표기 필수

```
리서치 결과 사용 시:
  - 출처 URL + 날짜 인라인 표기: "[출처: {URL}, {YYYY-MM-DD}]"
  - 출처 없는 통계/사례 사용 금지
  - DA Worker가 출처 누락 탐지 → P1 이상
```

### /prompt 기반 프롬프트 설계

```
실습 프롬프트 설계 시:
  Lead가 Skill("prompt") 호출 → 최적화된 프롬프트 초안 생성
  실습 유형별:
    - 나노바나나(Chain-of-Thought): /prompt 기반 시스템 프롬프트
    - GPT 제작: 목적-예시-제약 구조
    - 감독-승인 루프: 단계별 승인 포인트 명시
```

### 슬라이드 콘텐츠 밀도 규칙

```
"텍스트 최소"는 "정보 최소"가 아닙니다.

제거할 것 (텍스트 최소):
  - 풀 문장 설명 → 명사구/동사구로 축약
  - 강사 스크립트 내용 → 슬라이드에 넣지 않음
  - 중복 라벨링 → 인포그래픽이 설명하는 것을 텍스트로 반복하지 않음

보존할 것 (정보 보존 CRITICAL):
  - 구체적 수치: "480시간/월", "+14.7%p", "30+ 앱"
  - 기업명/인물명: "Kao", "Schaeffler", "Austin Lau"
  - 출처 단축: "[Google Research 2025]" (URL은 강의안 참조)
  - 핵심 메시지: 슬라이드의 존재 이유인 한 문장

DA 검증:
  - 글자 수 과다 = P2 (경고)
  - 핵심 수치/기업명 누락 = P1 (즉시 수정)
  - 사용자 이미지 대체 생성 = P0 (즉시 수정)
```

### 강의→실습 교차 구조

```
설계 원칙:
  강의안 작성 시 "이 교시에서 배운 내용으로 실습에서 무엇을 만드는가" 명시
  실습자료 도입부에 "이전 교시에서 배운 {개념}을 직접 구현합니다" 문장 필수
  Cross-Val Worker 검증 항목: 강의-실습 연결 문장 존재 여부
```

### 세션 밀도 규칙 (Session Density — v2.3.0)

> MW4 교훈: 교시 하나가 "설치만 하고 끝"이면 학습자는 45분을 낭비한 것처럼 느낀다.

```
모든 교시는 다음 4가지를 충족해야 한다:

1. 명확한 학습자 산출물 (Learner Outcome)
   - 교시 끝에 학습자가 "이것을 만들었다/확인했다"고 말할 수 있는 것
   - 예: 파일 생성, 설정 완료, 분석 결과 확인, 비교표 작성 등
   - ❌ "~을 이해한다"만으로는 부족 — 산출물이 있어야 함

2. 실습 깊이 (Practice Depth)
   - 하나의 명령어 실행 후 끝나는 활동 금지 (one-command-and-done)
   - 최소 2단계 이상: 실행 → 결과 확인/비교/변형
   - 부서별 맥락 적용이 있으면 더 좋음

3. 세션 독립성 (Session Independence)
   - 겹치더라도 깊이, 구조, 산출물이 다르면 허용
   - 동일 도구를 다른 교시에서 반복할 때: 난이도 상승 또는 적용 맥락 변화 필수
   - 단순 반복 = DA P1 이슈

4. 시간 현실성 (Time Realism)
   - 45분 교시에서 실질 활동 시간: Hook(2-3분) + 강의(10-15분) + 실습(20-25분) + 정리(5분)
   - 실습 블록이 10분 미만이면 밀도 부족 경고

생성 시 자가점검 체크리스트:
  □ 이 교시의 학습자 산출물은 무엇인가?
  □ 실습이 단일 명령 실행으로 끝나지 않는가?
  □ 이전 교시와 겹치는 부분이 있다면 무엇이 다른가?
  □ 실습 블록에 최소 20분이 확보되었는가?
```

### 레슨 런타임 동기화 규칙 (Lesson Runtime Sync — v2.3.0, 성우하이텍 한정)

> **적용 범위**: 성우하이텍 마스터 과정 전용. lesson-a 런타임 시스템을 사용하는 이 강의에만 적용.
> 다른 강의에는 이 규칙이 적용되지 않음.

> MW4 교훈: 강의안은 수정했는데 lesson-a 런타임 플로우와 start 커맨드는 이전 버전 — 실행하면 엉뚱한 흐름.

```
성우하이텍 lesson-a 런타임 시스템이 있을 때:

1. 3자 정합성 (Three-Way Alignment)
   - 강의안(instructor.md) ↔ lesson-a 런타임 모듈(CLAUDE.md) ↔ 슬라이드 아웃라인
   - 세션 목표가 변경되면 세 곳 모두 확인 필수
   - 파일명, 교시 번호, 진행 순서가 일치해야 함

2. 런타임 커맨드 검증
   - start-mw{N}-{session}.md 커맨드가 올바른 모듈을 참조하는지 확인
   - 가능하면 dry-run으로 런타임 커맨드 실행 검증 (파일 존재, 경로 정확성)
   - 런타임 플로우의 Step 순서 = 강의안 교시 진행 순서

3. 핸드오프 산출물 일치
   - 강의안에서 언급한 파일명 = lesson-a에서 생성/사용하는 파일명
   - 교시 간 이어지는 산출물의 파일명이 양쪽에서 동일해야 함
   - 불일치 발견 시 Cross-Val Worker가 P1으로 분류

검증 체크리스트:
  □ 강의안 교시 구성 = lesson-a 런타임 모듈 구성?
  □ start 커맨드가 올바른 모듈을 참조?
  □ 산출물 파일명이 강의안/lesson-a/슬라이드에서 동일?
```

### 도구 리터러시 단계 패턴 (Tool Literacy Progression — v2.3.0)

> MW4 교훈: "설치" 교시 다음에 바로 "심화 활용"으로 넘어가면 학습자가 도구의 역할을 이해하지 못한 채 따라만 치게 된다.

```
초보 대상 도구 도입 강의에서 사용하는 재사용 가능한 4단계 패턴:

1단계: 설치 + 프로필 생성 (Setup Session)
  - 도구 설치, 초기 설정, 학습자 컨텍스트 파일 생성
  - 예: Claude Code 설치 → student-profile.md 작성
  - 산출물: 설정 완료 확인 + 개인 프로필/컨텍스트 파일

2단계: 도구 역할 이해 (Understanding Session)
  - 설치한 도구가 무엇을 하는지 행동 기반으로 설명
  - behavior-first 접근: "이 도구는 ~를 한다" (분류학 아님)
  - 예: "plugin은 이렇게 동작하고, skill은 이렇게 동작한다" — 정의가 아닌 시연
  - 산출물: 설치된 도구 목록 + 각각의 역할 정리 파일

3단계: 설치된 능력 활용 (Capability Lab)
  - 공통 산출물 파일 + 부서별 도메인 적용
  - 예: 모든 부서가 같은 템플릿으로 시작 → 부서 데이터에 적용
  - 산출물: 공통 템플릿 기반의 부서별 결과물

4단계: 공유 + 발표 (Share Session)
  - 만든 결과물을 다른 부서와 비교/발표
  - 예: 부서별 AI 활용 제안서 발표, 피드백
  - 산출물: 최종 발표 자료 또는 비교표

적용 규칙:
  - 1단계 없이 3단계 진입 금지
  - 2단계에서 도구 역할을 설명하지 않고 3단계 심화 사용 금지
  - plugin, skill, command, agent 등 용어는 분류학(taxonomy)이 아닌 행동(behavior)으로 설명
  - 이 패턴은 도구 종류에 무관하게 적용 (AI 도구, 코딩 도구, 분석 도구 등)
```

### 학습자 몰입 플로우 규칙 (Engagement Flow — v2.3.0)

> 각 강의는 수강생의 흥미를 끌어당기는 플로우로 완결되어야 한다.
> 참고: OP.GG AI 교육 2026 대시보드의 스토리텔링 구조에서 착안.

```
강의 한 회차(4교시)는 하나의 완결된 스토리로 설계한다:

1. 큰 그림 먼저 (Big Picture First)
   - 1교시 시작 5분: 오늘 배울 내용의 전체 지도 제시
   - "오늘 4교시 동안 여러분은 ~를 만들게 됩니다" — 최종 산출물 미리 보여주기
   - 숫자로 규모감 전달: "3개 도구, 4개 실습, 1개 최종 산출물"
   - ❌ 바로 개념 설명부터 시작하는 것 금지

2. 점진적 공개 (Progressive Disclosure)
   - 1교시: 왜 필요한가 (동기부여 + 개요)
   - 2교시: 어떻게 작동하는가 (원리 + 첫 체험)
   - 3교시: 직접 만들어보기 (심화 실습)
   - 4교시: 완성 + 공유 + 다음 주 연결
   - 각 교시가 다음 교시의 궁금증을 만들어야 함

3. 데이터 기반 설득 (Data-Driven Hook)
   - 사례/통계를 앞에 배치: "이 기업은 월 480시간을 절감했습니다"
   - 추상적 설명 → 구체적 수치/스크린샷으로 전환
   - 학습자의 업무 맥락과 연결된 데이터 우선

4. 강사 시연으로 와우 모먼트 만들기 (Instructor Demo)
   - 도구의 가능성을 "말"이 아닌 "눈"으로 보여주기 — 강사가 직접 시연
   - 시연 배치 원칙:
     · 1교시 초반: "이 도구로 뭘 할 수 있는가" 짧은 시연 (3-5분) → 동기부여
     · 4교시 후반: "더 확장하면 이런 것도 가능" 시연 (5-8분) → 다음 주 기대감
   - 시연은 학습자가 아직 못 하는 것을 보여주되, 다음 주에 할 수 있게 될 것을 예고
   - 시연 직후 "이건 MW{N+1}에서 직접 해봅니다" 연결 필수
   - 좋은 시연 예시:
     · 더미 파일 10개를 만들어놓고 한 문장으로 정리시키기
     · CSV 여러 개를 한 번에 요약 → typst PDF로 즉석 출력
     · 웹페이지를 이미지 포함 크롤링 → 노트로 정리
   - ❌ 시연이 10분 넘으면 학습자가 구경꾼이 됨 — 짧고 임팩트 있게

5. 산출물 기반 완결 (Artifact Closure)
   - 마지막 교시 끝에 학습자가 "오늘 이것을 만들었다"고 느껴야 함
   - 가능하면 부서 간 산출물 비교/공유 시간 포함
   - "다음 주에 이것을 확장합니다" — 다음 회차 연결 예고

6. 지루함 방지 리듬 (Pacing)
   - 강의 15분 이상 연속 금지 → 중간에 짧은 확인/질문 삽입
   - 교시 내 활동 전환 최소 2회: 듣기 → 해보기 → 확인하기
   - 같은 형식의 실습이 2교시 연속 반복되면 DA P2
   - 시연 → 실습 → 시연 교차 배치로 리듬 유지

생성 시 자가점검:
  □ 1교시 시작에 오늘의 전체 지도가 있는가?
  □ 각 교시가 다음 교시에 대한 궁금증을 남기는가?
  □ 구체적 수치/사례가 추상적 설명보다 앞에 오는가?
  □ 강사 시연이 최소 1회 포함되었는가?
  □ 시연이 10분을 초과하지 않는가?
  □ 마지막 교시에 산출물 완결 + 다음 주 예고가 있는가?
  □ 강의 15분 이상 연속 구간이 없는가?
```

### 슬라이드 프롬프트 문체 규칙 (Prompt Wording Quality — v2.3.0)

> MW4 교훈: 슬라이드 프롬프트가 AI 특유의 딱딱한 메타 언어로 작성되면 슬라이드 자체가 어색해진다.

```
슬라이드 프롬프트 작성 시 문체 규칙:

1. 자연스러운 한국어 교육용 문체
   - 강의 슬라이드답게 직관적이고 명확한 표현 사용
   - ❌ "학습자의 인지적 부하를 최소화하는 시각적 계층 구조"
   - ✅ "한눈에 핵심이 보이는 깔끔한 레이아웃"

2. AI 특유 표현 금지
   - "~를 시각화합니다", "~를 아키텍처적으로 표현" 등 메타 언어 금지
   - "인사이트", "레버리지", "시너지" 등 공허한 비즈니스 용어 최소화
   - 분류학적 나열 금지: "A는 ~이고, B는 ~이며, C는 ~입니다" 패턴 지양

3. 행동 중심 기술
   - 각 프롬프트는 학습자가 보고(see), 하고(do), 만드는(produce) 것을 기술
   - ❌ "에이전트 생태계의 구조적 이해를 돕는 다이어그램"
   - ✅ "왼쪽에 plugin 3개, 오른쪽에 skill 2개를 화살표로 연결한 그림"

4. 최종 문체 점검 (Wording Pass)
   - 모든 프롬프트 작성 완료 후, 전체를 한 번 더 읽으며 어색한 표현 수정
   - 소리 내어 읽었을 때 자연스러운지 기준
   - Lead가 직접 수행 (워커 위임 금지)

프롬프트 문체 체크리스트:
  □ AI 특유의 딱딱한 메타 언어가 없는가?
  □ 학습자가 보고/하고/만드는 것이 명확한가?
  □ 분류학적 나열 대신 구체적 행동/이미지로 기술했는가?
  □ 소리 내어 읽어도 자연스러운가?
```

### 공유 산출물 규칙 (Shared Artifact Design — v2.3.0)

> MW4 교훈: student-profile.md, my-installed-tools.md 같은 공유 산출물이 우연히 만들어졌다.
> 이런 산출물은 설계 시점에 의도적으로 만들어야 한다.

```
도구 학습 또는 워크플로우 습관을 가르치는 세션에서:

1. 공통 산출물 파일 설계
   - 모든 학습자가 같은 이름의 파일을 만들도록 설계
   - 초보 학습자 일관성이 중요할 때: 파일명까지 통일
   - 예: student-profile.md, my-ai-toolkit.md, dept-analysis.md

2. 산출물 연쇄 (Artifact Chain)
   - 이번 교시의 산출물이 다음 교시의 입력이 되도록 설계
   - "2교시에서 만든 프로필을 3교시에서 AI에게 주입합니다"
   - 산출물이 다음 세션으로 이어지지 않으면 DA P2

3. 범용 설계 원칙
   - 산출물 이름은 특정 주차에 종속되지 않게 (mw4-profile.md ❌ → student-profile.md ✅)
   - 템플릿 구조: 공통 뼈대 + 부서별 커스텀 섹션
   - 산출물 목적을 강의안에 명시: "이 파일은 ~에서 재사용됩니다"
```

### 최종 정합성 게이트 (Coherence Gate — v2.3.0)

> DA + Cross-Val 이후에도 슬라이드/런타임/다음 주 브리지가 엇나가는 경우가 있었다.

```
STEP 5 리뷰 완료 후, SHIP 판정 전에 Lead가 직접 확인:

1. 런타임 플로우 ↔ 슬라이드 플로우 일치
   - 런타임 모듈의 Step 순서 = 슬라이드 아웃라인의 교시 순서
   - 불일치 시 어느 쪽을 기준으로 맞출지 결정

2. 동일 산출물 파일명
   - 강의안, 런타임 모듈, 슬라이드 프롬프트에서 같은 파일을 지칭할 때
   - 파일명이 세 곳에서 모두 동일해야 함
   - 예: 강의안 "student-profile.md" = 런타임 "student-profile.md" = 슬라이드 "student-profile.md"

3. 다음 회차 브리지 정합성
   - "다음 주 예고" 내용 = 실제 다음 주 MOC 계획과 일치
   - 이번 주 산출물이 다음 주 입력으로 언급되었는지 확인
   - 불일치 발견 시 SHIP 전에 수정

정합성 게이트 체크리스트:
  □ 런타임 Step 순서 = 슬라이드 교시 순서?
  □ 산출물 파일명이 강의안/런타임/슬라이드에서 동일?
  □ 다음 주 예고가 MOC 계획과 일치?
  □ 불일치 0건 확인 후 SHIP?
```

---

## 에러 처리

### 도구별 폴백 체인

| 도구 | Primary | Fallback |
|------|---------|----------|
| typst | `typst compile` | 경고 무시, 3회 재시도 |
| python-docx | eastAsia 폰트 매핑 | 맑은 고딕 → Noto Sans CJK KR |
| /baoyu-slide-deck | outline + prompts | outline만 (prompts 실패 시) |
| Agent 병렬 | 전원 동시 | 1개 실패 시 나머지 유지 + 실패만 재시도 |
| rsync | rsync -av | cp -r 폴백 |
| Glob | Claude Code 내장 | find/ls 금지 (한글 폴더 버그) |

### 한글 인코딩 (CRITICAL)

```
python-docx DOCX 생성 시 반드시:
  rFonts.set(qn('w:ascii'), '맑은 고딕')
  rFonts.set(qn('w:hAnsi'), '맑은 고딕')
  rFonts.set(qn('w:eastAsia'), '맑은 고딕')
  rFonts.set(qn('w:cs'), '맑은 고딕')
```

### brainstorming 게이트 방지

```
병렬 Agent 스폰 시: mode: "bypassPermissions"
프롬프트에 명시: "설계 단계 없이 Write 도구로 즉시 파일 생성"
```

---

## 설정 확장

`lecture_config.departments`를 변경하면 다른 강의에 적용 가능:
```
departments: [
  { id: "A", name: "마케팅", alias: "A-마케팅", focus: "광고/브랜딩" },
  { id: "B", name: "영업", alias: "B-영업", focus: "CRM/파이프라인" },
]
```
강의별 설정: `{week}-실습자료/.lecture-config.json`에 저장 → 재실행 시 자동 로드.

---

## 자연어 트리거

| 트리거 | 매핑 |
|--------|------|
| "강의안 만들어줘" | `/lecture` (인터랙티브) |
| "MW3 강의 전체" | `/lecture MW3 전체` |
| "슬라이드 생성" | `/lecture {최근 주차} 슬라이드` |
| "실습자료 수정" | `/lecture {최근 주차} 수정` |
| "강의 업데이트" | `/lecture` (인터랙티브) |

---

## 변경 이력

| 버전 | 변경 내용 |
|------|----------|
| v1.0.0 | skill-forge 생성, MW2 워크플로우 정규화 |
| v2.0.0 | MW3 교훈 기반 재설계: Phase 1 리서치 추가, STEP 3 포맷 병렬화(F1+F2), STEP 4 Lead 직접 실행 강제, STEP 5 DA+Cross-Val+Ralph 리뷰 통합, 공통 규칙 섹션 추가, 모델 믹스 테이블 |
| v2.1.0 | MiroFish 벤치마크 Phase 1: audience_profiles + hook_defaults, STEP 0 청중/Hook 인터랙티브 UI(질문3+4), --skip-audience, STEP 0.5 프로필 로드, C1 워커 [Audience Hook]+[Transition] 생성, DA 청중 검증 3항목, activity_level passive/active |
| v2.2.0 | MiroFish 벤치마크 Phase 2A: STEP 1.5 GraphRAG 논문 매칭(WebFetch+CLI 폴백), STEP 1 리서치 vault 축적(Library/Research/Lectures/), --skip-research 기존 리서치 재활용, C1 [Paper Refs] 섹션(교시당 최대 5개), DA 논문 참조 적절성 검증(P2) |
| v2.3.0 | MW4 내재화: 세션 밀도 규칙(one-command-and-done 금지), 레슨 런타임 동기화(3자 정합성), 도구 리터러시 4단계 패턴(behavior-first), 학습자 몰입 플로우(OP.GG 참고, 큰 그림→점진적 공개→데이터 기반→산출물 완결), 슬라이드 프롬프트 문체 게이트(AI 메타 언어 금지), 공유 산출물 설계(Artifact Chain), 최종 정합성 게이트(슬라이드/런타임/브리지 교차 확인) |

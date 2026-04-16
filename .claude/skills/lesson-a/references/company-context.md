---
disable-model-invocation: true
---

# 성우하이텍 AI 마스터 과정 컨텍스트

## 강사
- 이름: 김재경 (tofukyung)
- 역할: AI 전문가, 교육 6기관 경력
- 연락처: [강의 시 제공]

## 수강생
- 총 16명, 4그룹
- **A-R&D (5명)**: CAE/시뮬레이션/배터리
- **B-전략 (3명)**: 시장분석/M&A/KPI
- **C-제조 (6명)**: 불량분석/생산관리/금형
- **D-경영 (2명+α)**: 투자/구매/예산

## 실습 데이터
- 폴더: `codex-practice/` (기존 Codex 실습 데이터 재활용)
- **A (R&D)**: result.csv, spec_sheets/, battery_log.csv
- **B (전략)**: market_reports/, candidates.xlsx, kpi_data.xlsx
- **C (제조)**: defect_log.csv, production.xlsx, mold_history.csv
- **D (경영)**: budget_2026.xlsx, actual_Q1.xlsx, purchase_history.csv

## 구독
- **Claude Team Standard** (관리자가 사전 초대, 수강생은 로그인만)

## 사전 안내 (Notion/이메일 — 필수 아닌 권장)

> ⚠️ 사전 설치 불가 환경. 당일 1교시에 전부 설치합니다.
> Notion에 링크만 미리 공유하여 "가능하면 미리 설치해오세요" 안내.

**Notion 게시물 내용 (MW4 1주 전):**
```
[성우하이텍 AI 마스터 MW4 사전 안내]

다음 수업에서 Claude Code를 설치하고 실습합니다.
아래 계정만 미리 만들어오시면 수업 시간이 절약됩니다.

1. GitHub 가입: https://github.com/ (무료)
2. Claude 로그인 확인: 초대 이메일 수락 → https://claude.ai 로그인

※ 소프트웨어 설치는 수업 시간에 함께 진행합니다.
```

**Claude Team 초대 이메일**: 관리자가 MW4 전에 사전 발송 (필수)

## 강의장 PC 환경

- **MW4**: 아무것도 설치되지 않은 상태에서 시작. 당일 VSCode+CC+Git+GitHub CLI 전부 설치.
- **MW5 이후**: MW4에서 설치한 소프트웨어가 강의장 PC에 유지됨. 재설치 불필요.
- **미지수 — PC 고정 여부**: 수강생별 PC가 고정될지 미정.
  - 고정 시: MW5부터 로그인 상태 유지, .lesson-memory 프로필 유지
  - 비고정 시: MW5에서 Claude 재로그인 + GitHub 재인증 필요 (5-10분 추가)
  - /lesson 스킬은 두 경우 모두 대응 (프로필 없으면 간소 재인터뷰)

## 플러그인 설치 순서 (MW4 2교시)

```
1. /plugin marketplace add https://github.com/fivetaku/gptaku_plugins.git
2. /plugin install 바르다-깃선생
3. /plugin install deep-research
4. /plugin marketplace add https://github.com/treylom/tofukyung-plugins.git
5. /plugin install tofukyung-plugins
```

## Codex → Claude Code 핵심 전환 매핑

| Codex | Claude Code | 교육 포인트 |
|-------|------------|-----------|
| AGENTS.md | CLAUDE.md | 개념 동일, 파일명만 변경 |
| Suggest/Auto-Edit/Full Auto | Default/Plan/AcceptEdits/Auto | Plan 모드가 핵심 차이 |
| 부서별 실습 데이터 | codex-practice/ 동일 재활용 | 완전 재활용 |
| Vercel 배포 | Vercel 동일 | 완전 재활용 |
| `codex init` | `/init` | 동일 |
| `@파일` 참조 | `@파일` 동일 | 완전 호환 |

## 강의 공통 원칙
- "감자 재배법": 직접 해주지 않고 가이드
- 매 교시 클로징: "저장해줘" → "올려줘"
- 개념 과부하 금지 — 실습 우선

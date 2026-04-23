---
title: MW7 Claude Design 실습 — ECN 검토의견서 스킬 아이디어
date: 2026-04-23
author: Evan-Park
course: 성우하이텍 AI 마스터 MW7 Practice 15
tags:
  - MW7
  - Claude-Design
  - ECN
  - 설계검토
  - 스킬-아이디어
  - AI-적용
related:
  - "[[NAVIGATION]]"
  - "[[Anthropic-Claude-소개]]"
  - "[[차체-경량화-기술-개요]]"
  - "[[student-profile]]"
---

# MW7 Claude Design 실습 — ECN 검토의견서 스킬 아이디어

> Practice 15 (MW7 선택 실습) — 2026-04-18 출시된 Claude Design의 활용 사례 15건을 본 뒤, 본인 업무(R&D / 차체 설계 / ECN 검토)에 적용할 아이디어 1개를 vault에 박제한 메모.

---

## 오늘 본 사례 중 가장 와닿은 것

- **사례 번호**: 7 — 스케치 → PPT 디자인 (@novaglow_07)
- **이유**: 설계 회의 화이트보드 스케치를 **바로 공유 자료**로 만들 수 있다는 감각. 지금까지는 회의 끝나고 다시 손으로 옮겨 그리고 PowerPoint로 재구성하는 시간이 컸는데, 폰카 한 장이면 되는 세상.

## 내 부서(A-RnD, 차체 설계 / 설계 검토 / 설계용역 관리) 적용 아이디어

- **아이디어**: ECN(설계 변경) 검토의견서 카드 자동 생성 스킬
- **1문장 설명**: ECN 메일을 입력하면 영향 분석 + 1페이지 검토 카드를 **Carbon IBM 엔지니어링 톤**으로 자동 생성 — **건당 30분 절약 예상, 주 5건이면 월 10시간** 확보.
- **패턴 연결**: 사례 4(비개발자 카드뉴스 자동화, ⭐)의 "단일 프롬프트 → 실시간 수정 → 스킬화" 4단계를 그대로 ECN 워크플로우에 이식.

## 오늘 실습에서 체화한 3가지 교훈

| # | 교훈 | ECN 스킬 설계에 어떻게 반영할까 |
|---|------|----------------------------------|
| ① | 디자인 시스템을 **먼저** 세팅 (사례 6 ⭐⭐) | Carbon IBM design-md URL을 스킬 프롬프트 상수로 박기 |
| ② | **Edit 을 전제** (사례 1·4) | 1차 카드 뽑은 뒤 *"영향 범위 ○○ 추가"* 같은 후속 수정 문장 셋 준비 |
| ③ | 프롬프트 **방향성이 품질** (사례 8 ⚠️) | 청중(부장/협력사) + 톤(Carbon IBM) + 구체 제약(1페이지, 표 3개) 매번 포함 |

## 다음에 해볼 것

- [ ] lesson-a 레포 대신 **내 CAE 보고서 템플릿 1개**로 Ferrari vs Carbon IBM **비교 생성** — 톤이 결과에 미치는 영향 체감
- [ ] Practice 16(MW7 종합 프로젝트)에서 **ECN 검토의견서 스킬화** 시도 — `/ecn-review` 스킬 확장 포인트
- [ ] `/knowledge-manager` 본 버전으로 **한 번 더** 주간 업무 메모 정리해보기 (lite와 체감 비교)

## 오늘 만든 산출물

- **MW1-6 요약 PPT**: `Downloads/MW1-6-요약-Evan-Park.pptx` (Ferrari 디자인 15장)
- **Edit 시도**: (Evan이 Claude Design UI에서 직접 실행)
- **vault 메모**: 이 파일 자체

## vault 연결

- [[NAVIGATION]] — vault 진입점
- [[Anthropic-Claude-소개]] — Claude Design 제공사 기술 맥락 (Practice 13 아카이브)
- [[차체-경량화-기술-개요]] — 본인 CAE 업무 기술 축 (Practice 13 아카이브)
- [[student-profile]] — 본인 프로필 (A-RnD, 차체 설계)

---

*Practice 15 — MW7 종합 프로젝트 "Claude Design" 선택 실습 결과. `knowledge-manager` 본 버전 첫 호출로 생성됨.*

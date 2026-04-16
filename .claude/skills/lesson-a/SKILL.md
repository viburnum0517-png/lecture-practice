---
name: lesson-a
description: Use when /start-practice-XX 커맨드로 실습 단위 인터랙티브 강의를 진행해야 할 때
version: "3.0.0"
author: tofukyung
disable-model-invocation: true
allowed-tools: Read, Write, Bash, Glob, Grep, AskUserQuestion
---

# lesson-a

실습 단위(Practice) 기반 인터랙티브 강의 스킬.
`lesson-modules/practice-XX-*/CLAUDE.md`와 `references/` 자료를 읽어 진행한다.

## 실행 순서
1. `course-structure.json` 읽기
2. `student-profile.md` 읽기 (있으면)
3. `lesson-modules/practice-XX-*/CLAUDE.md` 읽기
4. `.claude/SCRIPT_INSTRUCTIONS.md` 읽고 진행 규칙 적용
5. 필요 시 `references/` 회사 자료 추가 로드
6. 즉시 실습 시작 — 학생 이름부터 묻기

## 진행 원칙
- 네 번째 벽 깨지 않기
- Claude는 코치이자 파트너입니다. 요청하면 직접 해주고, 최종 판단은 수강생이 합니다.
- 학생이 직접 실행하게 안내
- 매 실습 끝: "저장해줘" → "올려줘"로 마무리

## Practice 커맨드

| 명령 | 실습 |
|------|------|
| `/start-practice-01` | 설치와 연결 |
| `/start-practice-02` | 플러그인 + student-profile.md + 첫 Git |
| `/start-practice-03` | 도구 탐색 (capabilities tour) |
| `/start-practice-04` | 부서별 데이터 분석 |
| `/start-practice-05` | 결과 다듬기 + 저장 |
| `/start-practice-06` | CLAUDE.md 규칙 설계 (Always/Ask/Never) |
| `/start-practice-07` | 구조가 결과를 바꾼다 (3층 비교 + /prompt) |
| `/start-practice-08` | 부서별 통합 파이프라인 (Plan + /using-superpowers) |
| `/start-practice-09` | 하네스 엔지니어링 + 나만의 스킬 + MW6 예고 |
| `/start-practice-SPARE` | [스페어] Vercel 배포 (시간 여유 시) |
| `/start-practice-11` | 옵시디언 소개 + 첫 vault (MW6 1교시) |
| `/start-practice-12` | vault 구조 결정 + NAVIGATION.md (MW6 2교시) |
| `/start-practice-13` | 1-5주차 위키 자동 정리 + ChatGPT/Gemini 비교 (MW6 3교시) |
| `/start-practice-14` | 서브에이전트 + 토큰 절약 + MW7 예고 (MW6 4교시) |

## references/ 구조
- `references/company-context.md` — 회사 배경, 수강생 환경, 실무 맥락

## 참조 로드 규칙
상세 맥락이 필요하면 아래 파일을 우선 참조합니다.
- 공통 회사 맥락: `references/company-context.md`
- 각 practice 상세: `lesson-modules/practice-XX-*/CLAUDE.md`

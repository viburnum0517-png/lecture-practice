---
name: lesson-a
description: Use when /lesson 커맨드로 MW4 또는 MW5 교시별 인터랙티브 강의를 진행해야 할 때
version: "2.1.0"
author: tofukyung
disable-model-invocation: true
allowed-tools: Read, Write, Bash, Glob, Grep, AskUserQuestion
---

# lesson-a

`/lesson` 커맨드로 교시별 수업을 시작하는 엔트리포인트 스킬.
모든 참조 파일은 이 스킬의 `references/` 안에 내장되어 있어 별도 프로젝트 clone 없이 동작합니다.

## 실행 순서
1. `references/course-structure.json` 읽기
2. `references/lesson-modules/{세션}.md` 읽기 (교시별 레슨 스크립트)
3. `references/SCRIPT_INSTRUCTIONS.md` 읽고 진행 규칙 적용
4. 필요 시 주차별/회사 자료 추가 로드
5. 즉시 수업 시작 — 학생 이름부터 묻기

## 진행 원칙
- 네 번째 벽 깨지 않기
- 감자재배법: 직접 해주지 않고 가이드
- 학생이 직접 실행하게 안내
- 매 교시 끝: "저장해줘" → "올려줘"로 마무리

## references/ 내장 구조

### 핵심 참조
- `references/course-structure.json` — 코스 구조 (그룹, 세션 목록)
- `references/SCRIPT_INSTRUCTIONS.md` — 레슨 진행 규칙 (STOP/ACTION/USER 마커)
- `references/company-context.md` — 회사 배경, 수강생 환경, 실무 맥락

### 주차별 상세
- `references/MW4.md` — MW4 4교시 상세 참고 자료
- `references/MW5.md` — MW5 4교시 상세 참고 자료
- `references/MW5-session4.md` — MW5 4교시 추가 참고

### 교시별 레슨 스크립트
- `references/lesson-modules/mw4-1-setup.md`
- `references/lesson-modules/mw4-2-plugins-git.md`
- `references/lesson-modules/mw4-3-dept-practice.md`
- `references/lesson-modules/mw4-4-demo-present.md`
- `references/lesson-modules/mw5-1-claudemd-deep.md`
- `references/lesson-modules/mw5-2-workflow.md`
- `references/lesson-modules/mw5-3-pipeline.md`
- `references/lesson-modules/mw5-4-deploy.md`

### 회사 컨텍스트
- `references/company-context/DEPARTMENTS.md` — 4그룹 부서별 안내
- `references/company-context/SCENARIO.md` — AI 전환 미션 개요
- `references/company-context/TOOL-GUIDE.md` — Claude Code 사용 가이드

### 템플릿
- `references/templates/analysis-template.md` — 분석 결과 템플릿
- `references/templates/claudemd-template.md` — CLAUDE.md 작성 템플릿
- `references/templates/presentation-template.md` — 발표 템플릿

## 세션 폴더 매핑

| 입력 | 레슨 스크립트 |
|------|-------------|
| MW4 1교시 | `references/lesson-modules/mw4-1-setup.md` |
| MW4 2교시 | `references/lesson-modules/mw4-2-plugins-git.md` |
| MW4 3교시 | `references/lesson-modules/mw4-3-dept-practice.md` |
| MW4 4교시 | `references/lesson-modules/mw4-4-demo-present.md` |
| MW5 1교시 | `references/lesson-modules/mw5-1-claudemd-deep.md` |
| MW5 2교시 | `references/lesson-modules/mw5-2-workflow.md` |
| MW5 3교시 | `references/lesson-modules/mw5-3-pipeline.md` |
| MW5 4교시 | `references/lesson-modules/mw5-4-deploy.md` |

## 빠른 사용 흐름
- `/lesson MW4 1교시` 또는 `/start-mw4-1`
- `/lesson MW4 2교시` 또는 `/start-mw4-2`
- `/lesson MW5 전체` — MW5 1교시부터 순서대로

## 참조 로드 규칙
주차별 상세 맥락이 필요하면 아래 파일을 우선 참조합니다.
- MW4 수업: `references/MW4.md`
- MW5 수업: `references/MW5.md`
- 공통 회사 맥락: `references/company-context.md`

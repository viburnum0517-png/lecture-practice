---
description: "성우하이텍 MW4-5 교시별 강의 시작 (예: /lesson MW4 1교시)"
allowedTools: Read, Write, Bash, Glob, Grep, AskUserQuestion
---
$ARGUMENTS

## 인자 파싱

사용자 입력에서 주차(MW4/MW5)와 교시(1~4)를 추출합니다.

예시:
- `/lesson MW4 1교시` → mw4-1
- `/lesson MW4 3` → mw4-3
- `/lesson MW5 전체` → mw5-1부터 순서대로
- `/lesson` (인자 없음) → 주차와 교시를 물어봅니다

## 실행 순서

1. 인자에서 주차와 교시 번호를 파악합니다.
2. 아래 파일을 순서대로 읽습니다 (모두 `~/.claude/skills/lesson-a/references/` 기준):
   - `references/course-structure.json`
   - `references/lesson-modules/{세션}.md`
   - `references/SCRIPT_INSTRUCTIONS.md`
3. 필요 시 참조 파일을 추가 로드합니다:
   - MW4 수업: `references/MW4.md`
   - MW5 수업: `references/MW5.md`
   - 공통: `references/company-context.md`
4. 읽은 레슨 스크립트의 지시에 따라 즉시 강의를 시작합니다.
5. 학생 이름을 물어보고, 오늘 학습 목표를 안내합니다.

## 세션 매핑

| 입력 | 레슨 스크립트 파일 |
|------|-------------------|
| MW4 1교시 | `~/.claude/skills/lesson-a/references/lesson-modules/mw4-1-setup.md` |
| MW4 2교시 | `~/.claude/skills/lesson-a/references/lesson-modules/mw4-2-plugins-git.md` |
| MW4 3교시 | `~/.claude/skills/lesson-a/references/lesson-modules/mw4-3-dept-practice.md` |
| MW4 4교시 | `~/.claude/skills/lesson-a/references/lesson-modules/mw4-4-demo-present.md` |
| MW5 1교시 | `~/.claude/skills/lesson-a/references/lesson-modules/mw5-1-claudemd-deep.md` |
| MW5 2교시 | `~/.claude/skills/lesson-a/references/lesson-modules/mw5-2-workflow.md` |
| MW5 3교시 | `~/.claude/skills/lesson-a/references/lesson-modules/mw5-3-pipeline.md` |
| MW5 4교시 | `~/.claude/skills/lesson-a/references/lesson-modules/mw5-4-deploy.md` |

---
description: Practice 15 — Claude Design 사례 소개 + PPT 자동 생성 실습 (MW7 선택)
allowedTools: Read, Write, Bash, Glob, Grep, AskUserQuestion
---
$ARGUMENTS

Read("course-structure.json")
Read("student-profile.md")
Read("lesson-modules/practice-15-claude-design/CLAUDE.md")
Read(".claude/SCRIPT_INSTRUCTIONS.md")

위 파일을 순서대로 읽고, student-profile.md가 있으면 수강생 이름/부서/업무를 파악한 뒤, Practice 15를 즉시 시작하세요.
학생 이름을 물어보고, 이번 실습 목표(Claude Design 사례 10건 소개 + lesson-a 레포 기반 15장 PPT 생성)를 안내합니다.

테스트모드(사용자가 "테스트모드" 입력)일 경우, 선행 Practice 완료 여부 무시 + 임시 student-profile.md(C-제조 기본)를 자동 생성 후 해당 Practice 바로 진행.

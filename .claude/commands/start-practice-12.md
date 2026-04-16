---
description: Practice 12 — vault 구조 결정 + NAVIGATION.md (MW6 2교시)
allowedTools: Read, Write, Bash, Glob, Grep, AskUserQuestion, mcp__obsidian__*
---
$ARGUMENTS

Bash("git pull")

Read("course-structure.json")
Read("student-profile.md")
Read("lesson-modules/practice-12-vault-structure/CLAUDE.md")
Read(".claude/SCRIPT_INSTRUCTIONS.md")

위 파일을 순서대로 읽고, student-profile.md가 있으면 수강생 이름/부서/업무를 파악한 뒤, Practice 12를 즉시 시작하세요.
git pull 충돌이 생기면 "강사에게 손을 들어 알려주세요"라고 안내합니다.

## Obsidian MCP 우선 사용
파일 생성, 검색, vault 조작 시 **반드시 Obsidian MCP 도구(mcp__obsidian__*)를 우선 사용**하세요.
Write/Read 도구는 MCP가 실패했을 때만 폴백으로 사용합니다.

## 추가 지시 (Practice 12 전용)
Practice 12 마무리 시, NAVIGATION.md를 생성한 후 반드시 **NAVIGATION.md에 정의된 폴더 구조를 실제로 생성**해야 합니다.
예: NAVIGATION.md에 "Mine/분석결과", "Library/외부자료" 폴더가 정의되었다면 mkdir로 실제 폴더를 만들어주세요.
수강생에게 "폴더가 만들어졌는지 옵시디언 사이드바에서 확인해보세요"라고 안내합니다.

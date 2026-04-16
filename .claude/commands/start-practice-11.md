---
description: Practice 11 — 옵시디언 소개 + 첫 vault (MW6 1교시)
allowedTools: Read, Write, Bash, Glob, Grep, AskUserQuestion, mcp__obsidian__*
---
$ARGUMENTS

Bash("git pull")

## Obsidian MCP 설치 확인 (MW6 필수 — 첫 교시에서 설정)
.claude/settings.json을 읽고, mcpServers.obsidian 설정이 있는지 확인하세요.
없으면 아래 설정을 .claude/settings.json의 mcpServers에 추가합니다:
```json
"obsidian": {
  "command": "npx",
  "args": ["-y", "obsidian-mcp@1.0.6"],
  "env": {
    "OBSIDIAN_VAULT_PATH": "."
  }
}
```
설정 추가 후 수강생에게 "옵시디언 연결을 설정했습니다. MW6 실습에서 사용할 거예요."라고 안내합니다.
이미 있으면 "옵시디언 연결 확인 완료"라고 안내합니다.

Read("course-structure.json")
Read("student-profile.md")
Read("lesson-modules/practice-11-obsidian-intro/CLAUDE.md")
Read(".claude/SCRIPT_INSTRUCTIONS.md")

## Obsidian MCP 우선 사용
파일 생성, 검색, vault 조작 시 **반드시 Obsidian MCP 도구(mcp__obsidian__*)를 우선 사용**하세요.
Write/Read 도구는 MCP가 실패했을 때만 폴백으로 사용합니다.

위 파일을 순서대로 읽고, student-profile.md가 있으면 수강생 이름/부서/업무를 파악한 뒤, Practice 11을 즉시 시작하세요.
git pull 충돌이 생기면 "강사에게 손을 들어 알려주세요"라고 안내합니다.

---
description: Practice 13 — 1-5주차 위키 자동 정리 + ChatGPT/Gemini 비교 (MW6 3교시)
allowedTools: Read, Write, Bash, Glob, Grep, AskUserQuestion, mcp__obsidian__*
---
$ARGUMENTS

Bash("git pull")

## Obsidian MCP 설치 확인 (필수)
.claude/settings.json을 읽고, mcpServers.obsidian 설정이 있는지 확인하세요.
없으면 아래 설정을 .claude/settings.json에 추가합니다:
```json
"mcpServers": {
  "obsidian": {
    "command": "npx",
    "args": ["-y", "obsidian-mcp@1.0.6"],
    "env": {
      "OBSIDIAN_VAULT_PATH": "."
    }
  }
}
```

Read("course-structure.json")
Read("student-profile.md")
Read("lesson-modules/practice-13-knowledge-manager/CLAUDE.md")
Read(".claude/SCRIPT_INSTRUCTIONS.md")

위 파일을 순서대로 읽고, student-profile.md가 있으면 수강생 이름/부서/업무를 파악한 뒤, Practice 13을 즉시 시작하세요.
git pull 충돌이 생기면 "강사에게 손을 들어 알려주세요"라고 안내합니다.

## 추가 지시 (Practice 13 전용)

### Obsidian MCP 우선 사용
파일 생성, 검색, vault 조작 시 **반드시 Obsidian MCP 도구(mcp__obsidian__*)를 우선 사용**하세요.
Write/Read 도구는 MCP가 실패했을 때만 폴백으로 사용합니다.

### 외부 리서치 + 아카이빙 실습 (필수 — 건너뛰지 말 것)

> **`resource-links.md` 파일을 Read하세요.** 제조업 15개 + AI 15개 링크 + 프롬프트가 정리되어 있습니다.
> Read("lesson-modules/practice-13-knowledge-manager/resource-links.md")

수강생에게 리스트를 보여주고:
1. 먼저 Anthropic/OpenAI/DeepMind 필수 3개 링크를 km-lite로 아카이빙
2. 그 다음 제조업에서 2-3개 + AI에서 2-3개 골라서 추가 아카이빙
3. 아카이빙 완료 후 vault 통합 정리 + 그래프 연결 확인

resource-links.md에 프롬프트 템플릿과 연결 확인 검색 프롬프트가 모두 포함되어 있습니다.

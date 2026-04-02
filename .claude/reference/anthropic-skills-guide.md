# Anthropic Skills Guide - Quick Reference

> 스킬 개발 시 빠르게 참조하는 치트시트.
> 상세 내용: Obsidian vault의 `Research/Anthropic-Skills-Guide-종합-가이드-MOC-2026-02.md`

---

## YAML Frontmatter 최소 템플릿

```yaml
---
name: your-skill-name
description: What it does. Use when user asks to [trigger phrases].
---
```

## 전체 YAML 템플릿

```yaml
---
name: skill-name
description: [WHAT + WHEN + KEY capabilities]
license: MIT
allowed-tools: "Bash(python:*) Bash(npm:*) WebFetch"
metadata:
  author: Your Name
  version: 1.0.0
  mcp-server: server-name
  category: productivity
  tags: [tag1, tag2]
---
```

---

## Description 작성 공식

```
[WHAT: 무엇을 하는가] + [WHEN: 언제 사용하는가] + [KEY: 핵심 역량]
```

### 좋은 예
```yaml
description: Manages Linear project workflows including sprint planning,
  task creation, and status tracking. Use when user mentions "sprint",
  "Linear tasks", "project planning", or asks to "create tickets".
```

### 나쁜 예
```yaml
description: Helps with projects.               # 너무 모호
description: Creates sophisticated systems.       # 트리거 누락
```

---

## 폴더 구조

```
your-skill-name/          # kebab-case만!
├── SKILL.md              # 필수 (정확한 대소문자)
├── scripts/              # 선택 - Python, Bash 등
├── references/           # 선택 - 문서
└── assets/               # 선택 - 템플릿 등
```

### 네이밍 규칙
- ✅ kebab-case: `notion-project-setup`
- ❌ 공백: `My Skill`, 대문자: `MySkill`, 언더스코어: `my_skill`
- ❌ "claude"/"anthropic" 접두사 (예약어)
- ❌ 스킬 폴더 안에 README.md (금지)

---

## SKILL.md 구조 템플릿

```markdown
---
name: your-skill
description: [WHAT + WHEN]
---

# Your Skill Name

## Instructions
### Step 1: [단계명]
[설명 + 명령어]
Expected output: [성공 모습]

## Examples
### Example 1: [시나리오]
User says: "..."
Actions: 1. ... 2. ...
Result: ...

## Troubleshooting
**Error:** [에러]
**Cause:** [원인]
**Solution:** [해결]
```

---

## 5가지 아키텍처 패턴

| # | 패턴 | 사용 시기 |
|---|------|----------|
| 1 | **Sequential Workflow** | 정해진 순서의 다단계 작업 |
| 2 | **Multi-MCP Coordination** | 여러 서비스를 걸치는 워크플로우 |
| 3 | **Iterative Refinement** | 반복으로 품질 개선 |
| 4 | **Context-Aware Tool Selection** | 맥락에 따라 다른 도구 선택 |
| 5 | **Domain-Specific Intelligence** | 도메인 전문 지식 + 규정 준수 |

---

## 보안 금지사항

| 금지 | 이유 |
|------|------|
| YAML에 XML 태그 `<` `>` | 시스템 프롬프트 인젝션 |
| YAML 내 코드 실행 | Safe YAML 파싱 |
| "claude"/"anthropic" 이름 | 예약 네임스페이스 |

---

## 테스트 체크리스트

### 트리거 테스트
- ✅ 명확한 작업에서 트리거
- ✅ 패러프레이즈에서도 트리거
- ❌ 비관련 주제에서 트리거 안 됨

### 기능 테스트
- 올바른 출력 생성
- API 호출 성공
- 에러 핸들링 작동
- 에지 케이스 커버

---

## 트러블슈팅 Quick Fix

| 문제 | 해결 |
|------|------|
| 업로드 실패 | SKILL.md 대소문자, YAML `---` |
| 트리거 안 됨 | description에 사용자 문구 추가 |
| 너무 자주 트리거 | 부정 트리거 `Do NOT use for...` |
| MCP 실패 | 스킬 없이 MCP 직접 테스트 |
| 지시사항 미준수 | 핵심 상단 배치, 스크립트 검증 |
| 느림 | SKILL.md < 5000단어, 활성 스킬 < 50 |

---

## 배포 옵션

| 방법 | 대상 |
|------|------|
| ZIP → Claude.ai Settings | 개인 |
| 조직 관리자 배포 | 팀/조직 |
| `/v1/skills` API | 프로그래매틱 |
| GitHub 공개 레포 | 오픈소스 |

---

## 참조
- [Anthropic Skills Guide PDF](https://resources.anthropic.com/hubfs/The-Complete-Guide-to-Building-Skill-for-Claude.pdf)
- [GitHub 정리본](https://github.com/corca-ai/claude-plugins/blob/main/references/anthropic-skills-guide/)
- [공식 Skills 레포](https://github.com/anthropics/skills)

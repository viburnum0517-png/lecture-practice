---
description: AI 벤치마크 리서치 + GPTs/Gems 순위 업데이트 (/research). "벤치마크 업데이트", "모델 순위 갱신", "최신 벤치마크" 요청 시 사용.
allowedTools: WebSearch, WebFetch, Read, Write, Edit, Bash, Glob, Grep, AskUserQuestion, Skill
---

# /research — AI 벤치마크 리서치

> 벤치마크 조사 → 순위 업데이트 → 배포 동기화
> Skill("prompt") 활용 리서치 + /tofu-at·/tofu-at-codex 멀티에이전트 옵션
> 참조 스킬: `benchmark-research.md` (모델명 매핑, 소스 전략, 파일 수정 규칙)

$ARGUMENTS

## 사용법

```
/research                   # 싱글 에이전트: /prompt로 리서치 → 업데이트 → push
/research --dry-run          # 조사만, 파일 변경 없음
/research --no-push          # 업데이트까지만, push 생략
/research --only text,code   # 특정 카테고리만
/research --team             # /tofu-at Agent Teams로 실행
/research --codex            # /tofu-at-codex Codex 하이브리드로 실행
```

## Phase 0: 모드 라우팅

$ARGUMENTS 파싱:
- `--team`  → Skill("tofu-at", args: "scan .claude/commands/research.md") → 위임 종료
- `--codex` → Skill("tofu-at-codex", args: "scan .claude/commands/research.md") → 위임 종료
- (없음)    → 싱글 에이전트 모드 → Phase 1 진행

## Phase 1: 현재 상태 확인

1. Read 현재 순위 파일:
   - prompt-engineering-skills/instructions/Gems-Prompt-Generator.md
   - prompt-engineering-skills/instructions/GPTs-Prompt-Generator.md
   - .claude/commands/prompt.md
2. 현재 순위 테이블 추출 → current_rankings
3. 조사 카테고리 결정 (--only 또는 전체 6개: text, code, vision, search, image, video)

## Phase 2: Skill("prompt") 리서치 프롬프트 생성 + 실행

Skill("prompt") 호출하여 리서치 프롬프트 생성:

```
Skill("prompt", args: "<리서치 컨텍스트>")
```

<리서치 컨텍스트> 구성:
- 조사 목적: LMArena + Artificial Analysis 벤치마크 최신 순위 조사
- 카테고리: {Phase 1에서 결정된 목록}
- 소스: LMArena (text/code/vision/search/image), Artificial Analysis (video + 교차검증)
- 추출 대상: 각 카테고리 Top 5 모델 + Elo 점수
- 현재 순위: {current_rankings에서 추출한 요약}
- 참조: benchmark-research.md의 소스별 조사 전략
- 출력 형식: 카테고리별 Top 5 테이블 (모델명, Elo, 소스)

→ /prompt가 분석/리서치 타입 감지 → 리서치 개요 생성 → 프롬프트 생성 → 사용자 승인 → 실행
→ 실행 결과: new_rankings (카테고리별 Top 5)

## Phase 3: 검증 + Diff

### 3-1. 모델명 정규화

수집된 모델명을 프로젝트 명명 규칙으로 매핑:
> 매핑 테이블: `.claude/skills/benchmark-research.md` § 모델명 매핑 참조

```
예시:
"claude-opus-4-6" → "Claude Opus 4.6"
"gpt-5.4" → "GPT-5.4"
"gemini-3.1-pro-preview" → "Gemini 3.1 Pro"
매핑에 없는 모델 → 경고 플래그 + 원본명 유지
```

### 3-2. Diff 생성

```
FOR each 카테고리:
  비교: current_rankings[category] vs new_rankings[category]
  IF 동일 → skip
  IF 다름 → diff_list에 추가

IF diff_list 비어있음 → "변경 없음" 리포트 → 종료
```

### Gate: 변동 규모 확인

```
IF Top-3 중 3개+ 교체 (한 카테고리):
  → "⚠️ 대규모 변동" 경고
```

## Phase 4: 변경 승인

변경 사항 테이블 표시:

```markdown
## 벤치마크 변경 사항 ({날짜})

| 카테고리 | 순위 | 기존 | 신규 | 변동 |
|----------|------|------|------|------|
| ...      | ...  | ...  | ...  | ↑/↓/= |

출처: LMArena ({날짜}), Artificial Analysis ({날짜})
```

```
AskUserQuestion("위 변경사항을 반영할까요?")
→ IF --dry-run → 리포트만 출력 → 종료
```

## Phase 5: 파일 업데이트

> 수정 규칙: `.claude/skills/benchmark-research.md` § 파일 수정 규칙 참조

1. Edit Gems-Prompt-Generator.md (5개 테이블 + 모델별 블록 + Version/Updated)
2. Edit GPTs-Prompt-Generator.md (추천 모델 섹션 + Version)
3. Edit commands/prompt.md (순위 테이블, 해당 시)
4. Gate: Read로 수정 검증 (테이블 구조, 빈 셀, 기존 콘텐츠 보존)

## Phase 6: 동기화 + Push

> IF --no-push → "파일 업데이트 완료" → 종료

### 6-1. 사본 동기화 (4곳)

```bash
# .claude/ 사본
cp prompt-engineering-skills/instructions/GPTs-Prompt-Generator.md .claude/commands/ 2>/dev/null
cp prompt-engineering-skills/instructions/Gems-Prompt-Generator.md .claude/skills/ 2>/dev/null
cp prompt-engineering-skills/commands/prompt.md .claude/commands/

# Obsidian vault (Windows)
cp prompt-engineering-skills/instructions/GPTs-Prompt-Generator.md "/mnt/c/Users/treyl/Documents/Obsidian/Second_Brain/Prompt-Engineering/"
cp prompt-engineering-skills/instructions/Gems-Prompt-Generator.md "/mnt/c/Users/treyl/Documents/Obsidian/Second_Brain/Prompt-Engineering/"
```

### 6-2. 시크릿 스캔

```bash
grep -rn "ntn_[a-zA-Z0-9]" --include="*.md" prompt-engineering-skills/ | grep -v "ntn_xxx"
# 발견 시 push 차단 + 경고
```

### 6-3. Git Commit + Push (WSL 리포)

```
git add prompt-engineering-skills/instructions/ .claude/
git commit -m "벤치마크 순위 업데이트 ({날짜}): {변경 요약}"
git push origin master
```

## 자연어 트리거

| 트리거 | 매핑 |
|--------|------|
| "벤치마크 업데이트" | `/research` |
| "최신 모델 순위 확인" | `/research --dry-run` |
| "프롬프트 생성기 순위 갱신" | `/research` |
| "LMArena 확인" | `/research --dry-run` |

## /tofu-at 워크플로우 호환 정보

이 커맨드를 `scan`으로 실행 시 참고:

### 병렬화 가능 작업 (Phase 2)

| 작업 단위 | 소스 | 카테고리 |
|-----------|------|----------|
| LMArena 텍스트/코드 | lmarena.ai | text, code, vision, search |
| LMArena 이미지 | lmarena.ai | text-to-image |
| AA 동영상 + 교차검증 | artificialanalysis.ai | text-to-video + 전체 교차검증 |

### 의존성

Phase 1 → Phase 2 (병렬) → Phase 3 (순차) → Phase 4 → Phase 5 → Phase 6

### 권장 역할

| 역할 | 담당 |
|------|------|
| Worker A | LMArena text/code/vision/search 수집 |
| Worker B | LMArena image + AA video 수집 |
| Worker C | AA 교차검증 (Intelligence Index) |
| DA | 수집 결과 정확성 리뷰 |

---

**Version**: 2.0.0 | **Created**: 2026-03-08 | **Updated**: 2026-03-09
**Changes v2.0.0**: 하드코딩 Agent Teams 제거, Skill("prompt") 기반 리서치로 전환, --team/--codex 모드 라우팅 추가

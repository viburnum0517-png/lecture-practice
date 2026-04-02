# /prompt-sync - 프롬프트 생성기 통합 업데이트 에이전트

프롬프트 생성기 시스템(GPTs, Gems, Skills, Obsidian)을 일괄 또는 개별적으로 업데이트합니다.

> **Version**: 2.0.0 | **Updated**: 2026-02-02

## 사용자 입력
$ARGUMENTS

---

## 🚨 파일 구조 및 저장소 교통정리 (CRITICAL)

### 1. 두 개의 독립적인 Git 저장소

```
📁 Obsidian/AI/ (부모 저장소 - obsidian-ai-vault)
│   ├── .claude/
│   │   ├── commands/prompt.md        ← Claude Code용 스킬 (로컬 전용)
│   │   └── skills/*.md               ← Claude Code용 스킬 (로컬 전용)
│   └── AI_Second_Brain/              ← Obsidian vault
│
└── 📁 prompt-engineering-skills/ (별도 저장소 - ⭐ PUSH 대상)
        ├── commands/prompt.md         ← Claude Code 스킬 원본
        ├── instructions/
        │   ├── GPTs-Prompt-Generator.md
        │   └── Gems-Prompt-Generator.md
        └── skills/*.md                ← 스킬 파일 원본
```

### 2. 파일 저장 규칙

| 파일 유형 | 원본 위치 (수정 대상) | 사본 위치 (동기화 대상) |
|----------|----------------------|------------------------|
| **GPTs 프롬프트** | `prompt-engineering-skills/instructions/GPTs-Prompt-Generator.md` | Obsidian: `Prompt-Engineering/GPTs-Prompt-Generator-Instructions.md` |
| **Gems 프롬프트** | `prompt-engineering-skills/instructions/Gems-Prompt-Generator.md` | Obsidian: `Prompt-Engineering/Gems-Prompt-Generator-Instructions.md` |
| **Skills (prompt.md)** | `prompt-engineering-skills/commands/prompt.md` | `.claude/commands/prompt.md` |
| **스킬 파일** | `prompt-engineering-skills/skills/*.md` | `.claude/skills/*.md` |

### 3. 수정 및 배포 흐름

```
┌─────────────────────────────────────────────────────────────────┐
│  STEP 1: 원본 파일 수정                                          │
│  📍 prompt-engineering-skills/ 폴더 내 파일만 수정               │
└─────────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────────┐
│  STEP 2: Git Commit & Push                                       │
│  📍 cd prompt-engineering-skills && git push origin master      │
│  🎯 대상: https://github.com/treylom/prompt-engineering-skills   │
└─────────────────────────────────────────────────────────────────┘
                              ↓
┌─────────────────────────────────────────────────────────────────┐
│  STEP 3: 사본 동기화                                             │
│  - .claude/commands/prompt.md ← prompt-engineering-skills/...   │
│  - .claude/skills/*.md ← prompt-engineering-skills/skills/...    │
│  - Obsidian vault ← GPTs/Gems instructions                      │
└─────────────────────────────────────────────────────────────────┘
```

### 4. ⚠️ 절대 하면 안 되는 것

❌ **부모 폴더(Obsidian/AI)에서 git push** → 잘못된 저장소로 푸시됨
❌ **`.claude/` 폴더 파일만 수정** → 원본이 업데이트 안 됨
❌ **Obsidian에서 직접 수정** → GitHub와 동기화 깨짐

---

## ⚠️ CRITICAL: 필수 완료 체크리스트 (NEVER SKIP)

**모든 업데이트 작업 완료 후 반드시 아래 단계를 순서대로 실행:**

| # | 단계 | 명령어/도구 | 확인 사항 |
|---|------|------------|----------|
| 1 | **원본 수정** | Edit 도구 | `prompt-engineering-skills/` 내 파일 수정 |
| 2 | **Git Commit** | `cd prompt-engineering-skills && git add . && git commit` | 커밋 메시지 포함 |
| 3 | **Git Push** | `git push origin master` | treylom/prompt-engineering-skills로 푸시 |
| 4 | **사본 동기화** | Edit 또는 Obsidian MCP | `.claude/` 및 Obsidian vault 동기화 |
| 5 | **결과 보고** | 마크다운 테이블 | Step 8 형식 준수 |

**⛔ Compact/Context 전환 시에도 이 단계들은 반드시 완료해야 함**

---

## 서브 스킬 참조

개별 작업 시 아래 스킬 파일을 로드하여 상세 지침을 따릅니다:

| 모드 | 스킬 파일 | 용도 |
|------|----------|------|
| B | `.claude/skills/prompt-sync-gpts.md` | GPTs만 업데이트 |
| C | `.claude/skills/prompt-sync-gems.md` | Gems만 업데이트 (테이블 포맷 주의) |
| D | `.claude/skills/prompt-sync-skills.md` | Skills만 업데이트 |
| E | `.claude/skills/prompt-sync-obsidian.md` | Obsidian 동기화만 |

---

## 연동 스킬 파일 (참조 및 동기화 대상)

수정 유형에 따라 아래 스킬을 함께 참조하고, **두 경로 모두 동기화**합니다:

| 수정 유형 | `.claude/skills/` | `prompt-engineering-skills/skills/` |
|----------|-------------------|-------------------------------------|
| 이미지 생성 | `image-prompt-guide.md` | `image-prompt-guide.md` |
| 리서치/팩트체크 | `research-prompt-guide.md` | `research-prompt-guide.md` |
| 모델별 전략 | `prompt-engineering-guide.md` | `prompt-engineering-guide.md` |
| GPT-5.2 최적화 | `gpt-5.4-prompt-enhancement.md` | `gpt-5.4-prompt-enhancement.md` |
| Gemini 최적화 | `gemini-3.1-prompt-strategies.md` | `gemini-3.1-prompt-strategies.md` |
| Claude 최적화 | `claude-4.6-prompt-strategies.md` | `claude-4.6-prompt-strategies.md` |
| CE 원칙 | `context-engineering-collection.md` | - |

**CRITICAL**: 연동 스킬 수정 시, 반드시 **두 경로 모두** 동일하게 업데이트해야 합니다.

---

## 관리 대상 파일

| # | 타겟 | 파일 경로 | 현재 버전 |
|---|------|----------|----------|
| 1 | **GPTs** | `instructions/GPTs-Prompt-Generator.md` | v4.0.0 |
| 2 | **Gems** | `instructions/Gems-Prompt-Generator.md` | v3.0.0 |
| 3 | **Skills** | `commands/prompt.md` | v3.0.0 |
| 4 | **Obsidian GPTs** | `Prompt-Engineering/GPTs-Prompt-Generator-Instructions.md` | (동기화) |
| 5 | **Obsidian Gems** | `Prompt-Engineering/Gems-Prompt-Generator-Instructions.md` | (동기화) |

---

## 워크플로우

### Step 1: 작업 모드 선택

사용자 입력이 없으면 아래 폼 표시:

```
프롬프트 생성기 업데이트 에이전트입니다.

🔄 작업 모드 선택:

A. 전체 동시 업데이트 - GPTs, Gems, Skills 모두 수정 후 Obsidian 동기화
B. GPTs만 업데이트 - GPTs-Prompt-Generator.md + Obsidian 동기화
C. Gems만 업데이트 - Gems-Prompt-Generator.md + Obsidian 동기화
D. Skills만 업데이트 - commands/prompt.md 수정
E. Obsidian 동기화만 - GitHub 최신본을 Obsidian에 동기화
F. 버전 확인 - 현재 각 파일의 버전 상태 확인

💬 입력 예시:
   • "A" → 전체 동시 업데이트 시작
   • "B, 입력 폼에 예시 추가해줘" → GPTs만 수정
   • "E" → Obsidian 동기화만 실행
   • "입력 폼 개선" → 자동으로 전체 업데이트 모드

⏳ 선택을 기다리고 있습니다...
```

### Step 2: 전체 파일 읽기 (CRITICAL - 병렬 실행)

**수정 전 반드시 실행:**

#### 2.1 대상 파일 읽기 (Read 도구, 병렬)

모드에 관계없이 **전체 파일을 먼저 읽어** 현재 상태를 파악합니다:

```
Task 1: GPTs 읽기
- prompt-engineering-skills/instructions/GPTs-Prompt-Generator.md

Task 2: Gems 읽기
- prompt-engineering-skills/instructions/Gems-Prompt-Generator.md

Task 3: Skills 읽기
- prompt-engineering-skills/commands/prompt.md
```

#### 2.2 관련 스킬 읽기 (변경 내용에 따라 선택적)

변경 유형에 맞는 연동 스킬 파일을 **두 경로 모두** 읽습니다:

| 변경 유형 | 읽어야 할 스킬 (두 경로 모두) |
|----------|------------------------------|
| 이미지 프롬프트 수정 | `.claude/skills/image-prompt-guide.md` + `prompt-engineering-skills/skills/image-prompt-guide.md` |
| 리서치 기능 수정 | `.claude/skills/research-prompt-guide.md` + `prompt-engineering-skills/skills/research-prompt-guide.md` |
| 모델 순위/전략 업데이트 | `.claude/skills/prompt-engineering-guide.md` + `prompt-engineering-skills/skills/prompt-engineering-guide.md` |
| 특정 모델 최적화 | 해당 모델 전략 파일 (두 경로 모두) |

#### 2.3 현재 버전 확인

각 파일의 Version 헤더를 파악하고 기록합니다.

#### 2.4 변경 영향도 분석

수정 사항이 어느 파일에 적용되어야 하는지 판단:
- 공통 적용 (GPTs, Gems, Skills 모두)
- 특정 타겟만 (예: Skills만)
- 연동 스킬 수정 필요 여부

### Step 3: 스킬 로드 및 변경 사항 수집

모드 선택에 따라 해당 스킬 파일을 로드합니다:
- **모드 B**: `.claude/skills/prompt-sync-gpts.md` 로드
- **모드 C**: `.claude/skills/prompt-sync-gems.md` 로드
- **모드 D**: `.claude/skills/prompt-sync-skills.md` 로드
- **모드 E**: `.claude/skills/prompt-sync-obsidian.md` 로드
- **모드 A**: 전체 스킬 순차 참조

변경 사항 수집:
1. **수정 내용 확인**: 어떤 변경을 할 것인지 명확히 정리
2. **영향 범위 파악**: 해당 변경이 다른 파일에도 적용되어야 하는지 확인
3. **⚠️ 버전 번호 사용자 확인 (CRITICAL - 반드시 질문)**:
   - 수정 적용 전에 **반드시** 사용자에게 버전 번호를 물어볼 것
   - AskUserQuestion으로 질문: "이번 수정의 버전 번호를 어떻게 할까요?"
   - 옵션 예시: 현재 버전 유지 / 패치(0.0.x) / 마이너(0.x.0) / 메이저(x.0.0) / 직접 입력
   - **자동으로 버전을 올리지 말 것** - 반드시 사용자 확인 후 적용

### Step 4: 병렬 서브에이전트 실행

모드 A(전체 업데이트) 선택 시, 다음 서브에이전트들을 **병렬 실행**:

```
Task 1: GPTs 업데이트 (prompt-sync-gpts.md 스킬 참조)
- 대상: instructions/GPTs-Prompt-Generator.md
- 작업: 수정 내용 적용, 버전 업데이트, Changelog 추가

Task 2: Gems 업데이트 (prompt-sync-gems.md 스킬 참조)
- 대상: instructions/Gems-Prompt-Generator.md
- 작업: 수정 내용 적용, 버전 업데이트, Changelog 추가
- 주의: 코드블록 대신 마크다운 테이블 사용 (Gems 렌더링 이슈)

Task 3: Skills 업데이트 (prompt-sync-skills.md 스킬 참조)
- 대상: commands/prompt.md
- 작업: 수정 내용 적용, 버전 업데이트
```

### Step 4.5: 글자 수 검증 (CRITICAL - GPTs 전용)

> ⚠️ **GPTs Instructions 제한: 8,000자**
> 수정 완료 후 반드시 글자 수 확인!

**검증 명령어:**
```bash
node -e "const fs = require('fs'); const c = fs.readFileSync('prompt-engineering-skills/instructions/GPTs-Prompt-Generator.md', 'utf8'); console.log('GPTs 글자수:', c.length, '/ 8000');"
```

**결과 판단:**
| 글자 수 | 상태 | 조치 |
|---------|------|------|
| ≤ 7,500자 | ✅ 안전 | 진행 |
| 7,501-8,000자 | ⚠️ 경고 | 축소 권장 |
| > 8,000자 | ❌ 초과 | **반드시 축소 후 진행** |

**축소 우선순위** (영향 최소화):
1. Changelog (이전 버전 기록) 제거 - 최신 버전만 유지
2. 예시 코드블록 간소화
3. 테이블 컬럼 축소
4. 중복 설명 문구 제거
5. 상세 설명 → 간략 설명으로 변경

---

### Step 5: 연동 스킬 파일 동기화 (CRITICAL)

**연동 스킬 수정 시 반드시 두 경로 모두 업데이트:**

```
경로 1: .claude/skills/
경로 2: prompt-engineering-skills/skills/
```

**동기화 워크플로우:**

1. **수정할 스킬 파일 식별**: 변경 유형에 따라 해당 스킬 확인
2. **두 경로 모두 읽기**: 현재 상태 및 버전 확인
3. **동일하게 수정**: 같은 변경사항을 두 경로에 모두 적용
4. **버전 동기화**: 두 파일의 버전이 일치하는지 확인

**예시:**
```
수정 대상: prompt-engineering-guide.md (Step 1.7 추가)

파일 1: .claude/skills/prompt-engineering-guide.md → v1.4.0
파일 2: prompt-engineering-skills/skills/prompt-engineering-guide.md → v1.4.0
```

### Step 6: Git 커밋 및 푸시

> ⚠️ **CRITICAL: prompt-engineering-skills는 별도 Git 저장소입니다!**
> - **저장소 URL**: https://github.com/treylom/prompt-engineering-skills
> - **경로**: `prompt-engineering-skills/` (부모 Obsidian/AI 폴더와 별개)
> - 부모 폴더에서 push하면 **잘못된 저장소**로 푸시됨

모든 수정 완료 후:

```bash
# 1. 반드시 prompt-engineering-skills 폴더로 이동
cd prompt-engineering-skills

# 2. 현재 저장소 확인 (treylom/prompt-engineering-skills 인지 확인)
git remote -v

# 3. 변경사항 스테이징 및 커밋
git add .
git commit -m "Update prompt generators: [변경 요약]"

# 4. 별도 저장소로 푸시
git push origin master
```

**주의사항**:
- `prompt-engineering-skills/` 폴더는 독립적인 Git 저장소
- 부모 폴더 `Obsidian/AI`와는 **완전히 별개의 저장소**
- 부모 폴더에서 `git push` 하면 **틀린 저장소로 푸시**되므로 주의

### Step 7: Obsidian 동기화

**prompt-sync-obsidian.md 스킬 참조**

**방식**: `mcp__obsidian__update_note`를 사용하여 변경 사항만 업데이트합니다.

```
1. GitHub 최신 파일 내용 읽기 (Read 도구)
2. Obsidian 기존 노트 읽기 (mcp__obsidian__read_note)
3. 변경된 섹션 식별
4. update_note로 변경 사항만 적용:
   - mcp__obsidian__update_note(path: "...", edits: [{oldText: "...", newText: "..."}])

전체 교체가 필요한 경우 (구조 변경 등):
- edits 배열에 전체 내용을 oldText/newText로 지정
- 또는 섹션별로 분리하여 순차 업데이트
```

**update_note 사용 예시:**
```javascript
mcp__obsidian__update_note({
  path: "Prompt-Engineering/GPTs-Prompt-Generator-Instructions.md",
  edits: [
    {
      oldText: "> **Version**: 3.8.1",
      newText: "> **Version**: 4.0.0"
    },
    {
      oldText: "## 전문가 3인 퇴고 (선택)",
      newText: "## 전문가 3인 토론 (필수 - 자동 실행)"
    }
  ]
})
```

**주의사항:**
- `oldText`는 정확히 일치해야 함 (공백, 줄바꿈 포함)
- 매칭 실패 시 `dryRun: true`로 먼저 테스트
- 대규모 변경 시 섹션별로 나누어 순차 적용

### Step 8: 결과 보고

```markdown
## 업데이트 완료 ✅

### 변경된 파일
| 파일 | 이전 버전 | 새 버전 | 상태 |
|------|----------|--------|------|
| GPTs-Prompt-Generator.md | vX.X.X | vX.X.X | ✅ |
| Gems-Prompt-Generator.md | vX.X.X | vX.X.X | ✅ |
| commands/prompt.md | vX.X.X | vX.X.X | ✅ |
| Obsidian GPTs | - | 동기화됨 | ✅ |
| Obsidian Gems | - | 동기화됨 | ✅ |

### 연동 스킬 파일 동기화
| 스킬 | .claude/skills/ | prompt-engineering-skills/skills/ |
|------|-----------------|-----------------------------------|
| prompt-engineering-guide.md | vX.X.X ✅ | vX.X.X ✅ |
| [기타 수정된 스킬] | vX.X.X ✅ | vX.X.X ✅ |

### 변경 내용
- [변경 사항 요약]

### Git
- Commit: [커밋 해시]
- Push: ✅ 완료
```

---

## 개별 모드 상세

### 모드 B: GPTs만 업데이트
→ **스킬 로드**: `.claude/skills/prompt-sync-gpts.md`

### 모드 C: Gems만 업데이트
→ **스킬 로드**: `.claude/skills/prompt-sync-gems.md`
⚠️ 코드블록 → 마크다운 테이블 변환 필수

### 모드 D: Skills만 업데이트
→ **스킬 로드**: `.claude/skills/prompt-sync-skills.md`
(Obsidian 동기화 없음)

### 모드 E: Obsidian 동기화만
→ **스킬 로드**: `.claude/skills/prompt-sync-obsidian.md`

### 모드 F: 버전 확인
모든 파일의 현재 버전 읽어서 테이블로 표시.

---

## 버전 관리 규칙

### ⚠️ 버전 번호는 반드시 사용자에게 먼저 질문 (CRITICAL)

**수정 적용 전에 반드시 사용자에게 버전 번호를 물어봐야 합니다.**
- 자동으로 버전을 올리지 말 것
- 사용자가 지정한 버전 번호를 그대로 사용
- 모든 파일의 버전을 통일할지, 개별 관리할지도 사용자 결정

### 버전 번호 체계
- **메이저 (x.0.0)**: 구조적 변경, 새로운 섹션 추가
- **마이너 (0.x.0)**: 기능 추가, 옵션 추가
- **패치 (0.0.x)**: 버그 수정, 오타 수정, 설명 개선

### Changelog 형식
```markdown
**Changes vX.Y.Z**:
- 변경 내용 1
- 변경 내용 2
```

### 동기화 원칙
- GPTs/Gems 수정 시 반드시 Obsidian 동기화 포함
- Skills는 GitHub만 (Claude Code 전용이므로)
- 버전은 각 파일마다 독립적으로 관리

---

## 파일 경로 참조

### GitHub Repository
```
C:\Users\treyl\OneDrive\Desktop\AI\prompt-engineering-skills\
├── instructions/
│   ├── GPTs-Prompt-Generator.md
│   └── Gems-Prompt-Generator.md
└── commands/
    └── prompt.md
```

### Obsidian Vault (vault root 기준)
```
Prompt-Engineering/
├── GPTs-Prompt-Generator-Instructions.md
└── Gems-Prompt-Generator-Instructions.md
```

---

## Metadata

- **Version**: 2.0.0
- **Created**: 2025-12-28
- **Changes v2.0.0**:
  - **[CRITICAL] 버전 번호 사용자 확인 규칙 추가**: 수정 적용 전 반드시 사용자에게 버전 번호 질문
  - **버전 관리 규칙 섹션 강화**: 자동 버전 업 금지, 사용자 결정 우선 원칙
- **Changes v1.8.0**:
  - **[CRITICAL] Step 4.5 글자 수 검증 추가**: GPTs Instructions 8,000자 제한 체크
  - **검증 명령어 제공**: Node.js 기반 글자 수 측정
  - **축소 우선순위 가이드**: Changelog 제거 → 예시 간소화 → 테이블 축소 순서
  - **상태별 조치 테이블**: 안전/경고/초과 3단계 판단 기준
- **Changes v1.7.0**:
  - **[CRITICAL] 파일 구조 교통정리**: 두 저장소 구조, 원본/사본 개념, 수정 흐름 명확화
  - **시각적 다이어그램 추가**: 파일 구조 트리 및 워크플로우 플로우차트
  - **원본/사본 테이블 추가**: 어떤 파일이 원본이고 어디로 동기화되는지 명시
  - **절대 금지 사항 명시**: 부모 폴더 push, .claude 파일만 수정, Obsidian 직접 수정 금지
  - **필수 체크리스트 5단계로 재구성**: 원본 수정 → Commit → Push → 동기화 → 보고
- **Changes v1.6.0**:
  - **[CRITICAL] 별도 저장소 push 단계 명확화**: `prompt-engineering-skills`가 독립적인 Git 저장소임을 강조
  - **저장소 URL 및 경고 추가**: https://github.com/treylom/prompt-engineering-skills
  - **부모 폴더 push 실수 방지**: 잘못된 저장소로 push하는 실수 방지 안내 추가
- **Changes v1.5.0**:
  - **[CRITICAL] 필수 완료 체크리스트 추가**: 상단에 Obsidian 동기화 + Git Push 필수 단계 명시
  - **Compact/Context 전환 대응**: 중단되어도 필수 단계는 반드시 완료하도록 강조
- **Changes v1.4.0**:
  - **[MAJOR] 두 경로 스킬 파일 동기화**: `.claude/skills/`와 `prompt-engineering-skills/skills/` 모두 관리
  - **Step 5 "연동 스킬 파일 동기화" 추가**: 두 경로 동시 업데이트 워크플로우
  - **결과 보고에 스킬 동기화 상태 추가**: 두 경로의 버전 일치 확인
- **Changes v1.3.0**:
  - **[MAJOR] 전체 파일 읽기 단계 추가**: 수정 전 대상 파일 + 연동 스킬 파일을 먼저 읽음
  - **연동 스킬 파일 목록 추가**: 수정 유형별 참조할 스킬 정리
  - **병렬 파일 읽기 패턴 도입**: Task 도구로 병렬 처리
- **Changes v1.2.0**:
  - Obsidian 동기화 방식 변경: delete→create 패턴에서 update_note 방식으로 전환
  - 변경 사항만 업데이트하여 노트 히스토리 보존
  - update_note 사용 예시 및 주의사항 추가
- **Author**: Claude Code Agent
- **Related Commands**: `/prompt`
- **Sub-Skills**:
  - `prompt-sync-gpts.md`
  - `prompt-sync-gems.md`
  - `prompt-sync-skills.md`
  - `prompt-sync-obsidian.md`

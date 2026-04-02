# Claude Code 환경 마이그레이션 가이드

새 컴퓨터에서 Claude Code 환경을 똑같이 세팅하는 방법입니다.

---

## 지원 플랫폼

| 플랫폼 | tmux | ai() | Hybrid Team (ct) | 자동싱크 |
|--------|------|------|-------------------|----------|
| Linux (Ubuntu/Debian) | O | O | O | cron |
| WSL (Windows + Linux) | O | O | O | cron |
| macOS | O | O | O | launchd |
| Windows 네이티브 | X | O (tmux 없이) | X | Task Scheduler |

> **일반 개인용 환경은 WSL 권장**입니다. 다만 **성우하이텍 lecture 배포본은 Windows 네이티브 전용**으로 운영하며, tmux/Hybrid Team 없이 진행합니다.

---

## 준비물

1. **인터넷 연결**
2. **GitHub 계정** (treylom) 로그인 가능
3. **Anthropic 계정** (Claude Code 인증용)
4. (선택) API 키: Notion 토큰, Hyperbrowser 키

---

## 1단계: 현재 머신에서 최신 상태 푸시

지금 사용 중인 컴퓨터에서 먼저 실행:

```bash
cd ~/AI && git add -A && git commit -m "pre-migration sync" && git push
```

또는 `ai-sync` 명령이 있다면:

```bash
ai-sync
```

---

## 2단계: 새 컴퓨터에서 셋업 스크립트 실행

### 방법 A: 직접 다운로드 (권장)

```bash
curl -fsSL https://raw.githubusercontent.com/treylom/obsidian-ai-vault/master/.claude/migration/env-setup.sh -o env-setup.sh
chmod +x env-setup.sh
./env-setup.sh
```

### 방법 A-lecture: Windows lecture 설치 (PowerShell)

성우하이텍 lecture 배포용은 WSL 없이 Windows 네이티브로 설치합니다. 이 경로는 **가벼움보다 안정성 우선**으로 설계되어, 설치 후 self-check까지 수행합니다.

```powershell
cd $HOME\AI
powershell -ExecutionPolicy Bypass -File .\.claude\migration\install-lecture-windows.ps1
```

이 경로는 다음을 한 번에 처리합니다.
- Git / Python / Node.js / jq / GitHub CLI 설치 확인
- Claude Code 설치
- `claude auth login`
- repo clone/pull
- `claude-bootstrap.sh --profile lecture`
- `git/node/npm/gh/jq/claude --version` self-check
- `lecture.md`, `autoresearch.md`, `tofu-at-codex.md`, `lesson-sungwoo` 자산 검증

### 방법 A-full: 개인용 full 설치 (멀티플랫폼)

개인용 full 환경은 **멀티플랫폼** 기준으로 설치합니다. Mac / Linux / WSL / Windows 동기화 전제를 둡니다.

```bash
cd ~/AI
bash ./.claude/migration/install-full.sh
```

이 경로는 다음을 목표로 합니다.
- `claude-bootstrap.sh --profile full`
- GraphRAG / tofu-at / agent-office 설치 흐름
- `env-sync` / `bashrc-functions.sh` / `setup-tofu-at-codex.sh` 등 개인용 helper 준비
- 핵심 설치 실패 시 중단하는 stricter full bootstrap

### 방법 B: 리포 먼저 클론

```bash
git clone https://github.com/treylom/obsidian-ai-vault.git ~/AI
chmod +x ~/AI/.claude/migration/env-setup.sh
~/AI/.claude/migration/env-setup.sh
```

### 방법 C: USB/파일 전송

스크립트를 복사한 후:

```bash
chmod +x env-setup.sh
./env-setup.sh
```

### 미리보기 (아무것도 변경하지 않고 확인만)

```bash
./env-setup.sh --dry-run
```

---

## 3단계: 안내를 따라 진행

스크립트가 13단계로 안내합니다. 각 단계마다:

```
═══════════════════════════════════════════════════
  Phase 1/13: 시스템 패키지 설치
═══════════════════════════════════════════════════
  계속하려면 Enter (건너뛰려면 s, 중단하려면 q):
```

- **Enter**: 진행
- **s**: 이 단계 건너뛰기
- **q**: 전체 중단

### 직접 입력이 필요한 단계

| 단계 | 해야 할 것 |
|------|-----------|
| Phase 5 | 브라우저에서 GitHub 로그인 |
| Phase 11 | URL 열어서 Anthropic/Claude Code 로그인 |
| Phase 12 | (선택) 표시되는 SSH 공개키를 다른 머신에 복사 |

---

## 4단계: API 키 설정 (선택)

Notion이나 Hyperbrowser MCP를 사용하려면:

```bash
nano ~/.mcp-secrets.env
```

실제 값 입력:

```bash
export HYPERBROWSER_API_KEY="hb_실제키"
export NOTION_API_TOKEN="ntn_실제토큰"
```

저장 후 반영:

```bash
source ~/.bashrc
```

---

## 5단계: 테스트

```bash
source ~/.bashrc       # 함수 로드 (또는 새 터미널)
ai                     # Claude Code 시작 (tmux)
ai pass                # + 권한 자동승인
ai pass 1m             # + 1M 컨텍스트
```

---

## 일상 사용법

### 작업 흐름

```
어떤 머신에서든:
  ai → 작업 → 세션 종료 → 자동 git push
                                ↓
다른 머신에서:
  자동 pull (5분) 또는 수동: env-sync.sh pull
```

### 주요 명령어

| 명령어 | 설명 |
|--------|------|
| `ai` | Claude Code 시작 (tmux 세션) |
| `ai pass` | + 권한 자동승인 |
| `ai pass 1m` | + 1M 컨텍스트 |
| `ain [이름]` | 새 tmux 윈도우에서 시작 |
| `ai-sync` | 수동 git push |
| `ct codex` | Hybrid Team (Opus + Codex) |
| `ct-list` | 사용 가능한 모델 프로필 |
| `ct-stop` | 프록시 중지 |
| `cleanup` | tmux 세션 정리 |

### 동기화 명령어

| 명령어 | 설명 |
|--------|------|
| `env-sync.sh pull` | GitHub → 로컬 |
| `env-sync.sh push` | 로컬 → GitHub |
| `env-sync.sh status` | 상태 확인 |
| `env-sync.sh auto-on` | 5분 자동 pull 켜기 |
| `env-sync.sh auto-off` | 자동 pull 끄기 |
| `PEER_HOST=user@host env-sync.sh dotfiles push` | 홈 설정파일 전송 |

### 자동 동기화 설정 (처음 한 번)

```bash
~/AI/.claude/migration/env-sync.sh auto-on
```

이후 5분마다 자동으로 다른 머신의 변경사항을 가져옵니다.

---

## 동기화 대상

### git으로 자동 동기화 (push/pull)
```
~/AI/.claude/commands/        24개 커맨드
~/AI/.claude/skills/          102개 스킬
~/AI/.claude/agents/          13개 에이전트
~/AI/.claude/reference/       5개 참조파일
~/AI/.claude/migration/       셋업/동기화 스크립트
~/AI/CLAUDE.md                프로젝트 규칙
~/AI/agent-office/            대시보드
```

### 머신별 개별 관리
```
~/.claude/settings.json       글로벌 Claude 설정
~/AI/.mcp.json                MCP 서버 + API 키
~/AI/.claude/settings.local.json  프로젝트 권한
~/.mcp-secrets.env            API 시크릿
```

### 절대 동기화 안 함
```
~/.claude.json                인증 토큰
~/.claude/.credentials.json   OAuth
~/.claude/history.jsonl       세션 기록
~/.bash_history               셸 기록
```

---

## 문제 해결

### "claude: command not found"

```bash
source ~/.bashrc
# 또는
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
```

### git pull 충돌

```bash
cd ~/AI
git stash
git pull origin master --rebase
git stash pop
```

안 되면:

```bash
git rebase --abort
git pull origin master
```

### 설정 파일 복구

```bash
ls ~/.claude/settings.json.bak.*    # 백업 목록
cp ~/.claude/settings.json.bak.20260309-1430 ~/.claude/settings.json
```

### macOS에서 brew 없다고 나올 때

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# Apple Silicon인 경우 추가:
eval "$(/opt/homebrew/bin/brew shellenv)"
```

### Windows에서 tmux 관련 에러

Windows 네이티브에서는 tmux가 불가합니다. WSL을 설치하세요:

```powershell
wsl --install
```

설치 후 WSL 터미널에서 이 가이드를 다시 따라하면 됩니다.

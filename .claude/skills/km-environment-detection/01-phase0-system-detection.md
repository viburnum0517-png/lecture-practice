---
name: km-environment-detection-phase0
description: Phase 0: Team OS 인프라 확인, 실행 환경 감지, 크로스 플랫폼 명령어 (Windows/macOS/Linux)
---

# Phase 0: 시스템 환경 감지 (자동 실행)

### 0.0 Team OS 인프라 확인 (최우선!)

**CRITICAL**: 시스템 스펙 감지 전에 반드시 Team OS 인프라를 먼저 확인합니다.

#### 감지 명령어 (크로스 플랫폼)

**Step 1: 프로젝트 루트 확인 (절대 경로 획득)**

```
Bash("pwd") → 현재 작업 디렉토리 확인 → {project_root}
```

**Step 2: .team-os/ 감지 (절대 경로 사용 — WSL 호환)**

```
# 절대 경로로 Glob 수행 (상대 경로 실패 방지)
Glob("{project_root}/.team-os/registry.yaml")
Glob("{project_root}/.team-os/spawn-prompts/*.md")
Glob("{project_root}/.team-os/artifacts/*.md")
```

**Step 3: Glob 실패 시 Bash 폴백 (WSL/권한 문제 대응)**

```
# Glob이 빈 결과를 반환하면 Bash로 직접 확인
Bash("ls -la .team-os/registry.yaml 2>/dev/null && echo EXISTS || echo NOT_FOUND")
Bash("ls .team-os/spawn-prompts/*.md 2>/dev/null | wc -l")
Bash("ls .team-os/artifacts/*.md 2>/dev/null | wc -l")
```

> **WHY**: WSL 환경에서 Glob의 상대 경로가 작업 디렉토리와 불일치할 수 있음.
> 절대 경로 사용 + Bash 폴백으로 크로스 플랫폼 안정성 확보.

#### 분기 로직

```
registry.yaml 존재 AND spawn-prompts >= 3개
  → Team OS: 활성화
  → registry.yaml 읽어서 complexity_mapping, shared_memory 설정 로드
  → spawn-prompts/ 목록 확인하여 사용 가능한 팀원 역할 파악

registry.yaml 존재 AND spawn-prompts < 3개
  → Team OS: 부분 활성화 (일부 팀원만 사용 가능)
  → 사용 가능한 역할만 표시

둘 다 없음
  → Team OS: 비활성
  → 기본 모드로 진행 (Main 단독 또는 병렬 Task 서브에이전트)
```

#### Agent Office 대시보드 통합

```
# 대시보드 실행 확인
Bash("curl -s http://localhost:3747/api/status 2>/dev/null") → JSON 응답 여부

대시보드 실행 중:
  > **Agent Office Dashboard**: http://localhost:3747
  > Team OS, MCP Servers, KM Workflow 실시간 모니터링 중

대시보드 미실행 시:
  > Agent Office 대시보드가 실행되지 않고 있습니다.
  > 시작: `cd agent-office && npm start`
  > 텍스트 모드로 진행합니다.
```

#### 결과 출력 형식

**대시보드 실행 중:**

```markdown
### 환경 현황
**Agent Office Dashboard**: http://localhost:3747 (실시간 모니터링)

| 항목 | 상태 |
|------|------|
| **Team OS** | {활성화 / 부분 활성화 / 비활성} |
| **registry.yaml** | {✅ 존재 / ❌ 없음} |
| **Spawn Prompts** | {✅ N개 / ❌ 없음} |
| **공유 아티팩트** | {✅ N개 / ❌ 없음} |
```

**대시보드 미실행 시 (폴백 — 기존 텍스트 테이블):**

```markdown
### Team OS 인프라
| 항목 | 상태 |
|------|------|
| **registry.yaml** | {✅ 존재 / ❌ 없음} |
| **Spawn Prompts** | {✅ N개 / ❌ 없음} |
| **공유 아티팩트** | {✅ N개 / ❌ 없음} |
| **Team OS 상태** | {활성화 / 부분 활성화 / 비활성} |
```

---

### 0.05 실행 환경 감지 (병렬 모드 결정)

Knowledge Manager의 병렬화 모드는 실행 환경에 따라 자동 결정됩니다.

| 환경 | 병렬화 모드 | 판별 방법 |
|------|-----------|----------|
| **터미널 CLI** (interactive) | Agent Teams (Teammate 인스턴스) | 기본 가정 — `/knowledge-manager` 직접 호출 |
| **VS Code / SDK** | 병렬 Task 서브에이전트 | Task 내부에서 호출된 경우 |

> **IMPORTANT**: Task 도구의 `team_name` 파라미터는 Agent Teams를 활성화하지 **않습니다**.
> VS Code에서는 Team OS가 활성화되어 있어도 Agent Teams 대신 병렬 Task 서브에이전트를 사용합니다.

#### 결과 출력 형식

```markdown
### 실행 환경
| 항목 | 감지 결과 |
|------|----------|
| **환경** | {VS Code / 터미널 CLI} |
| **병렬 모드** | {병렬 Task 서브에이전트 / Agent Teams} |
| **Team OS** | {활성화 / 비활성} |
```

---

### 0.1 실행 조건

| 조건 | 설명 |
|------|------|
| **자동 실행** | Knowledge Manager 첫 실행 시 |
| **수동 실행** | "환경 감지", "시스템 체크", "RAG 설정" 키워드 |
| **재실행** | "환경 재감지", "스펙 다시 확인" 키워드 |

### 0.2 크로스 플랫폼 감지 명령어

**CRITICAL**: 반드시 아래 명령어를 **실제로 Bash 도구로 실행**하여 결과를 수집

#### Windows (PowerShell)
```bash
# RAM
powershell -Command "Get-CimInstance Win32_ComputerSystem | Select-Object TotalPhysicalMemory | Format-List"

# CPU
powershell -Command "Get-CimInstance Win32_Processor | Select-Object Name, NumberOfCores, NumberOfLogicalProcessors | Format-List"

# GPU
powershell -Command "Get-CimInstance Win32_VideoController | Select-Object Name, AdapterRAM | Format-List"

# Disk (가용 공간)
powershell -Command "Get-PSDrive C | Select-Object Free | Format-List"
```

#### macOS
```bash
# RAM
sysctl -n hw.memsize

# CPU
sysctl -n machdep.cpu.brand_string
sysctl -n hw.ncpu

# GPU
system_profiler SPDisplaysDataType 2>/dev/null | grep -E "Chipset|VRAM|Metal"

# Disk
df -h / | tail -1 | awk '{print $4}'
```

#### Linux
```bash
# RAM
grep MemTotal /proc/meminfo

# CPU
lscpu | grep "Model name"
nproc

# GPU
nvidia-smi --query-gpu=name,memory.total --format=csv,noheader 2>/dev/null || echo "No NVIDIA GPU"

# Disk
df -h / | tail -1 | awk '{print $4}'
```

### 0.3 OS 감지 방법

```bash
# 플랫폼 감지 (Bash에서 자동)
# Windows: $env:OS 또는 OSTYPE 없음
# macOS: uname -s → "Darwin"
# Linux: uname -s → "Linux"
```

**실행 순서:**
1. `uname -s 2>/dev/null || echo "Windows"` 로 OS 판별
2. OS에 맞는 감지 명령어 세트 실행
3. 결과 파싱 후 티어 분류

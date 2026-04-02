---
name: km-environment-detection
description: Use when needing Knowledge Manager 환경 감지 스킬. WSL/Windows/macOS 환경별 도구 가용성 자동 판별 및 3-Tier 폴백 설정.
---

# Knowledge Manager 환경 감지 및 RAG 최적화 스킬

> 사용자 시스템을 자동 감지하고, 스펙에 맞는 최적의 검색 기능을 추천·설정합니다.

---

## 스킬 개요

이 스킬은 Knowledge Manager 첫 실행 시 **자동으로** 동작하여:
1. 사용자 시스템 스펙을 감지 (RAM, CPU, GPU)
2. 3단계 티어로 분류 (Basic / Standard / Advanced)
3. 티어별 사용 가능한 검색 기능을 시각적으로 안내
4. 사용자 승인 하에 고급 기능 활성화 가이드 제공
5. km-workflow에 감지 결과를 반영하여 적응형 동작

---

## 서브파일 목록

| 파일 | 내용 | 줄수 |
|------|------|------|
| [01-phase0-system-detection.md](01-phase0-system-detection.md) | Phase 0: Team OS 인프라 확인, 실행 환경 감지, 크로스 플랫폼 명령어 | ~196 |
| [02-phase1-2-tier-and-guide.md](02-phase1-2-tier-and-guide.md) | Phase 1: 티어 분류 기준 + Phase 2: 사용자 안내 메시지 | ~110 |
| [03-phase3-feature-activation.md](03-phase3-feature-activation.md) | Phase 3: Chroma (Standard) + Neo4j+Ollama (Advanced) 자동 설치 | ~280 |
| [04-phase4-5-adaptive-parallel.md](04-phase4-5-adaptive-parallel.md) | Phase 4: 적응형 동작 설정 + Phase 5: 병렬 검색 + 벤치마크 + 에러 처리 | ~260 |

---

## 실행 순서

```
Phase 0: 시스템 환경 감지 (자동 실행)
    ↓
Phase 1: 티어 분류 (Basic / Standard / Advanced)
    ↓
Phase 2: 사용자 안내 (효능감 설계)
    ↓
Phase 3: 기능 활성화 (선택적, 사용자 승인 필요)
    ↓
Phase 4: 적응형 동작 설정
    ↓
Phase 5: 병렬 검색 활성화
```

---

## 실행 조건

| 조건 | 설명 |
|------|------|
| **자동 실행** | Knowledge Manager 첫 실행 시 |
| **수동 실행** | "환경 감지", "시스템 체크", "RAG 설정" 키워드 |
| **재실행** | "환경 재감지", "스펙 다시 확인" 키워드 |

> **첫 실행 시에만 전체 프로세스 실행**, 이후에는 Phase 4.4의 요약만 표시.
> 사용자가 "환경 재감지"를 요청하면 전체 프로세스 재실행.

---

## 통합: km-workflow.md Phase 0

이 스킬은 `km-workflow.md`의 **Phase 0**에서 자동 호출됩니다.

```
Phase 0: 환경 감지 (이 스킬) ← NEW
    ↓
Phase 1: 입력 소스 감지
    ↓
Phase 1.5: 사용자 선호도 수집
    ...
```

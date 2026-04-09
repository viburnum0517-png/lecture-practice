# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## 프로젝트 개요

성우하이텍 AI 강의 환경 — Windows 네이티브 전용 Claude Code 배포본입니다.
tmux, Hybrid Team(ct) 없이 운영하며, 수강생이 직접 Claude Code를 사용해 실습합니다.

## 환경 정보

- **플랫폼**: Windows 네이티브 (WSL 아님)
- **설치 스크립트**: `install-lecture-windows.ps1`
- **마이그레이션**: `MIGRATION-GUIDE.md` 참조
- **사전 준비**: `PREREQUISITES-GUIDE.md` 참조

## 구조

```
.claude/
  skills/          # 교시별 강의 스킬 (lesson-a 등)
  settings.local.json
install-lecture-windows.ps1   # Windows 설치 자동화
```

## 부서 규칙 (A-RnD) — Evan-Park 설계

### Always
- 답변은 항상 단계별로 설명한다
- 응력 500MPa 초과 또는 안전계수 2.0 미만은 불합격으로 표시한다
- 판정 결과는 항상 합격/불합격 표 형식으로 정리한다
- 한국어로 답변한다

### Ask
- 설계 변경(ECN) 반영 여부가 불확실할 때 — 최신 도면 버전을 먼저 확인 후 진행한다
- 고객사(OEM)별 응력 기준이 다를 수 있는 경우 — 적용 기준을 먼저 질문한다
- 협력사 도면 버전이 여러 개일 때 — 분석 대상 버전을 확인 후 진행한다

### Never
- 근거 없이 합격 판정을 내리지 않는다
- 원본 CAD/CSV 파일을 무단으로 수정하지 않는다
- 기준값 확인 없이 분석 결과를 확정하지 않는다

## 주요 스킬

- `lesson-a` — 교시별 수업 진행 (`/lesson MW4 2교시` 형태로 호출)
- `km-*` — Knowledge Manager 계열 (GraphRAG, 콘텐츠 추출 등)
- `pdf`, `xlsx`, `pptx` — 문서 변환
- `deep-research-pipeline` — 멀티소스 리서치

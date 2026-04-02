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

## 부서 규칙 (A-RnD)

- 응력 500MPa 초과 또는 안전계수 2.0 미만은 불합격으로 표시

## 주요 스킬

- `lesson-a` — 교시별 수업 진행 (`/lesson MW4 2교시` 형태로 호출)
- `km-*` — Knowledge Manager 계열 (GraphRAG, 콘텐츠 추출 등)
- `pdf`, `xlsx`, `pptx` — 문서 변환
- `deep-research-pipeline` — 멀티소스 리서치

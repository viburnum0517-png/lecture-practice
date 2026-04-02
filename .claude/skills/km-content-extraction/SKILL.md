---
name: km-content-extraction
description: Knowledge Manager 콘텐츠 추출 스킬. 웹/소셜/PDF/영상 등 다양한 소스별 텍스트 및 데이터 추출 절차.
---

# Knowledge Manager 콘텐츠 추출 스킬

> Knowledge Manager 에이전트의 다양한 소스별 콘텐츠 추출 절차

---

## Overview

이 스킬은 Knowledge Manager가 다양한 소스로부터 콘텐츠를 추출할 때 사용하는 절차를 정의합니다. 웹 크롤링, 로컬 파일 처리, 이미지 분석, Notion 가져오기, 이미지 추출 파이프라인, Vault 지식 종합 등 전체 추출 워크플로우를 포괄합니다.

## Sub-files

| 파일 | 설명 | 주요 내용 |
|------|------|----------|
| [mandatory-tool-calls.md](mandatory-tool-calls.md) | 필수 도구 호출 규칙 | URL별 우선순위, 금지 행동, 소스별 추출 방법 개요 테이블 |
| [parallel-processing.md](parallel-processing.md) | 병렬 입력 처리 | 다중 URL/PDF/파일/Notion/Vault 병렬 크롤링 및 에러 처리 |
| [web-crawling.md](web-crawling.md) | 웹 크롤링 (2A) | Scrapling/Playwright/WebFetch 우선순위, YouTube/소셜 미디어 처리, 에러 대응 |
| [local-files.md](local-files.md) | 로컬 파일 처리 (2B) | PDF 5단계 우선순위 (ODL 포함), Word/Excel/PowerPoint/텍스트 파일 처리 |
| [image-analysis.md](image-analysis.md) | 이미지 분석 (2C) | Claude Vision 분석, 콘텐츠 유형 식별, 노트 통합 |
| [notion-import.md](notion-import.md) | Notion 가져오기 (2D) | Notion MCP 도구, 블록 파싱, 중간 형식 변환 |
| [image-pipeline.md](image-pipeline.md) | Image Extraction Pipeline (2F) | 웹/PDF 이미지 추출, 필터링 기준, auto 모드 |
| [vault-synthesis.md](vault-synthesis.md) | Vault 지식 종합 (2E) | 관련 노트 검색/수집/분석, 교차 노트 분석, 종합 노트 템플릿 |
| [special-processing.md](special-processing.md) | 특수 처리 + 스킬 참조 | 배치/대용량/혼합 소스 처리, 관련 스킬 목록 |

## Navigation

- 소스 유형별 추출: [mandatory-tool-calls.md](mandatory-tool-calls.md) 개요 테이블 참조
- 웹 URL 처리: [web-crawling.md](web-crawling.md)
- 파일 처리: [local-files.md](local-files.md)
- 이미지: [image-analysis.md](image-analysis.md) (분석) / [image-pipeline.md](image-pipeline.md) (추출)
- Notion: [notion-import.md](notion-import.md)
- Vault 종합: [vault-synthesis.md](vault-synthesis.md)
- 병렬 처리: [parallel-processing.md](parallel-processing.md)
- 특수 케이스: [special-processing.md](special-processing.md)

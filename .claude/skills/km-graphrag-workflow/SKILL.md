---
name: km-graphrag-workflow
description: Use when needing GraphRAG Mode G 마스터 워크플로우. 7-Phase (G0-G6) 파이프라인으로 vault 지식 그래프를 구축/갱신/검색합니다. TBox/ABox 분리, Louvain 계층 커뮤니티, Global/Local Search 이분법, 맵-리듀스 글로벌 쿼리, 메타온톨로지 귀납 포함.
---

# GraphRAG Workflow Skill (Mode G) — 마스터 워크플로우

vault 지식 그래프를 구축/갱신/검색하는 7-Phase 마스터 워크플로우.
**TBox/ABox 분리 + 6단계 인덱싱 파이프라인 + Global/Local Search 이분법 + 맵-리듀스 기반**.

> **이론적 배경**: `GraphRAG-인덱싱-6단계-파이프라인`, `GraphRAG-Global-vs-Local-Search`,
> `GraphRAG-Map-Reduce-쿼리-전략`, `6개-분석공간-개요`, `위상학적-지능-패러다임-전환`

---

## Sub-files

| 파일 | 내용 | Phase |
|------|------|-------|
| [overview.md](overview.md) | Obsidian 도구 우선순위, 6단계 파이프라인 매핑, 상태 머신, 진입점 분기 | -- |
| [phase-g0-environment.md](phase-g0-environment.md) | 환경 감지 + 그래프 로드 (Python 의존성, DB 존재 확인, config, 증분 감지) | G0 |
| [phase-g1-tbox.md](phase-g1-tbox.md) | TBox 구축 (온톨로지 생성/갱신, 5단계 방법론, DA 검증) | G1 |
| [phase-g2-abox.md](phase-g2-abox.md) | ABox 구성 + Knowledge Graph 구축 (Hub/일반 추출, N-ary, 배치, SQLite, 증분) | G2 |
| [phase-g3-community.md](phase-g3-community.md) | 계층적 커뮤니티 탐지 + 6개 분석공간 매핑 (Leiden, TDA, DA 검증) | G3 |
| [phase-g4-search.md](phase-g4-search.md) | Global/Local 검색 분기 활성화 (L0-L3 분류, 검색 라우터) | G4 |
| [phase-g5-report.md](phase-g5-report.md) | 맵-리듀스 보고서 생성 (글로벌 3단계, 로컬 ReACT, 보고서 템플릿) | G5 |
| [phase-g6-sync.md](phase-g6-sync.md) | Frontmatter 동기화 + 메타온톨로지 귀납 | G6 |
| [script-map-and-rules.md](script-map-and-rules.md) | Python 스크립트 연동 맵, 실행 주체 규칙, 참조 스킬 | -- |

---

## Navigation

- **풀 빌드**: overview.md (진입점 확인) -> G0 -> G1 -> G2 -> G3 -> G4 -> G5 -> G6
- **증분 갱신**: G0 -> G2(증분) -> G3 -> G6
- **검색만**: G4 -> G5
- **Frontmatter 동기화만**: G6
- **온톨로지 갱신만**: G1

---

## 참조 스킬

| 스킬 | 용도 |
|------|------|
| `km-graphrag-ontology.md` | G1 TBox 설계 + DA 검증 상세 |
| `km-batch-python.md` | G6 배치 실행 프로토콜 |
| `km-archive-reorganization.md` | Phase 패턴 참조 (R0-R5) |
| `km-rules-engine.md` | DA 검증 패턴 |
| `km-workflow.md` | 기존 KM 워크플로우 (Phase 0-6) |

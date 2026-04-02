---
name: km-content-extraction/vault-synthesis
description: Vault 지식 종합 (2E) — 관련 노트 검색/수집/분석, 교차 노트 분석, 종합 노트 템플릿
---

# 2E. Vault 지식 종합

기존 Obsidian 노트들을 종합하여 새로운 인사이트 노트 생성

---

## Step 1: 사용자 의도 파악

```
파싱할 요소:
- 주제/테마 키워드: "AI Safety", "MCP", "에이전트"
- 종합 유형:
  * 종합 정리: 모든 관련 지식 통합
  * 인사이트 도출: 노트 간 새로운 연결 발견
  * 질문 답변: vault 지식 기반 답변
  * 트렌드 분석: 시간별 학습 변화 분석
- 범위: 전체 vault / 특정 폴더 / 특정 태그
```

---

## Step 2: 관련 노트 검색 및 수집

```
OBSIDIAN_CLI="/mnt/c/Program Files/Obsidian/Obsidian.com"

# 1순위: Obsidian CLI search
"$OBSIDIAN_CLI" search query="[주제 키워드]" format=json

# CLI 실패 시: Obsidian MCP fallback
mcp__obsidian__search_vault({ query: "[주제 키워드]" })

# MCP 실패 시: Grep fallback
Grep(pattern="[키워드]", path="/mnt/c/Users/treyl/Documents/Obsidian/Second_Brain/")

# 폴더별 목록 (옵션)
# 1순위: Bash ls 또는 Glob
Glob(pattern="**/*.md", path="/mnt/c/Users/treyl/Documents/Obsidian/Second_Brain/[특정 폴더]/")
# 2순위: mcp__obsidian__list_notes({ folder: "[특정 폴더]" })

필터링 기준:
- 태그 매칭
- 제목 키워드 포함
- 콘텐츠 관련성
- 날짜 범위 (지정 시)
```

---

## Step 3: 노트 읽기 및 분석

```
OBSIDIAN_CLI="/mnt/c/Program Files/Obsidian/Obsidian.com"

# 1순위: Obsidian CLI read (순차 루프)
for path in [관련 노트 경로 배열]:
    "$OBSIDIAN_CLI" read path="{path}"

# CLI 실패 시: MCP fallback
mcp__obsidian__read_multiple_notes({ paths: [관련 노트 경로 배열] })

# MCP 실패 시: Read 도구 fallback
Read(file_path="/mnt/c/Users/treyl/Documents/Obsidian/Second_Brain/{path}")

각 노트에서 추출:
- 핵심 개념 (핵심 개념 섹션)
- 주요 인사이트
- 제기된 질문
- 언급된 연결
- 메타데이터 (태그, 카테고리, 날짜)
```

---

## Step 4: 교차 노트 분석

```
패턴 식별:
- 반복되는 테마
- 모순 또는 긴장
- 시간에 따른 아이디어 발전
- 지식 격차
- 예상치 못한 연결
```

---

## Step 5: 종합 생성

### A. 종합 정리 (Comprehensive Summary)
- 모든 관련 지식의 통합 개요
- 하위 주제별 정리
- 개념 발전 타임라인
- 핵심 시사점

### B. 인사이트 도출 (Insight Generation)
- 노트 간 새로운 연결
- 개별 노트에서 보이지 않던 패턴
- 시사점 및 예측
- 추가 탐구를 위한 질문

### C. 질문 답변 (Question Answering)
- vault 지식 기반 직접 답변
- 노트로부터의 근거 제시
- 확신도 수준
- 식별된 지식 격차

### D. 트렌드 분석 (Trend Analysis)
- 시간에 따른 사고 변화
- 새롭게 떠오르는 패턴
- 초점 또는 이해의 변화
- 향후 방향

---

## 종합 노트 템플릿

```markdown
# [주제] - 지식 종합 노트

## 메타 정보
- 종합 일시: YYYY-MM-DD HH:mm
- 분석된 노트 수: N개
- 주요 출처 노트: [[노트1]], [[노트2]], ...

## 핵심 인사이트 (Key Insights)

### 1. [인사이트 제목]
[인사이트 설명]
- 근거: [[출처노트1]], [[출처노트2]]
- 확신도: 높음/중간/낮음

### 2. [인사이트 제목]
...

## 주제별 종합

### [하위주제 1]
[종합 내용]
관련 노트: [[노트A]], [[노트B]]

### [하위주제 2]
...

## 발견된 패턴

### 공통 주제
- [패턴 1]: 설명
- [패턴 2]: 설명

### 흥미로운 연결
- [[노트X]] ↔ [[노트Y]]: 연결 이유

### 긴장/모순점
- [모순 1]: 설명 및 해석

## 지식 격차 (Knowledge Gaps)
- [ ] 아직 탐구되지 않은 영역
- [ ] 더 깊이 파야 할 질문

## 다음 단계 제안
1. [제안 1]
2. [제안 2]

## 원본 노트 목록
| 노트 | 핵심 기여 | 날짜 |
|------|----------|------|
| [[노트1]] | 기여 내용 | YYYY-MM-DD |
| [[노트2]] | 기여 내용 | YYYY-MM-DD |
```

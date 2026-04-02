---
name: km-content-extraction/notion-import
description: Notion 가져오기 (2D) — Notion MCP 도구, 블록 파싱, 중간 형식 변환
---

# 2D. Notion 가져오기

---

```
Step 1: Notion 소스 식별
  - URL 패턴: https://www.notion.so/...
  - Page ID 추출

Step 2: Notion 콘텐츠 가져오기
  Notion MCP 도구 사용:
  - mcp__notion__API-post-search: 페이지 검색
  - mcp__notion__API-retrieve-a-page: 페이지 조회
  - mcp__notion__API-get-block-children: 블록 내용 가져오기
  - mcp__notion__API-query-data-source: 데이터베이스 쿼리

Step 3: Notion 블록 파싱
  지원 블록 유형:
  - paragraph → 문단
  - heading_1, heading_2, heading_3 → 헤딩
  - bulleted_list_item → 불릿 리스트
  - numbered_list_item → 번호 리스트
  - code → 코드 블록
  - quote → 인용
  - toggle → 토글
  - callout → 콜아웃
  - image → 이미지
  - bookmark → 북마크

Step 4: 중간 형식으로 변환
  - 구조 보존
  - 메타데이터 추출 (제목, 태그, 속성)
  - 중첩 블록 처리
  - 관계/링크 유지
```

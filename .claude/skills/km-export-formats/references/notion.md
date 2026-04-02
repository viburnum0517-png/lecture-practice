# km-export-formats: Notion 저장 절차 상세

> 참조 문서: Notion PowerShell 직접 호출 + Notion 내보내기 상세

---

## Notion 저장 (PowerShell 직접 호출 - Windows) ⚠️ CRITICAL

**MCP 도구(`mcp__notion__API-post-page`)는 파라미터 직렬화 버그로 사용 금지!**
**버그 리포트**: `Bug_Reports/Bug-2026-01-24-1905-Notion-MCP-API-post-page-이중직렬화.md`

### 워크플로우

**Step 1: JSON 페이로드 파일 생성**
```
Write 도구 사용:
- file_path: "C:\Users\treyl\Documents\Obsidian\Second_Brain\km-temp\notion_payload.json"
- content: JSON 형식의 Notion API 페이로드
```

**Step 2: PowerShell 스크립트 생성**
```
Write 도구 사용:
- file_path: "C:\Users\treyl\Documents\Obsidian\Second_Brain\km-temp\notion_upload.ps1"
- content: [아래 템플릿]
```

**PowerShell 템플릿:**
```powershell
$headers = @{
    'Authorization' = 'Bearer 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'
    'Notion-Version' = '2022-06-28'
    'Content-Type' = 'application/json'
}
$body = Get-Content -Raw 'C:\Users\treyl\Documents\Obsidian\Second_Brain\km-temp\notion_payload.json' -Encoding UTF8
$response = Invoke-RestMethod -Uri 'https://api.notion.com/v1/pages' -Method POST -Headers $headers -Body ([System.Text.Encoding]::UTF8.GetBytes($body))
$response | ConvertTo-Json -Depth 10
```

**Step 3: PowerShell 실행**
```bash
powershell -ExecutionPolicy Bypass -File "C:\Users\treyl\Documents\Obsidian\Second_Brain\km-temp\notion_upload.ps1"
```

### 데이터베이스 ID 참조

| 용도 | Database ID (UUID 형식!) |
|------|--------------------------|
| **AI Second Brain** | `2a6e5818-0d0e-80ae-a6e3-cc8853fda844` |

### Notion 블록 타입

| 블록 타입 | JSON 키 |
|----------|---------|
| 문단 | `paragraph` |
| 제목1 | `heading_1` |
| 제목2 | `heading_2` |
| 제목3 | `heading_3` |
| 글머리 기호 | `bulleted_list_item` |
| 번호 목록 | `numbered_list_item` |
| 코드 블록 | `code` |
| 인용 | `quote` |
| **이미지 (외부 URL)** | `image` |

### ❌ 금지 패턴

```
❌ mcp__notion__API-post-page 사용
❌ MCP 도구로 parent 객체 전달 시도
❌ Notion 저장 요청 시 JSON 출력만 하고 끝내기
```

---

## 5B. Notion 내보내기

### 사용 스킬
`notion-knowledge-capture.md` 참조

### 생성 절차

```
Step 1: 마크다운 → Notion 블록 변환

  Markdown → Notion Block Type:
  - # Heading 1 → heading_1
  - ## Heading 2 → heading_2
  - ### Heading 3 → heading_3
  - 문단 → paragraph
  - - 불릿 → bulleted_list_item
  - 1. 숫자 → numbered_list_item
  - `code` → code
  - > 인용 → quote
  - [[wikilink]] → mention (페이지 존재 시)

Step 1.5: 이미지 블록 처리 (이미지 추출 활성 시)
  - 참조 스킬: km-image-pipeline.md
  - 외부 URL 이미지: image 블록으로 삽입
    { "type": "image", "image": { "type": "external", "external": { "url": "{원본URL}" }, "caption": [{ "type": "text", "text": { "content": "{alt-text}" } }] } }
  - 로컬 전용 이미지 (PDF 추출 등): 텍스트 설명으로 대체
    { "type": "callout", "callout": { "icon": { "type": "emoji", "emoji": "🖼️" }, "rich_text": [{ "type": "text", "text": { "content": "[이미지: {alt-text}] — Obsidian vault Resources/images/{topic-folder}/{filename} 에서 확인" } }] } }

Step 2: 메타데이터 처리
  - YAML 프론트매터 → Notion 속성
  - tags → Multi-select 속성
  - category → Select 속성
  - created → Date 속성
  - title → 페이지 제목

Step 3: Notion 페이지 생성

  Notion MCP 사용:
  a) 새 페이지 생성 (또는 기존 업데이트)
     mcp__notion__API-post-page

  b) 페이지 제목 설정

  c) 속성 추가 (태그, 카테고리, 날짜)

  d) 콘텐츠 블록 순차 추가
     mcp__notion__API-patch-block-children

  e) 이미지/첨부파일 처리

Step 4: Wikilink 처리
  - Notion에서 링크된 페이지 검색
  - 페이지 존재 시 mention 생성
  - 미발견 시 일반 텍스트로 변환
  - 옵션: 플레이스홀더 페이지 생성

Step 5: 데이터베이스 통합 (해당 시)
  - Zettelkasten 카테고리 → DB 속성 매핑
  - DB 행 생성 + 속성 설정
  - 관련 DB 항목 연결

Step 6: 사용자에게 보고
  - Notion 페이지 URL
  - DB 항목 URL (해당 시)
  - 생성/업데이트 상태
  - 생성된 블록 수
```

### Notion 다중 페이지 병렬 생성

```
시나리오: 여러 Notion 페이지 동시 생성

같은 응답에서 다중 API 호출:

[도구 1] mcp__notion__API-post-page (페이지 1)
[도구 2] mcp__notion__API-post-page (페이지 2)
[도구 3] mcp__notion__API-post-page (페이지 3)

주의: Notion API rate limit 고려
- 동시 5개 이하 권장
- 대량 생성 시 배치 처리 (5개씩 병렬)
```

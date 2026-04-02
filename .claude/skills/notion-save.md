---
name: notion-save
description: Use when needing notion 저장 스킬. 콘텐츠를 Notion 데이터베이스에 저장하는 MCP 도구 사용법.
---

# Notion 저장 스킬

이 스킬은 콘텐츠를 Notion 데이터베이스에 저장하는 기능을 제공합니다.

## 사용 가능한 도구

이 스킬에서는 다음 MCP 도구를 사용할 수 있습니다:

### mcp__notionApi 도구

Claude Desktop의 Notion MCP 서버 설정을 활용합니다.
설정 파일: `%APPDATA%\Roaming\Claude\claude_desktop_config.json`

```json
"notionApi": {
  "command": "cmd",
  "args": ["/c", "npx", "-y", "@notionhq/notion-mcp-server"],
  "env": {
    "OPENAPI_MCP_HEADERS": "{\"Authorization\": \"Bearer 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\", \"Notion-Version\": \"2022-06-28\" }"
  }
}
```

## Notion 데이터베이스 정보

### AI Second Brain 데이터베이스
- **URL**: https://tofu-jaekyung.notion.site/AI-2c6e58180d0e807c8a17edc31f77c9bd
- **Database ID**: `2c6e58180d0e807c8a17edc31f77c9bd`

## 사용 방법

### 1. Notion API를 통한 페이지 생성

```bash
# npx를 통해 Notion API 호출
npx -y @notionhq/notion-mcp-server
```

### 2. curl을 통한 직접 API 호출

```bash
curl -X POST https://api.notion.com/v1/pages \
  -H "Authorization: Bearer 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" \
  -H "Notion-Version: 2022-06-28" \
  -H "Content-Type: application/json" \
  -d '{
    "parent": { "database_id": "2c6e58180d0e807c8a17edc31f77c9bd" },
    "properties": {
      "Name": {
        "title": [{"text": {"content": "페이지 제목"}}]
      }
    },
    "children": [
      {
        "object": "block",
        "type": "paragraph",
        "paragraph": {
          "rich_text": [{"type": "text", "text": {"content": "내용"}}]
        }
      }
    ]
  }'
```

## 워크플로우

1. **콘텐츠 준비**: 저장할 내용을 마크다운 또는 텍스트로 준비
2. **API 호출**: curl 또는 npx를 통해 Notion API 호출
3. **확인**: 생성된 페이지 URL 반환

## 주의사항

- Notion API 토큰은 민감 정보이므로 보안에 주의
- Database ID는 URL에서 확인 가능
- Notion API v2022-06-28 사용

## 예시: Thread 글 저장

```bash
curl -X POST https://api.notion.com/v1/pages \
  -H "Authorization: Bearer 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" \
  -H "Notion-Version: 2022-06-28" \
  -H "Content-Type: application/json" \
  -d @notion_payload.json
```

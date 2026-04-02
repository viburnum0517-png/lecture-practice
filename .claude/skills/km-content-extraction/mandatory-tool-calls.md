---
name: km-content-extraction/mandatory-tool-calls
description: 필수 도구 호출 규칙 및 소스별 추출 방법 개요
---

# 필수 도구 호출 규칙 (MANDATORY TOOL CALLS)

**이 Phase에서 반드시 도구를 실제로 호출해야 합니다!**

---

## 일반 웹 URL (CRITICAL!)

**URL 감지 시 반드시 다음 우선순위로 호출:**

```bash
# 1순위: Scrapling (Python, JS 렌더링, 3x 빠름)
python3 scripts/scrapling-crawl.py fetch "[URL]" --mode dynamic --output markdown

# 2순위: Scrapling Stealth (안티봇 우회 필요 시)
python3 scripts/scrapling-crawl.py fetch "[URL]" --mode stealth --output markdown

# 3순위: Playwright CLI (Bash 기반 - Scrapling 실패 시 폴백)
playwright-cli open [URL]
playwright-cli snapshot          # 접근성 스냅샷으로 전체 텍스트 추출
playwright-cli screenshot        # 시각적 확인 필요 시
playwright-cli close
```

```tool-call
# 4순위: WebFetch (정적 콘텐츠 추출 가능)
WebFetch({ url: "[URL]", prompt: "전체 내용 추출" })

# 5순위: Hyperbrowser (클라우드, 크레딧 소진 주의)
mcp__hyperbrowser__scrape_webpage({ url: "[URL]", outputFormat: ["markdown"] })
```

---

## 소셜 미디어 URL — Threads/Instagram (CRITICAL!)

> **SNS는 scrapling이 첫 포스트만 반환합니다. 반드시 Playwright CLI 1순위!**

```bash
# 1순위: Playwright CLI (SNS 필수! 스크롤로 답글까지 로드)
playwright-cli open "[URL]"
sleep 3                          # 동적 콘텐츠 로드 대기
playwright-cli snapshot          # 전체 스레드 텍스트 추출
# → 답글 잘림 시: playwright-cli press End → sleep 2 → snapshot 반복
playwright-cli close

# 2순위: Scrapling (CLI 실패 시에만 — 첫 포스트만 가능)
python3 scripts/scrapling-crawl.py fetch "[URL]" --mode dynamic --output markdown
```

**SNS에서 Playwright MCP 사용 금지** — CLI만 사용합니다.

---

## 절대 금지

```
도구 호출 없이 내용 추측/생성
이전 대화 기억에만 의존
크롤링 결과 없이 노트 작성
1순위 실패 시 바로 포기 - 반드시 Fallback 순서대로 시도
```

**도구 호출 없이 응답하면 작업 실패로 간주됩니다!**

---

## 소스별 추출 방법 개요

| 소스 유형 | 필수 도구 호출 | 이미지 처리 | 참조 스킬 |
|----------|------------------|-----------|----------|
| **YouTube** | `youtube-transcript-api` → `yt-dlp` 폴백 | 썸네일만 | → km-youtube-transcript.md |
| **소셜 미디어 (Threads/Instagram)** | `playwright-cli open → snapshot` **1순위** (scrapling은 첫 포스트만 반환) | 미디어 URL 수집 | → km-social-media.md |
| **일반 웹 페이지** | `scrapling-crawl.py` 1순위 → `playwright-cli` 2순위 → `WebFetch` 3순위 | img/figure 파싱 + 차트 스크린샷 | → [web-crawling.md](web-crawling.md) |
| PDF | **1순위**: `Read` → **2순위**: `opendataloader-pdf` → **3순위**: `marker_single` → **4순위**: `GLM-OCR` → **5순위**: Gemini OCR | ODL/marker images/ 폴더 스캔 | → pdf 스킬, km-glm-ocr |
| Word (DOCX) | `Read` 도구 | 임베디드 이미지 설명 추출 | → docx 스킬 |
| Excel/CSV | `Read` 도구 | 차트 없음 (데이터만) | → xlsx 스킬 |
| PowerPoint | `Read` 도구 | 슬라이드 이미지 설명 추출 | → pptx 스킬 |
| 이미지 | `Read` 도구 (Vision) | 원본 그대로 활용 | → [image-analysis.md](image-analysis.md) |
| Notion | `mcp__notion__API-get-block-children` | image 블록 URL 수집 | → [notion-import.md](notion-import.md) |
| Vault 종합 | Obsidian CLI search (fallback: MCP search) | 기존 attachments/ 참조 | → [vault-synthesis.md](vault-synthesis.md) |

---
name: km-content-extraction/web-crawling
description: 웹 크롤링 (2A) — Scrapling/Playwright/WebFetch 우선순위, YouTube/소셜 미디어 처리, 에러 대응
---

# 2A. 웹 크롤링 (Scrapling 우선!)

---

## 브라우징 스택 우선순위 (CRITICAL!)

```
[일반 웹]
1순위: scrapling-crawl.py --mode dynamic (Python, JS 렌더링, 3x 빠름)
2순위: scrapling-crawl.py --mode stealth (Python, 안티봇 우회)
3순위: playwright-cli (Bash, Scrapling 실패 시 폴백)
4순위: WebFetch (정적 콘텐츠 추출 가능 - 허용)
5순위: Hyperbrowser (클라우드, 유료 - 크레딧 소진 주의)

[소셜 미디어 — Threads/Instagram]
1순위: playwright-cli (SNS 필수! scrapling은 첫 포스트만 반환)
2순위: scrapling (CLI 실패 시에만)
Playwright MCP 사용 금지 (SNS 동적 로딩 불안정)
```

---

## YouTube URL (전용 파이프라인!)

**다음 URL 패턴은 YouTube 트랜스크립트 파이프라인으로 처리:**
- `youtube.com/watch?v=*`
- `youtu.be/*`
- `youtube.com/shorts/*`

```
참조 스킬: → km-youtube-transcript.md

Step 1: Video ID 추출 (URL 파싱)
Step 2: 트랜스크립트 추출 (youtube-transcript-api → yt-dlp 폴백)
Step 3: 메타데이터 + 챕터 수집 (정확성 보장!)
        1순위: yt-dlp --dump-json
        2순위: playwright-cli open → snapshot (핵심 폴백)
        3순위: Playwright MCP (CLI 실패 시)
        → 챕터가 있으면 타임라인 타임스탬프로 활용!
Step 4: 콘텐츠 분석 (프리셋 반영 — 타임라인, 인사이트, 인용구)
```

**트랜스크립트 추출에는 Playwright/WebFetch 사용 금지** — 자막은 반드시 youtube-transcript-api 또는 yt-dlp 사용.
**메타데이터/챕터 수집에는 playwright-cli 사용 가능** — yt-dlp 실패 시 playwright-cli로 제목, 채널, 업로드일, 챕터 등 수집.

---

## 소셜 미디어 URL (Playwright CLI 1순위!)

> **SNS URL 감지 시 scrapling을 시도하지 마세요! 바로 Playwright CLI로 시작합니다.**
> scrapling은 로그인 벽/동적 로딩 때문에 첫 포스트만 반환합니다.

**다음 URL 패턴은 Playwright CLI를 1순위로 크롤링:**
- `threads.net/*`, `threads.com/*` → km-social-media.md 스킬 참조
- `instagram.com/p/*` → km-social-media.md 스킬 참조
- `instagram.com/reel/*` → km-social-media.md 스킬 참조

```bash
# SNS 크롤링 워크플로우
playwright-cli open "[SNS_URL]"
sleep 3                          # 동적 콘텐츠 로드
playwright-cli snapshot          # 전체 스레드/포스트 추출
# 답글 잘림 시: playwright-cli press End → sleep 2 → snapshot
playwright-cli close
```

---

## 1순위: Scrapling (MUST TRY FIRST!)

```bash
# 기본 크롤링 (dynamic 모드 — JS 렌더링, 가장 빠름)
python3 scripts/scrapling-crawl.py fetch "[URL]" --mode dynamic --output markdown

# 이미지 포함 추출
python3 scripts/scrapling-crawl.py fetch "[URL]" --mode dynamic --images --output json
```

## 2순위: Scrapling Stealth (봇 탐지 시)

```bash
# 안티봇 우회 크롤링
python3 scripts/scrapling-crawl.py fetch "[URL]" --mode stealth --output markdown
```

## 3순위: Playwright CLI (Scrapling 실패 시 + 스크린샷)

```bash
playwright-cli open "[URL]"
playwright-cli press End           # 페이지 하단으로 스크롤 (선택)
playwright-cli snapshot            # 접근성 스냅샷으로 텍스트 추출
playwright-cli screenshot          # 시각적 캡처 (선택)
playwright-cli close
```

## 4순위: Playwright MCP (CLI 실패 시)

```tool-call
mcp__playwright__browser_navigate({ url: "[URL]" })
mcp__playwright__browser_wait_for({ time: 3 })
mcp__playwright__browser_snapshot()
```

## 5순위: WebFetch (Playwright 모두 실패 시 - 허용)

```tool-call
WebFetch({ url: "[URL]", prompt: "전체 내용을 추출해줘" })
```

> WebFetch는 JavaScript 렌더링이 불가하지만, 정적 콘텐츠 추출에는 유효합니다.

---

## 웹 크롤링 완료 검증 (필수!)

```
□ scrapling-crawl.py 또는 playwright-cli snapshot 호출 완료?
□ 출력에서 실제 콘텐츠 확인 가능?
□ 실패 시 다음 순위 Fallback 시도 완료?

모든 순위에서 실패한 경우에만 사용자에게 수동 확인 요청!
```

---

## 웹 크롤링 에러 처리

| 에러 | 대응 |
|------|------|
| scrapling 미설치 | `pip install "scrapling[fetchers]"` 후 재시도 |
| 봇 감지/차단 | **scrapling --mode stealth** → playwright-cli 폴백 |
| 콘텐츠 미로드 | stealth 모드 재시도, Playwright 폴백 |
| 네트워크 오류 | 지수 백오프로 재시도 |
| 스크린샷 필요 | **Playwright 사용** (Scrapling은 스크린샷 미지원) |

---

## 레거시 스텔스 스크립트 폴백 (Scrapling stealth 모드로 대체)

```bash
# Scrapling stealth가 실패하고 TS 스텔스 스크립트도 필요한 경우에만:
npx tsx .claude/skills/stealth-browsing/scripts/stealth-navigate-and-extract.ts \
  "[URL]" \
  --output markdown \
  --json \
  --wait 3000
```

상세 참조: → stealth-browsing.md 스킬

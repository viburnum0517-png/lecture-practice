---
name: km-content-extraction/image-pipeline
description: Image Extraction Pipeline (2F) — 웹/PDF 이미지 추출, 필터링 기준, auto 모드
---

# 2F. Image Extraction Pipeline (모든 모드 -- 기본 auto 활성화)

> **웹/PDF 소스에서는 기본적으로 auto 모드로 이미지를 추출합니다.**
> image_extraction = false일 때만 스킵합니다.
> 참조 스킬: → `km-image-pipeline.md`
>
> **모드별 동작 차이:**
> - **AT 모드**: content-extractor가 Image Catalog 테이블 생성 → Lead가 Phase 5.25에서 소비
> - **단일 에이전트 / 모바일**: Image Catalog 불필요. 추출 정보를 메모리(변수)에 보관 → Phase 5에서 직접 저장

---

## 웹 이미지 추출

```
Step 1: 접근성 스냅샷 파싱
  browser_snapshot 결과에서 이미지 요소 식별:
  - <img> 태그: src, alt, width, height 수집
  - <figure> + <figcaption>: 캡션 텍스트 수집
  - 주변 heading (가장 가까운 h1-h6) 기록

Step 2: URL 수집 및 필터링
  - src URL을 절대 경로로 변환 (상대 경로 → 절대)
  - 필터링 적용:
    포함: width/height > 100px, figure 내 이미지, alt-text 있는 이미지
    제외: < 100x100px, 광고 도메인(ads.*, doubleclick.*), data:image/ < 5KB

Step 3: 차트/그래프 감지
  - <canvas> 요소 → browser_take_screenshot으로 캡처
  - <svg> 요소 (data-viz 관련) → 스크린샷 캡처
  - class/id 패턴 감지: chart, graph, plot, d3, echarts, highcharts, recharts

Step 4: 유형 분류
  | 식별 패턴 | 유형 분류 |
  |----------|---------|
  | <canvas>, .chart, .graph | chart |
  | <svg>, .diagram, .architecture | diagram |
  | 큰 이미지(>400px), .screenshot | screenshot |
  | <figure> + <figcaption> | photo/illustration |

Step 5: Image Catalog 생성
  각 이미지에 대해:
  - Type, Source(web), URL, Context(주변 텍스트), Alt-text Hint, Placement 기록
```

---

## PDF 이미지 추출

```
Step 1: marker 출력 스캔
  Glob("km-temp/{name}/images/*") → 추출된 이미지 파일 목록

Step 2: 이미지 ↔ 마크다운 위치 매핑
  - 마크다운 내 ![](images/imgNNN.png) 패턴 검색
  - 해당 이미지 참조의 위치(섹션/헤딩) 기록
  - 페이지 번호 추정 (마크다운 내 페이지 마커 기반)

Step 3: 유형 분류
  - Read(이미지 파일) → Claude Vision으로 유형 판별
  - chart, diagram, photo, table-screenshot 등 분류
  - 또는 파일명/주변 텍스트 기반 추정 (Vision 비용 절감)

Step 4: Image Catalog 생성
  - Source: pdf-p{N} (페이지 번호)
  - Path: km-temp/{name}/images/{filename}
```

---

## 이미지 필터링 기준

```
자동 제외:
├── 크기 < 100x100px (아이콘)
├── 크기 = 1x1px (트래킹 픽셀)
├── 도메인: ads.*, doubleclick.*, googlesyndication.*, adnxs.*
├── class/id: nav, menu, header, footer, social, share
└── base64 인라인 < 5KB

자동 포함 (우선):
├── <figure> + <figcaption>
├── <canvas>, <svg> (데이터 시각화)
├── class: chart, graph, diagram, architecture, flow
└── alt-text에 "Figure", "Chart", "Table", "Diagram" 포함
```

---

## "auto" 모드 필터 (기본값 -- 웹/PDF 소스)

image_extraction = "auto" 시 추가 제한 적용:

| 조건 | auto | true | false |
|------|------|------|-------|
| 우선순위 1-2 (차트/다이어그램) | **포함** | 포함 | 제외 |
| 우선순위 3-4 (스크린샷/사진) | 제외 | **포함** | 제외 |
| 우선순위 5 (장식) | 제외 | 제외 | 제외 |
| 최대 개수 (단일 에이전트) | 10개 | 무제한 | 0 |
| 최대 개수 (모바일) | 5개 | 무제한 | 0 |
| 파일 크기 제한 | 2MB | 5MB (경고) | - |

**auto 모드 소스별 기본 적용:**

| 소스 유형 | 기본값 | 근거 |
|----------|--------|------|
| 웹 URL (일반) | **auto** | 기사/문서에 유용한 차트 많음 |
| PDF | **auto** | 연구/보고서에 차트 필수 |
| 소셜 미디어 | **false** | 미디어 별도 처리 |
| Vault 종합 | **false** | 기존 Resources/images 참조 |
| Notion | **auto** | 웹과 유사 |

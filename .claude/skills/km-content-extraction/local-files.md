---
name: km-content-extraction/local-files
description: 로컬 파일 처리 (2B) — PDF 5단계 우선순위 (ODL 포함), Word/Excel/PowerPoint/텍스트 파일 처리
---

# 2B. 로컬 파일 처리

---

## PDF 파일 (5단계 우선순위 시스템)

```
PDF 처리 우선순위 (CRITICAL!)

1순위: Claude Read 도구 (기본, 빠름, 소형 PDF)
2순위: OpenDataLoader-PDF (품질 #1, 링크/이미지/구조 보존, 대용량 추천)
3순위: Marker (속도+구조 우위, Markdown 네이티브)
4순위: GLM-OCR (스캔/수식/테이블/코드 특화, 선택적 설치, PaddleOCR 대비 5.6x 빠름)
5순위: Gemini OCR (클라우드 폴백)
```

### 1순위: Claude Read 도구 (기본)

```
대부분의 PDF는 Read 도구로 직접 처리 가능합니다.

Read("{PDF경로}")

- 빠름: 즉시 처리
- 비용: API 토큰만 사용
- 한계: 대용량 PDF(50MB+) 또는 스캔 PDF에서 실패 가능
- 한계: 링크/이미지 참조 보존 불가
```

### 2순위: OpenDataLoader-PDF (Read 실패 또는 고품질 필요 시)

```
Read 실패 시, 또는 링크/이미지/구조 보존이 중요한 대용량 PDF 처리 시:

# 설치 (Java 11+ 필수, Python 3.10+, CPU-only)
pip install opendataloader-pdf

# 하이브리드 AI 향상 모드 (복잡한 레이아웃용)
pip install "opendataloader-pdf[hybrid]"

# Python API
import opendataloader_pdf
opendataloader_pdf.convert(
    input_path=["document.pdf"],
    output_dir="output/",
    format="markdown",
)

# CLI
opendataloader-pdf document.pdf -o output/ -f markdown

# 배치 처리 (다수 PDF 한 번에)
opendataloader_pdf.convert(
    input_path=["file1.pdf", "file2.pdf", "folder/"],
    output_dir="output/",
    format="markdown",
)

장점:
- 정확도 #1 (0.90, Marker 0.83, PyMuPDF 0.57)
- 테이블 추출 SOTA (0.93)
- 링크 보존 (PyMuPDF 0개 vs ODL 79개 — 실측)
- 이미지 추출 (PyMuPDF 0개 vs ODL 79개 — 실측)
- 리스트 감지 2배 (PyMuPDF 692 vs ODL 1,364 — 실측)
- 단락 구분 5배 (PyMuPDF 924 vs ODL 5,026 — 실측)
- 바운딩 박스 좌표 제공 (소스 귀속 가능)
- CPU-only (GPU 불필요)
- 80+ 언어 OCR 지원
- XY-Cut++ 알고리즘으로 시맨틱 읽기 순서 보존
- 다중 출력 (markdown, json, html, pdf)

주의:
- Java 11+ 런타임 필요
- 단순 페이지도 0.05초/페이지 (Claude Read보다 느림)
- 대용량 PDF에서 Marker 대비 느릴 수 있음 (463p → 43.9초)

사용 판단 기준:
- 50+ 페이지 PDF → ODL 추천
- 링크/이미지/구조 보존 중요 → ODL 필수
- 단순 텍스트 추출만 필요 → Claude Read 충분
```

### 3순위: Marker (ODL 실패 시 - 속도+구조 우위)

```
ODL 실패 시 Marker 사용 (속도 7배, Markdown 구조화 네이티브):

# Python 3.12 필수 (Python 3.14는 미지원)
py -3.12 -m pip install marker-pdf

# 변환 명령어 (Python 3.12 Scripts 경로)
"C:\Users\treyl\AppData\Local\Programs\Python\Python312\Scripts\marker_single.exe" "document.pdf" --output_format markdown --output_dir ./output

# 스캔 PDF (OCR 강제)
"C:\Users\treyl\AppData\Local\Programs\Python\Python312\Scripts\marker_single.exe" "scanned.pdf" --output_format markdown --output_dir ./output --force_ocr

# 최고 품질 (LLM 향상)
"C:\Users\treyl\AppData\Local\Programs\Python\Python312\Scripts\marker_single.exe" "complex.pdf" --output_format markdown --output_dir ./output --use_llm --force_ocr

Marker Output: ./output/{filename}/{filename}.md + images folder
```

### 4순위: GLM-OCR (Marker 실패 또는 수식/테이블/코드 필요 시)

```
Marker 실패 시 또는 수식/테이블/코드 정밀 추출 필요 시:

상세 스킬: → km-glm-ocr.md

# venv 가용성 체크 (필수!)
# Windows: .venvs\paddleocr-vl\Scripts\python.exe 존재 여부 (GLM-OCR도 같은 venv 사용 가능)
# Linux: .venvs/paddleocr-vl/bin/python 존재 여부
# 미설치 → 5순위 (Gemini)로 폴백

# 모델: zai-org/GLM-OCR
# 태스크별 프롬프트:
- "Text Recognition:" → 일반 텍스트 인식
- "Table Recognition:" → 테이블 구조 추출
- "Formula Recognition:" → 수학 공식 LaTeX 추출

장점:
- 94.62% 정확도 (OmniDocBench #1)
- PaddleOCR 대비 5.6배 빠름 (18.5초/페이지 vs 104초/페이지)
- 코드 블록 인식 강점
- 테이블/수식 인식 SOTA
- 왜곡 문서 처리 우수

주의:
- 디지털 PDF에서 Marker 대비 1.5배 느림
- transformers git 버전 필요 (5.0.1+)
- 선택적 설치 (Optional Enhancement)
```

### 5순위: Gemini OCR (최종 폴백)

```python
import google.generativeai as genai

genai.configure(api_key="YOUR_GOOGLE_API_KEY")
model = genai.GenerativeModel("gemini-3-flash-preview")

# PDF 업로드 및 OCR
file = genai.upload_file("document.pdf")
response = model.generate_content([
    "Extract all text from this PDF in markdown format.",
    file
])
print(response.text)
```

### 처리 방법 비교

| 방법 | 정확도 | 속도 | 비용 | 한국어 | 테이블 | 링크/이미지 | 사용 시점 |
|------|--------|------|------|--------|--------|------------|----------|
| **Claude Read** | — | 즉시 | API 토큰 | O | 제한적 | X | 기본 (1순위) |
| **ODL** | **0.90** | 0.05초/p | 무료 | O | **0.93** | **O** | Read 실패/고품질 (2순위) |
| **Marker** | 0.83 | 37.6초/3p | 무료 | O | Markdown | X | ODL 실패 시 (3순위) |
| **GLM-OCR** | 0.95 | 55초/3p | 무료 | O | **SOTA** | X | 수식/코드 특화 (4순위) |
| **Gemini OCR** | — | 빠름 | Vision 토큰 | O | O | X | 최종 폴백 (5순위) |

### 토큰 비교

| 방법 | 페이지당 토큰 | 절감 |
|------|-------------|------|
| PDF 직접 (Claude Vision) | 1,500-3,000 | - |
| ODL → Markdown | 800-1,000 | **50-70%** |
| GLM-OCR → Markdown | 800-1,000 | **50-70%** |
| Marker → Markdown | 850-1,000 | **50-70%** |

### ODL 벤치마크 (실측 — claude-master-guide.pdf, 463p)

```
             PyMuPDF    ODL         승자
속도          2.6s      43.9s       PyMuPDF (17x)
링크          0개       79개        ODL
이미지 추출    0개       79개        ODL
리스트 감지    692       1,364       ODL (2x)
단락 구분     924       5,026       ODL (5x)
→ 품질: ODL 5승 / PyMuPDF 2승 / 무승부 5
```

---

## Word 문서 (DOCX)

```
Step 1: 파일 내용 읽기
  - Read 도구 또는 docx 스킬 사용

Step 2: 마크업 파싱
  - 헤딩, 리스트, 테이블 구조 추출
  - 스타일 정보 보존 (필요 시)

Step 3: 구조화된 정보 추출
  - 섹션별 콘텐츠 분리
  - 메타데이터 추출 (작성자, 날짜 등)
```

---

## Excel/CSV 파일

```
Step 1: xlsx 스킬로 데이터 로드
  - pandas DataFrame으로 변환
  - 수식 및 포맷 정보 보존

Step 2: 데이터 분석
  - 트렌드 및 패턴 식별
  - 통계 요약 생성
  - 차트/시각화 데이터 추출

Step 3: 인사이트 도출
  - 주요 발견사항 정리
  - 노트용 텍스트 형식으로 변환

CRITICAL: 수식은 항상 그대로 사용!
  sheet['B10'] = '=SUM(B2:B9)'
  sheet['B10'] = 5000  # 하드코딩 금지
```

---

## PowerPoint 파일

```
Step 1: pptx 스킬로 텍스트 추출
  - markitdown 사용
  - 슬라이드별 콘텐츠 분리

Step 2: 구조 보존
  - 슬라이드 제목 → 섹션 헤딩
  - 불릿 포인트 → 리스트
  - 발표자 노트 포함

Step 3: 시각 요소 처리
  - 차트/다이어그램 설명 추출
  - 이미지 대체 텍스트 포함
```

---

## 텍스트 파일 (TXT/MD)

```
Step 1: 직접 파일 읽기
  - Read 도구 사용
  - 인코딩 자동 감지

Step 2: 마크다운 파싱 (MD 파일)
  - 헤딩, 링크, 이미지 파싱
  - 프론트매터 추출

Step 3: 구조화
  - 섹션 분리
  - 메타데이터 생성
```

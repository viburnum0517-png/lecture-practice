---
name: pdf-ocr-enhanced
description: Use when needing Enhanced PDF OCR skill with 3-tier priority system (Claude Read → Marker → Gemini OCR). Includes automatic Python 3.12 setup for deployment.
license: MIT
---

# PDF OCR Enhanced Skill

고성능 PDF OCR 처리를 위한 3단계 우선순위 시스템입니다.

---

## 처리 우선순위 (CRITICAL!)

```
1순위: Claude Read 도구 (기본, 빠름)
2순위: Read 실패 시 → Marker (대용량/스캔 PDF)
3순위: Marker 실패 시 → Gemini OCR (클라우드 폴백)
```

---

## 방법별 비교

| 방법 | 속도 | 비용 | 한국어 | 사용 시점 |
|------|------|------|--------|----------|
| **Claude Read** | 즉시 | API 토큰 | O | 기본 (1순위) |
| **Marker** | 10-20분 (첫 실행) | 무료 | O (90+ 언어) | Read 실패 시 |
| **Gemini OCR** | 빠름 | Vision 토큰 | O | Marker 실패 시 |

---

## 1순위: Claude Read 도구 (기본)

대부분의 PDF는 Read 도구로 직접 처리 가능합니다.

```
Read("{PDF경로}")
```

- **빠름**: 즉시 처리
- **비용**: API 토큰만 사용
- **한계**: 대용량 PDF(50MB+) 또는 스캔 PDF에서 실패 가능

### 실패 시그널

다음 에러 발생 시 2순위(Marker)로 전환:
- "Prompt is too long"
- "File too large"
- 빈 텍스트 반환 (스캔 PDF)

---

## 2순위: Marker (Read 실패 시)

### 시스템 요구사항

**Python 3.12 필수** (Python 3.14는 미지원)

### 설치 (배포/새 환경용)

#### Windows

```bash
# 1. Python 3.12 설치 확인
py -3.12 --version

# 설치 안 됨 → winget으로 설치
winget install --id Python.Python.3.12 --source winget

# 2. marker-pdf 설치
py -3.12 -m pip install marker-pdf
```

#### macOS/Linux

```bash
# 1. Python 3.12 설치 확인
python3.12 --version

# 설치 안 됨 → pyenv 또는 패키지 매니저로 설치
# pyenv 예시:
pyenv install 3.12
pyenv local 3.12

# 2. marker-pdf 설치
python3.12 -m pip install marker-pdf
```

### 변환 명령어

#### Windows (Python 3.12 Scripts 경로)

```bash
# 기본 변환
"C:\Users\treyl\AppData\Local\Programs\Python\Python312\Scripts\marker_single.exe" "document.pdf" --output_format markdown --output_dir ./output

# 스캔 PDF (OCR 강제)
"C:\Users\treyl\AppData\Local\Programs\Python\Python312\Scripts\marker_single.exe" "scanned.pdf" --output_format markdown --output_dir ./output --force_ocr

# 최고 품질 (LLM 향상)
"C:\Users\treyl\AppData\Local\Programs\Python\Python312\Scripts\marker_single.exe" "complex.pdf" --output_format markdown --output_dir ./output --use_llm --force_ocr

# 페이지 범위 지정
"C:\Users\treyl\AppData\Local\Programs\Python\Python312\Scripts\marker_single.exe" "document.pdf" --output_format markdown --output_dir ./output --page_range "0-10"
```

#### macOS/Linux

```bash
# 기본 변환
marker_single "document.pdf" --output_format markdown --output_dir ./output

# 스캔 PDF (OCR 강제)
marker_single "scanned.pdf" --output_format markdown --output_dir ./output --force_ocr

# 최고 품질 (LLM 향상)
marker_single "complex.pdf" --output_format markdown --output_dir ./output --use_llm --force_ocr
```

### 출력 구조

```
./output/{filename}/
├── {filename}.md          # 변환된 마크다운
├── {filename}_meta.json   # 메타데이터
└── _page_*_Figure_*.jpeg  # 추출된 이미지
```

### 옵션 설명

| 옵션 | 설명 | 사용 시점 |
|------|------|----------|
| `--force_ocr` | OCR 강제 적용 | 스캔 PDF, 수식 많은 문서 |
| `--use_llm` | LLM으로 품질 향상 | 복잡한 레이아웃 |
| `--page_range "0-10"` | 페이지 범위 지정 | 대용량 PDF 분할 처리 |
| `--output_format markdown` | 출력 형식 | 항상 markdown 권장 |

### 첫 실행 시 모델 다운로드

첫 실행 시 OCR 모델 다운로드 (~2GB):
- text_detection, text_recognition
- layout_detection, table_recognition
- ocr_error_detection

소요 시간: 10-20분 (네트워크 속도에 따라 다름)

---

## 3순위: Gemini OCR (Marker 실패 시)

Marker가 실패하거나 클라우드 OCR이 필요한 경우 Gemini API 사용.

### 요구사항

- Google API Key (Gemini API 활성화)
- `google-generativeai` 패키지

### 설치

```bash
pip install google-generativeai
```

### 사용법

```python
import google.generativeai as genai

# API 키 설정 (환경변수 또는 직접)
genai.configure(api_key="YOUR_GOOGLE_API_KEY")

# 모델 초기화
model = genai.GenerativeModel("gemini-3-flash-preview")

# PDF 업로드 및 OCR
file = genai.upload_file("document.pdf")
response = model.generate_content([
    "Extract all text from this PDF in markdown format. Preserve headings, lists, tables, and code blocks.",
    file
])

print(response.text)
```

### 한국어 PDF 처리

```python
response = model.generate_content([
    "이 PDF에서 모든 텍스트를 추출해주세요. 마크다운 형식으로, 헤딩, 리스트, 테이블 구조를 유지해주세요.",
    file
])
```

---

## 자동 감지 워크플로우

```python
def process_pdf(pdf_path):
    """
    3단계 우선순위로 PDF 처리
    """
    import os

    # Step 1: Claude Read 시도
    try:
        content = claude_read(pdf_path)
        if content and len(content) > 100:  # 유효한 내용
            return {"method": "claude_read", "content": content}
    except Exception as e:
        if "too long" not in str(e).lower():
            raise

    # Step 2: Marker 변환 시도
    try:
        output_dir = "./km-temp"
        os.makedirs(output_dir, exist_ok=True)

        # marker_single 실행
        result = run_marker(pdf_path, output_dir)
        if result:
            return {"method": "marker", "content": result}
    except Exception as e:
        print(f"Marker failed: {e}")

    # Step 3: Gemini OCR 폴백
    try:
        content = gemini_ocr(pdf_path)
        return {"method": "gemini_ocr", "content": content}
    except Exception as e:
        raise Exception(f"All PDF processing methods failed: {e}")
```

---

## 토큰 비교

| 방법 | 페이지당 토큰 | 절감 |
|------|-------------|------|
| PDF 직접 (Claude Vision) | 1,500-3,000 | - |
| Marker → Markdown | 850-1,000 | **50-70%** |

---

## 문제 해결

### Python 버전 문제

```
에러: "Failed building wheel for pillow" 또는 "regex"
원인: Python 3.14에서는 prebuilt binary 없음
해결: Python 3.12 사용

py -3.12 -m pip install marker-pdf
```

### Marker 첫 실행 느림

```
현상: 첫 실행 시 10-20분 소요
원인: OCR 모델 다운로드 (~2GB)
해결: 정상 동작, 두 번째부터 빠름
```

### "Prompt is too long" 에러

```
원인: PDF가 컨텍스트 윈도우 초과
해결: Marker로 변환 후 처리
```

### 스캔 PDF 빈 텍스트

```
원인: 이미지 기반 PDF에 OCR 미적용
해결: --force_ocr 옵션 사용
```

---

## 참고 자료

- [Marker GitHub](https://github.com/datalab-to/marker) - olmOCR-Bench #1, 31k+ stars
- [Surya OCR](https://github.com/VikParuchuri/surya) - 90+ 언어 지원
- [Gemini API Docs](https://ai.google.dev/gemini-api/docs)
- [pdf.md 스킬](.claude/skills/pdf.md) - 전체 PDF 처리 가이드

---

## 관련 스킬

| 스킬 | 용도 |
|------|------|
| `pdf.md` | 전체 PDF 처리 가이드 (텍스트, 표, 폼 등) |
| `km-content-extraction.md` | Knowledge Manager 콘텐츠 추출 |
| `knowledge-manager.md` | 지식 관리 에이전트 |

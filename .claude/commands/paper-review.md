# 추가된 논문 정리

paper 폴더에 새로 추가된 논문/리포트 파일들을 정리합니다.

## 🚀 핵심 변경: Marker로 PDF → Markdown 변환 (토큰 50-70% 절감)

**CRITICAL**: PDF를 직접 읽지 말고 **항상 Marker로 먼저 Markdown 변환** 후 읽으세요!

```bash
# 논문 PDF → Markdown 변환 (권장)
marker_single "paper.pdf" --output_format markdown --output_dir ./.claude/paper/converted

# 특정 페이지만 (빠른 분석용)
marker_single "paper.pdf" --output_format markdown --output_dir ./output --page_range "0-5"

# 수식 많은 논문 (고품질)
marker_single "paper.pdf" --output_format markdown --output_dir ./output --force_ocr
```

## 실행 프로세스

### Step 1: 새 파일 탐색
1. `.claude/paper` 폴더의 모든 파일 확인
2. 파일별 생성일/수정일/크기 확인
3. 새로 추가된 파일 리스트업
4. **Marker 변환 완료 여부 확인** (`.claude/paper/converted/` 폴더에 `.md` 파일 존재 여부)

### Step 2: 사용자에게 파일 목록 제시
새로 추가된 파일들을 다음 형식으로 보여주기:

```
📚 **Paper 폴더 내 파일 목록**

| # | 파일명 | 추가일 | 크기 | Marker 변환 |
|---|--------|--------|------|-------------|
| 1 | example.pdf | 2025-12-24 | 5.2MB | ✅ .md 있음 |
| 2 | another.pdf | 2025-12-23 | 15.1MB | ❌ 변환 필요 |

정리할 파일 번호를 선택해주세요 (예: 1, 2 또는 "전체")
⚠️ Marker 변환이 안 된 파일은 자동으로 변환 후 분석합니다.
```

### Step 3: 사용자 선택 확인
- 특정 번호 선택 시 해당 파일만 처리
- "전체" 선택 시 모든 파일 처리
- "오늘" 선택 시 오늘 추가된 파일만 처리

### Step 4: Marker로 PDF → Markdown 변환

#### 4-1. Marker 변환 실행
```bash
# 표준 변환 (대부분의 논문에 적합)
marker_single "paper.pdf" --output_format markdown --output_dir ./.claude/paper/converted --disable_multiprocessing

# 빠른 분석용 (처음 10페이지만)
marker_single "paper.pdf" --output_format markdown --output_dir ./output --page_range "0-9" --disable_multiprocessing

# 수식 많은 논문 (LaTeX 변환 강화)
marker_single "paper.pdf" --output_format markdown --output_dir ./output --force_ocr --disable_multiprocessing
```

#### 4-2. 변환 결과 확인
- 출력: `.claude/paper/converted/{파일명}/{파일명}.md`
- 이미지: `.claude/paper/converted/{파일명}/_page_*_Figure_*.jpeg`

#### 4-3. 구조 분석 (2단계 처리)
```
Step A: 빠른 분석 (Quick Analysis) - Markdown 읽기
├── Abstract 추출 (첫 섹션)
├── 목차/섹션 구조 파악 (## 헤딩 기준)
├── Conclusion 추출 (마지막 섹션)
└── 문서 개요 생성

Step B: 상세 분석 (선택적)
├── 사용자가 관심있는 섹션 선택
├── 해당 섹션만 읽기 (Markdown이므로 빠름)
└── 섹션별 요약 생성
```

#### 4-3. 사용자에게 구조 제시
```
📑 **문서 구조 분석 결과**

제목: Memory in the Age of AI Agents: A Survey
총 페이지: 68

**주요 섹션:**
1. Introduction (Page 1-3)
2. Agent Memory Definition (Page 4-8)
3. Forms of Memory (Page 9-25)
4. Functions of Memory (Page 26-45)
5. Memory Dynamics (Page 46-55)
6. Benchmarks (Page 56-60)
7. Future Directions (Page 61-65)
8. Conclusion (Page 66-68)

분석할 섹션을 선택해주세요 (예: 1,3,8 또는 "전체" 또는 "핵심만")
- "핵심만": Abstract + Introduction + Conclusion만 분석
```

### Step 5: Knowledge Manager 호출
선택된 섹션/파일에 대해 `/knowledge-manager` 커맨드 호출하여 처리

## 파일 경로
- Paper 폴더: `.claude/paper/`
- 추출 텍스트: `.claude/paper/{파일명}_extracted.txt`
- 출력 위치: `AI_Second_Brain/Research/` (기존 볼트 구조에 맞춤)

## Marker 변환 코드 (권장)

```bash
# 단일 논문 변환
marker_single "path/to/paper.pdf" --output_format markdown --output_dir ./converted --disable_multiprocessing

# 폴더 내 모든 PDF 일괄 변환
marker "./paper_folder" --output_format markdown --output_dir ./converted --workers 2
```

### 토큰 절감 효과
| 방식 | 페이지당 토큰 | 비고 |
|------|-------------|------|
| PDF 직접 읽기 (Vision) | ~1,500-3,000 | 이미지 토큰 포함 |
| **Marker → Markdown** | **~850-1,000** | **50-70% 절감** |

## Legacy: pdfplumber 추출 (필요시만)
```python
import pdfplumber

def extract_pdf_text(pdf_path):
    output_path = pdf_path.replace('.pdf', '_extracted.txt')
    with pdfplumber.open(pdf_path) as pdf:
        with open(output_path, 'w', encoding='utf-8') as f:
            for i, page in enumerate(pdf.pages):
                text = page.extract_text() or ""
                f.write(f"--- Page {i+1} ---\n{text}\n\n")
    return output_path
```

## 사용 예시
```
사용자: /paper-review
→ paper 폴더 파일 목록 표시
→ 대용량 파일 감지 시 구조 분석 먼저 실행
→ 섹션 선택 → knowledge-manager로 정리
```

$ARGUMENTS

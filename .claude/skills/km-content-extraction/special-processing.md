---
name: km-content-extraction/special-processing
description: 특수 처리 + 스킬 참조 — 배치/대용량/혼합 소스 처리, 관련 스킬 목록
---

# 특수 처리

---

## 배치 처리

```
여러 소스 입력 시:

1. 각 소스 순차 처리
2. 소스 추적 유지
3. 소스 간 교차 참조 식별
4. 종합 연결 맵 생성
5. 요약 보고서 생성
```

---

## 대용량 문서 처리

```
대용량 문서 처리 전략:

1. 청크 단위 처리
   - 섹션별 분할
   - 순차 처리
   - 결과 통합

2. 진행 상황 표시
   - 처리 중인 섹션 안내
   - 예상 완료 시간 (가능 시)

3. 품질 유지
   - 청크 간 맥락 유지
   - 연결 정보 보존
```

---

## 혼합 소스 처리

```
여러 유형의 소스가 함께 제공될 때:

예: URL + PDF + "이전 노트도 참고해서"

처리 순서:
1. 각 소스 유형 식별
2. 개별 추출 수행
3. 추출 결과 통합
4. 교차 참조 분석
5. 통합 노트 생성
```

---

## 스킬 참조

- **km-glm-ocr.md**: GLM-OCR 로컬 OCR (테이블/수식/코드, PaddleOCR 대비 5.6x 빠름)
- **km-youtube-transcript.md**: YouTube 트랜스크립트 추출 + 분석
- **km-social-media.md**: 소셜 미디어 전용 추출
- **pdf.md**: PDF 상세 처리
- **xlsx.md**: Excel 상세 처리
- **docx.md**: Word 상세 처리
- **pptx.md**: PowerPoint 상세 처리
- **notion-knowledge-capture.md**: Notion 상세 처리

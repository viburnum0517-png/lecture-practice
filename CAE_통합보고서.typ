#set page(paper: "a4", margin: (top: 2cm, bottom: 2cm, left: 2cm, right: 2cm))
#set text(font: "Malgun Gothic", size: 10pt)

// 색상 정의
#let 파랑 = rgb("#1a5276")
#let 빨강 = rgb("#c0392b")
#let 검정 = rgb("#2c3e50")
#let 연회 = rgb("#eaf2f8")
#let 연빨 = rgb("#fdedec")

// 제목
#align(center)[
  #text(size: 22pt, weight: "bold", fill: 파랑)[CAE 설계 검토 통합 보고서]
  #v(0.3cm)
  #text(size: 11pt, fill: 검정)[성우하이텍 A-RnD · Evan-Park]
  #v(0.1cm)
  #text(size: 10pt, fill: gray)[분석일: 2026-04-09 · 통합 파이프라인 자동 생성]
]

#v(0.5cm)
#line(length: 100%, stroke: 0.5pt + 파랑)
#v(0.3cm)

// 판정 기준 박스
#rect(fill: 연회, radius: 6pt, width: 100%, inset: 12pt)[
  #text(weight: "bold", fill: 파랑)[판정 기준]
  #v(0.2cm)
  #text(fill: 검정)[
    - 최대응력 > *500 MPa* → 불합격\
    - 안전계수 < *2.0* → 불합격\
    - 둘 중 하나라도 해당하면 불합격 처리
  ]
]

#v(0.4cm)

// 요약 통계
#text(size: 14pt, weight: "bold", fill: 파랑)[1. 요약 통계]
#v(0.2cm)

#table(
  columns: (1fr, 1fr, 1fr, 1fr),
  align: center,
  fill: (col, row) => if row == 0 { 파랑 } else { white },
  stroke: 0.5pt + gray,
  text(fill: white, weight: "bold")[항목],
  text(fill: white, weight: "bold")[수량],
  text(fill: white, weight: "bold")[비율],
  text(fill: white, weight: "bold")[상태],
  [전체 부품], [15개], [100%], [—],
  text(fill: 파랑, weight: "bold")[합격], text(fill: 파랑, weight: "bold")[8개], text(fill: 파랑, weight: "bold")[53.3%], [정상],
  text(fill: 빨강, weight: "bold")[불합격], text(fill: 빨강, weight: "bold")[7개], text(fill: 빨강, weight: "bold")[46.7%], [조치 필요],
)

#v(0.5cm)

// 전체 판정표
#text(size: 14pt, weight: "bold", fill: 파랑)[2. 전체 판정 결과]
#v(0.2cm)

#table(
  columns: (0.8fr, 1.2fr, 1fr, 0.8fr, 0.8fr, 1.5fr),
  align: center,
  fill: (col, row) => if row == 0 { 파랑 } else if calc.rem(row, 2) == 0 { luma(245) } else { white },
  stroke: 0.5pt + gray,
  text(fill: white, weight: "bold")[부품번호],
  text(fill: white, weight: "bold")[부품명],
  text(fill: white, weight: "bold")[최대응력],
  text(fill: white, weight: "bold")[안전계수],
  text(fill: white, weight: "bold")[판정],
  text(fill: white, weight: "bold")[불합격 사유],
  [P-001], [브래킷 A], [423.5], [2.35], text(fill: 파랑, weight: "bold")[합격], [—],
  [P-002], [샤프트 B], text(fill: 빨강, weight: "bold")[512.7], text(fill: 빨강, weight: "bold")[1.85], text(fill: 빨강, weight: "bold")[불합격], text(size: 8pt, fill: 빨강)[응력 초과 + SF 미달],
  [P-003], [플랜지 C], [389.2], [2.78], text(fill: 파랑, weight: "bold")[합격], [—],
  [P-004], [볼트 D], text(fill: 빨강, weight: "bold")[534.1], text(fill: 빨강, weight: "bold")[1.72], text(fill: 빨강, weight: "bold")[불합격], text(size: 8pt, fill: 빨강)[응력 초과 + SF 미달],
  [P-005], [베어링 하우징], [467.3], [2.12], text(fill: 파랑, weight: "bold")[합격], [—],
  [P-006], [커플링 E], [298.6], [3.10], text(fill: 파랑, weight: "bold")[합격], [—],
  [P-007], [기어 F], text(fill: 빨강, weight: "bold")[521.9], text(fill: 빨강, weight: "bold")[1.68], text(fill: 빨강, weight: "bold")[불합격], text(size: 8pt, fill: 빨강)[응력 초과 + SF 미달],
  [P-008], [브레이킷 G], [445.8], [2.05], text(fill: 파랑, weight: "bold")[합격], [—],
  [P-009], [축 H], [487.4], text(fill: 빨강, weight: "bold")[1.95], text(fill: 빨강, weight: "bold")[불합격], text(size: 8pt, fill: 빨강)[SF 미달],
  [P-010], [캡 I], [315.2], [2.90], text(fill: 파랑, weight: "bold")[합격], [—],
  [P-011], [서포트 J], text(fill: 빨강, weight: "bold")[503.6], text(fill: 빨강, weight: "bold")[1.78], text(fill: 빨강, weight: "bold")[불합격], text(size: 8pt, fill: 빨강)[응력 초과 + SF 미달],
  [P-012], [링 K], [378.9], [2.55], text(fill: 파랑, weight: "bold")[합격], [—],
  [P-013], [핀 L], text(fill: 빨강, weight: "bold")[556.2], text(fill: 빨강, weight: "bold")[1.45], text(fill: 빨강, weight: "bold")[불합격], text(size: 8pt, fill: 빨강)[응력 초과 + SF 미달],
  [P-014], [하우징 M], [412.1], [2.20], text(fill: 파랑, weight: "bold")[합격], [—],
  [P-015], [플레이트 N], [491.8], text(fill: 빨강, weight: "bold")[1.88], text(fill: 빨강, weight: "bold")[불합격], text(size: 8pt, fill: 빨강)[SF 미달],
)

#v(0.5cm)

// 우선 조치 계획
#text(size: 14pt, weight: "bold", fill: 빨강)[3. 불합격 부품 우선 조치 계획]
#v(0.2cm)

#rect(fill: 연빨, radius: 6pt, width: 100%, inset: 12pt)[
  #text(weight: "bold", fill: 빨강)[위험도 순 정렬 (응력 높은 순)]
]

#v(0.2cm)

#table(
  columns: (0.5fr, 0.8fr, 1fr, 0.7fr, 0.7fr, 0.8fr, 1.5fr),
  align: center,
  fill: (col, row) => if row == 0 { 빨강 } else if calc.rem(row, 2) == 0 { 연빨 } else { white },
  stroke: 0.5pt + gray,
  text(fill: white, weight: "bold")[순위],
  text(fill: white, weight: "bold")[부품번호],
  text(fill: white, weight: "bold")[부품명],
  text(fill: white, weight: "bold")[응력],
  text(fill: white, weight: "bold")[SF],
  text(fill: white, weight: "bold")[긴급도],
  text(fill: white, weight: "bold")[권장 조치],
  [1], [P-013], [핀 L], [556.2], [1.45], text(fill: 빨강, weight: "bold")[즉시], [형상 재설계 + 재질 변경 검토],
  [2], [P-004], [볼트 D], [534.1], [1.72], text(fill: 빨강, weight: "bold")[즉시], [체결 사양 변경 + 보강 검토],
  [3], [P-007], [기어 F], [521.9], [1.68], text(fill: 빨강, weight: "bold")[즉시], [치형 최적화 + 재질 업그레이드],
  [4], [P-002], [샤프트 B], [512.7], [1.85], text(fill: 빨강)[1주], [단면적 확대 + 응력 집중부 완화],
  [5], [P-011], [서포트 J], [503.6], [1.78], text(fill: 빨강)[1주], [리브 보강 + 두께 증가],
  [6], [P-015], [플레이트 N], [491.8], [1.88], text(fill: gray)[2주], [두께 증가 또는 재질 변경],
  [7], [P-009], [축 H], [487.4], [1.95], text(fill: gray)[2주], [필렛 반경 확대 + 표면처리],
)

#v(0.5cm)

// 파이프라인 정보
#line(length: 100%, stroke: 0.5pt + 파랑)
#v(0.2cm)
#align(center)[
  #text(size: 8pt, fill: gray)[
    본 보고서는 Claude Code 통합 파이프라인으로 자동 생성되었습니다.\
    CSV 입력 → 자동 판정 → 보고서 생성 → Typst PDF 변환\
    판정 기준: 최대응력 > 500MPa 또는 안전계수 < 2.0 → 불합격
  ]
]

// 페이지 번호
#align(center)[#context counter(page).display()]

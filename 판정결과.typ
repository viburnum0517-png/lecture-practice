// ── 색상 정의 ──────────────────────────────────────
#let c-blue = rgb("#1a5fa8")
#let c-red  = rgb("#c0392b")
#let c-black = rgb("#1a1a1a")
#let c-bg-red = rgb("#fdecea")
#let c-bg-blue = rgb("#eaf1fb")
#let c-border = rgb("#cccccc")

// ── 페이지 설정 ────────────────────────────────────
#set page(
  paper: "a4",
  margin: (top: 2cm, bottom: 2cm, left: 2.2cm, right: 2.2cm),
  header: [
    #set text(size: 8pt, fill: c-blue)
    #grid(columns: (1fr, 1fr),
      [성우하이텍 A-RnD 그룹 | CAE 응력 해석 판정 보고서],
      align(right)[분석일: 2026-04-09]
    )
    #line(length: 100%, stroke: 0.5pt + c-blue)
  ],
  footer: [
    #line(length: 100%, stroke: 0.5pt + c-border)
    #set text(size: 8pt, fill: gray)
    #align(center)[#context counter(page).display()]
  ]
)

#set text(font: "Malgun Gothic", size: 10pt, fill: c-black)
#set par(leading: 0.8em)

// ── 제목 ───────────────────────────────────────────
#align(center)[
  #block(
    fill: c-blue,
    radius: 6pt,
    inset: (x: 20pt, y: 12pt),
    width: 100%
  )[
    #text(size: 18pt, weight: "bold", fill: white)[
      CAE 응력 해석 결과 — 합격/불합격 판정표
    ]
  ]
]

#v(0.5cm)

// ── 판정 기준 박스 ──────────────────────────────────
#block(
  fill: c-bg-blue,
  stroke: 1pt + c-blue,
  radius: 4pt,
  inset: 12pt,
  width: 100%
)[
  #text(weight: "bold", fill: c-blue)[📋 판정 기준]
  #v(4pt)
  #text[불합격 조건: ]
  #text(fill: c-red, weight: "bold")[최대응력 \> 500 MPa]
  #text[ 또는 ]
  #text(fill: c-red, weight: "bold")[안전계수 \< 2.0]
  #text[ (둘 중 하나라도 해당 시 불합격)]
  #linebreak()
  #text[분석 대상: 19개 부품 | 분석일: 2026-04-09 | 담당: Evan-Park (A-RnD)]
]

#v(0.4cm)

// ── 요약 통계 ──────────────────────────────────────
#grid(
  columns: (1fr, 1fr, 1fr),
  gutter: 12pt,
  // 전체
  block(fill: rgb("#f5f5f5"), stroke: 1pt + c-border, radius: 4pt, inset: 10pt, width: 100%)[
    #align(center)[
      #text(size: 22pt, weight: "bold", fill: c-black)[19]
      #linebreak()
      #text(size: 9pt, fill: gray)[전체 부품]
    ]
  ],
  // 합격
  block(fill: c-bg-blue, stroke: 1pt + c-blue, radius: 4pt, inset: 10pt, width: 100%)[
    #align(center)[
      #text(size: 22pt, weight: "bold", fill: c-blue)[12]
      #linebreak()
      #text(size: 9pt, fill: c-blue)[✅ 합격 (63%)]
    ]
  ],
  // 불합격
  block(fill: c-bg-red, stroke: 1pt + c-red, radius: 4pt, inset: 10pt, width: 100%)[
    #align(center)[
      #text(size: 22pt, weight: "bold", fill: c-red)[7]
      #linebreak()
      #text(size: 9pt, fill: c-red)[❌ 불합격 (37%)]
    ]
  ]
)

#v(0.4cm)

// ── 전체 판정 결과 표 ───────────────────────────────
#text(size: 12pt, weight: "bold", fill: c-blue)[전체 판정 결과]
#v(0.2cm)

#let pass-row(id, name, stress, sf, mat) = (
  table.cell(align: center)[#id],
  table.cell[#name],
  table.cell(align: center)[#stress],
  table.cell(align: center)[#sf],
  table.cell(align: center)[#mat],
  table.cell(align: center)[#text(fill: c-blue, weight: "bold")[✅ 합격]],
)

#let fail-row(id, name, stress, sf, mat, reason) = (
  table.cell(fill: c-bg-red, align: center)[#text(fill: c-red)[#id]],
  table.cell(fill: c-bg-red)[#text(fill: c-red, weight: "bold")[#name]],
  table.cell(fill: c-bg-red, align: center)[#text(fill: c-red, weight: "bold")[#stress]],
  table.cell(fill: c-bg-red, align: center)[#text(fill: c-red, weight: "bold")[#sf]],
  table.cell(fill: c-bg-red, align: center)[#mat],
  table.cell(fill: c-bg-red, align: center)[#text(fill: c-red, weight: "bold")[❌ 불합격]],
)

#table(
  columns: (auto, 1fr, auto, auto, auto, auto),
  fill: (_, row) => if row == 0 { c-blue } else { none },
  stroke: 0.5pt + c-border,
  inset: 7pt,
  // 헤더
  table.header(
    table.cell(align: center)[#text(fill: white, weight: "bold")[부품 ID]],
    table.cell(align: center)[#text(fill: white, weight: "bold")[부품명]],
    table.cell(align: center)[#text(fill: white, weight: "bold")[응력 (MPa)]],
    table.cell(align: center)[#text(fill: white, weight: "bold")[안전계수]],
    table.cell(align: center)[#text(fill: white, weight: "bold")[소재]],
    table.cell(align: center)[#text(fill: white, weight: "bold")[판정]],
  ),
  // 데이터
  ..pass-row("P001", "프론트 브라켓",     "487.3", "2.15", "SPCC"),
  ..fail-row("P002", "리어 마운트",        "523.8", "1.87", "SAPH440", "응력+안전계수"),
  ..pass-row("P003", "배터리 케이스 상판", "462.1", "2.34", "Al5052"),
  ..pass-row("P004", "배터리 케이스 하판", "498.6", "2.02", "Al6061"),
  ..fail-row("P005", "센터 크로스멤버",    "541.7", "1.74", "DP980", "응력+안전계수"),
  ..pass-row("P006", "사이드 레일 보강판", "476.9", "2.21", "SAPH590"),
  ..fail-row("P007", "모터 하우징 브라켓", "509.4", "1.96", "SPFC980", "응력+안전계수"),
  ..pass-row("P008", "인버터 커버",        "438.5", "2.48", "Al5052"),
  ..pass-row("P009", "충전구 지지대",      "492.4", "2.06", "SGARC440"),
  ..fail-row("P010", "서브프레임 링크",    "556.2", "1.69", "SABC1470", "응력+안전계수"),
  ..pass-row("P011", "도어 임팩트 빔",     "471.2", "2.27", "UHSS1180"),
  ..fail-row("P012", "시트 크로스바",      "503.1", "1.99", "SPFH590", "응력+안전계수"),
  ..pass-row("P013", "페달 브라켓",        "449.7", "2.39", "SPCC"),
  ..pass-row("P014", "IP 캐리어 보강판",   "494.9", "2.03", "SAPH440"),
  ..fail-row("P015", "후륜 너클 서포트",   "517.6", "1.82", "SCGA780", "응력+안전계수"),
  ..pass-row("P016", "BMS 고정 브래킷",    "421.8", "2.61", "SECC"),
  ..pass-row("P017", "로커패널 인너",      "486.4", "2.14", "GA590"),
  ..fail-row("P018", "테일게이트 힌지판",  "533.9", "1.78", "SPFH780", "응력+안전계수"),
  ..pass-row("P019", "전방 충돌 센서 브라켓","458.2","2.33","SGHC440"),
)

#v(0.5cm)

// ── 최고 위험 부품 ──────────────────────────────────
#block(
  fill: c-bg-red,
  stroke: 2pt + c-red,
  radius: 4pt,
  inset: 12pt,
  width: 100%
)[
  #text(weight: "bold", fill: c-red, size: 11pt)[⚠️ 최고 위험 부품]
  #v(4pt)
  #text[*P010 서브프레임 링크* — 최대응력 *556.2 MPa* (기준 대비 +11.2%), 안전계수 *1.69* (기준 대비 -15.5%)]
  #linebreak()
  #text(size: 9pt, fill: c-red)[즉시 설계 검토 및 소재/두께 재검토 권고]
]

#v(0.5cm)

// ── 우선조치 ────────────────────────────────────────
#text(size: 12pt, weight: "bold", fill: c-blue)[우선조치 계획]
#v(0.2cm)

#table(
  columns: (auto, auto, 1fr, auto),
  fill: (_, row) => if row == 0 { c-blue } else if calc.odd(row) { rgb("#fafafa") } else { white },
  stroke: 0.5pt + c-border,
  inset: 7pt,
  table.header(
    table.cell(align: center)[#text(fill: white, weight: "bold")[순위]],
    table.cell(align: center)[#text(fill: white, weight: "bold")[부품 ID / 부품명]],
    table.cell(align: center)[#text(fill: white, weight: "bold")[우선조치 내용]],
    table.cell(align: center)[#text(fill: white, weight: "bold")[긴급도]],
  ),
  table.cell(align: center)[#text(weight: "bold", fill: c-red)[1]],
  [P010 서브프레임 링크],
  [소재(SABC1470) 두께 증대 또는 고강도재 변경 검토. CAE 재해석 즉시 의뢰],
  table.cell(align: center)[#text(fill: c-red, weight: "bold")[즉시]],

  table.cell(align: center)[#text(weight: "bold", fill: c-red)[2]],
  [P005 센터 크로스멤버],
  [DP980 소재 보강 리브 추가 또는 단면 형상 변경. 설계 검토 회의 소집],
  table.cell(align: center)[#text(fill: c-red, weight: "bold")[즉시]],

  table.cell(align: center)[#text(weight: "bold", fill: c-red)[3]],
  [P018 테일게이트 힌지판],
  [힌지 체결부 응력 집중 부위 필렛 반경 확대. 설계용역사 재설계 요청],
  table.cell(align: center)[#text(fill: c-red, weight: "bold")[1주 내]],

  table.cell(align: center)[4],
  [P002 리어 마운트],
  [마운팅 브라켓 두께 0.5mm 증대 검토. 협력사 설계 변경 요청],
  table.cell(align: center)[#text(fill: rgb("#e67e22"), weight: "bold")[1주 내]],

  table.cell(align: center)[5],
  [P015 후륜 너클 서포트],
  [너클 서포트 용접부 보강 및 소재 등급 상향(SCGA780 → SCGA980) 검토],
  table.cell(align: center)[#text(fill: rgb("#e67e22"), weight: "bold")[2주 내]],

  table.cell(align: center)[6],
  [P007 모터 하우징 브라켓],
  [브라켓 형상 최적화(토폴로지) 또는 보강판 추가. 설계팀 내부 검토],
  table.cell(align: center)[#text(fill: rgb("#e67e22"), weight: "bold")[2주 내]],

  table.cell(align: center)[7],
  [P012 시트 크로스바],
  [크로스바 단면 두께 증대(2.6mm → 3.0mm) 및 재해석 요청],
  table.cell(align: center)[#text(fill: c-black)[3주 내]],
)

#v(0.3cm)
#block(
  fill: c-bg-blue,
  stroke: 1pt + c-blue,
  radius: 4pt,
  inset: 10pt,
  width: 100%
)[
  #text(weight: "bold", fill: c-blue)[📌 공통 후속 조치]
  #v(4pt)
  #text[① 불합격 7개 부품 전체에 대해 설계변경 이력 관리 시스템(PLM) 등록 \ ]
  #text[② 협력사 설계용역 계약 시 판정 기준(응력/안전계수) 사전 명시 조항 추가 \ ]
  #text[③ 다음 CAE 해석 사이클 전 기준값 재검토 회의 개최]
]

#pagebreak()

// ── 체크리스트 1: 불합격 부품별 후속 조치 ────────────
#text(size: 14pt, weight: "bold", fill: c-blue)[체크리스트 1 — 불합격 부품별 후속 조치 완료 확인]
#v(0.1cm)
#text(size: 9pt, fill: gray)[담당자: Evan-Park  |  기준일: 2026-04-09  |  □ 미완료  ☑ 완료]
#v(0.3cm)

#let check-row(priority, id, name, action, deadline, urgency-color) = (
  table.cell(align: center)[#text(weight: "bold", fill: urgency-color)[#priority]],
  table.cell(align: center)[□],
  [#text(weight: "bold")[#id] \ #text(size: 9pt, fill: gray)[#name]],
  [#action],
  table.cell(align: center)[#text(fill: urgency-color, weight: "bold")[#deadline]],
  table.cell(align: center)[□],
)

#table(
  columns: (auto, auto, auto, 1fr, auto, auto),
  fill: (_, row) => if row == 0 { c-blue } else if calc.odd(row) { rgb("#fafafa") } else { white },
  stroke: 0.5pt + c-border,
  inset: 7pt,
  table.header(
    table.cell(align: center)[#text(fill: white, weight: "bold")[순위]],
    table.cell(align: center)[#text(fill: white, weight: "bold")[착수]],
    table.cell(align: center)[#text(fill: white, weight: "bold")[부품]],
    table.cell(align: center)[#text(fill: white, weight: "bold")[조치 내용]],
    table.cell(align: center)[#text(fill: white, weight: "bold")[기한]],
    table.cell(align: center)[#text(fill: white, weight: "bold")[완료]],
  ),
  ..check-row("1", "P010", "서브프레임 링크",
    [소재(SABC1470) 두께 증대 또는 고강도재 변경. CAE 재해석 즉시 의뢰],
    "즉시", c-red),
  ..check-row("2", "P005", "센터 크로스멤버",
    [DP980 보강 리브 추가 또는 단면 형상 변경. 설계 검토 회의 소집],
    "즉시", c-red),
  ..check-row("3", "P018", "테일게이트 힌지판",
    [힌지 체결부 필렛 반경 확대. 설계용역사 재설계 요청],
    "1주 내", c-red),
  ..check-row("4", "P002", "리어 마운트",
    [브라켓 두께 0.5mm 증대 검토. 협력사 설계 변경 요청],
    "1주 내", rgb("#e67e22")),
  ..check-row("5", "P015", "후륜 너클 서포트",
    [용접부 보강 및 소재 등급 상향(SCGA780 → SCGA980) 검토],
    "2주 내", rgb("#e67e22")),
  ..check-row("6", "P007", "모터 하우징 브라켓",
    [형상 최적화(토폴로지) 또는 보강판 추가. 설계팀 내부 검토],
    "2주 내", rgb("#e67e22")),
  ..check-row("7", "P012", "시트 크로스바",
    [단면 두께 증대(2.6mm → 3.0mm) 및 CAE 재해석 요청],
    "3주 내", c-black),
)

#v(0.3cm)
#grid(columns: (1fr, 1fr), gutter: 10pt,
  block(stroke: 0.5pt + c-border, radius: 4pt, inset: 10pt)[
    #text(weight: "bold")[PLM 등록 확인] \
    #v(4pt)
    □ 불합격 7개 부품 PLM 등록 완료 \
    □ 설계변경 이력 번호 부여 완료 \
    □ 관련 부서 공유 완료
  ],
  block(stroke: 0.5pt + c-border, radius: 4pt, inset: 10pt)[
    #text(weight: "bold")[검토 서명란] \
    #v(4pt)
    작성자: Evan-Park \
    #v(8pt)
    검토자: ______________ \
    #v(8pt)
    승인자: ______________
  ]
)

#pagebreak()

// ── 체크리스트 2: 설계 검토 사전 확인 ────────────────
#text(size: 14pt, weight: "bold", fill: c-blue)[체크리스트 2 — CAE 제출 전 설계 검토 사전 확인]
#v(0.1cm)
#text(size: 9pt, fill: gray)[다음 CAE 해석 사이클 제출 전 반드시 확인  |  □ 미확인  ☑ 확인완료]
#v(0.3cm)

#let pre-row(category, item, note) = (
  table.cell(align: center, fill: rgb("#f0f4fa"))[#text(fill: c-blue, weight: "bold")[#category]],
  table.cell(align: center)[□],
  [#item],
  [#text(size: 9pt, fill: gray)[#note]],
)

#table(
  columns: (auto, auto, 1fr, 1fr),
  fill: (_, row) => if row == 0 { c-blue } else { white },
  stroke: 0.5pt + c-border,
  inset: 7pt,
  table.header(
    table.cell(align: center)[#text(fill: white, weight: "bold")[구분]],
    table.cell(align: center)[#text(fill: white, weight: "bold")[확인]],
    table.cell(align: center)[#text(fill: white, weight: "bold")[확인 항목]],
    table.cell(align: center)[#text(fill: white, weight: "bold")[비고]],
  ),
  // 판정 기준
  ..pre-row("기준값", [판정 기준값(응력 500MPa / 안전계수 2.0) 최신 버전 확인],
    [설계기준서 Rev. 확인 필수]),
  ..pre-row("기준값", [부품별 소재 허용 응력 기준 개별 확인],
    [소재별 기준 상이 가능]),
  ..pre-row("기준값", [하중 조건(정하중/동하중) 적용 기준 확인],
    [충돌/피로 하중 구분]),
  // 데이터
  ..pre-row("데이터", [CAE 입력 데이터 원본 파일명 및 버전 기록],
    [result_vX.X.csv 형태]),
  ..pre-row("데이터", [부품 ID와 도면 번호 매핑 일치 여부 확인],
    [PLM 도면번호와 대조]),
  ..pre-row("데이터", [해석 담당자 및 해석 소프트웨어 버전 기록],
    [ANSYS / ABAQUS 등]),
  // 협력사
  ..pre-row("용역", [협력사 제출 도면에 응력/안전계수 결과값 포함 여부],
    [미포함 시 반려]),
  ..pre-row("용역", [협력사 체크리스트 자체 검토 결과서 첨부 여부],
    [자체 판정표 요구]),
  ..pre-row("용역", [설계 변경 이력(ECN) 반영 여부 확인],
    [이전 불합격 조치 반영]),
  // 보고
  ..pre-row("보고", [불합격 부품 즉시 보고 경로 사전 확인 (팀장 → 부서장)],
    [보고 체계 확인]),
  ..pre-row("보고", [판정결과.md / PDF 보고서 최신화 후 공유 폴더 업로드],
    [공유 폴더 경로 확인]),
  ..pre-row("보고", [다음 CAE 재해석 일정 및 담당자 지정 완료],
    [불합격 부품 재해석 포함]),
)

#v(0.3cm)
#block(
  fill: c-bg-blue,
  stroke: 1pt + c-blue,
  radius: 4pt,
  inset: 10pt,
  width: 100%
)[
  #text(weight: "bold", fill: c-blue)[💡 Evan-Park님 업무 팁]
  #v(4pt)
  #text[설계용역 관리 시 협력사에 이 체크리스트 2를 사전 배포하면, 제출 전 자체 검토율이 높아집니다. \ ]
  #text[판정결과.md 파일을 Claude에게 붙여넣으면 불합격 부품 요약 이메일 초안도 즉시 생성 가능합니다.]
]

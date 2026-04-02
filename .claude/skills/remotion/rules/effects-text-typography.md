---
name: effects-text-typography
description: Use when needing text effects and typography style catalog for Remotion
metadata:
  tags: catalog, text, typography, animation, style
---

# Text & Typography Effects

> 텍스트 효과, 타이포그래피 스타일 프롬프트 레퍼런스

## 1. 텍스트 등장 애니메이션

> 텍스트의 등장 방식을 제어합니다. 공식적인 느낌에는 페이드인, 에너지 있는 느낌에는 바운스/스프링, 드라마틱한 노출에는 마스크 리빌을 추천합니다.
> 상세: [reference](../reference/remotion-effects-reference.md)

| 프롬프트 | 설명 | 구현 참고 |
|---------|------|----------|
| `텍스트 페이드인` | 투명→불투명으로 서서히 등장 | [text-animations.md](text-animations.md) |
| `텍스트 스케일업 등장` | 작은 상태에서 커지며 등장 | [text-animations.md](text-animations.md) |
| `텍스트 스케일다운 등장` | 큰 상태에서 줄어들며 등장 | [text-animations.md](text-animations.md) |
| `텍스트 슬라이드업` | 아래에서 위로 올라옴 | [text-animations.md](text-animations.md) |
| `텍스트 슬라이드다운` | 위에서 아래로 내려옴 | [text-animations.md](text-animations.md) |
| `텍스트 슬라이드 좌→우` | 왼쪽에서 밀고 들어옴 | [text-animations.md](text-animations.md) |
| `텍스트 슬라이드 우→좌` | 오른쪽에서 밀고 들어옴 | [text-animations.md](text-animations.md) |
| `텍스트 바운스 등장` | 통통 튀듯 등장 | [text-animations.md](text-animations.md) |
| `텍스트 스프링 등장` | 오버슈트 후 제자리 (스프링 물리) | [timing.md](timing.md) |
| `텍스트 엘라스틱 등장` | 고무줄처럼 탄성 있게 등장 | [timing.md](timing.md) |
| `텍스트 블러→선명` | 흐릿했다가 선명해지며 등장 | [text-animations.md](text-animations.md) |
| `텍스트 레터스페이싱 좁혀지기` | 글자 간격이 넓었다가 좁혀짐 | [text-animations.md](text-animations.md) |
| `텍스트 로테이션 등장` | 회전하면서 등장 | [text-animations.md](text-animations.md) |
| `텍스트 3D 플립 등장` | 3D 뒤집기로 등장 | [text-animations.md](text-animations.md) |
| `텍스트 마스크 리빌` | 사각형 마스크가 열리면서 노출 | [text-animations.md](text-animations.md) |
| `텍스트 클립패스 리빌` | clip-path가 변형되며 노출 | [text-animations.md](text-animations.md) |
| `텍스트 커튼 리빌` | 커튼이 열리듯 양쪽으로 벌어지며 노출 | [text-animations.md](text-animations.md) |

> **참고**: [Remotion Animating Properties](https://www.remotion.dev/docs/animating-properties) | [interpolate()](https://www.remotion.dev/docs/interpolate) | [spring()](https://www.remotion.dev/docs/spring)

## 2. 글자/단어별 애니메이션

> 텍스트를 글자/단어 단위로 분해하여 시차를 두고 애니메이트합니다. 설명 영상에는 타자기, 임팩트에는 글자별 바운스, 유머에는 셔플/스크램블을 추천합니다.
> 상세: [reference](../reference/remotion-effects-reference.md)

| 프롬프트 | 설명 | 구현 참고 |
|---------|------|----------|
| `타자기 효과` | 한 글자씩 타이핑되듯 등장 | [text-animations.md](text-animations.md) |
| `글자별 순차 등장` | 각 글자가 시차를 두고 하나씩 | [text-animations.md](text-animations.md) |
| `단어별 순차 등장` | 각 단어가 시차를 두고 하나씩 | [text-animations.md](text-animations.md) |
| `줄별 순차 등장` | 각 줄이 시차를 두고 하나씩 | [text-animations.md](text-animations.md) |
| `글자별 웨이브` | 글자가 파도처럼 위아래로 | [text-animations.md](text-animations.md) |
| `글자별 바운스` | 각 글자가 개별적으로 바운스 | [text-animations.md](text-animations.md) |
| `글자별 회전` | 각 글자가 독립적으로 회전 | [text-animations.md](text-animations.md) |
| `단어별 회전` | 각 단어가 회전하며 등장 | [text-animations.md](text-animations.md) |
| `글자별 3D 플립` | 각 글자가 3D로 뒤집히며 등장 | [text-animations.md](text-animations.md) |
| `글자별 플로팅` | 글자들이 각각 둥둥 떠다님 | [text-animations.md](text-animations.md) |
| `텍스트 셔플/스크램블` | 랜덤 글자가 돌다가 최종 텍스트로 고정 | [text-animations.md](text-animations.md) |
| `스플릿 플랩 (공항 안내판)` | 공항 출발 안내판처럼 글자가 뒤집힘 | [text-animations.md](text-animations.md) |
| `오도미터 (숫자 롤링)` | 숫자가 위아래로 굴러가며 변환 | [text-animations.md](text-animations.md) |

> **참고**: [remotion-animate-text](https://github.com/pskd73/remotion-animate-text) | [Making Stagger Reveal Animations](https://tympanus.net/codrops/2020/06/17/making-stagger-reveal-animations-for-text/) | [CSS Text Animations 40 Examples](https://prismic.io/blog/css-text-animations)

## 3. 텍스트 스타일 효과

> 텍스트의 시각적 스타일을 결정합니다. 가격 강조에는 카운트업, 브랜드 표현에는 골드/크롬 텍스트, 테크 분위기에는 글리치/크로마틱 어버레이션을 추천합니다.
> 상세: [reference](../reference/remotion-effects-reference.md)

| 프롬프트 | 설명 | 구현 참고 |
|---------|------|----------|
| `글로우 텍스트` | 텍스트 주변 빛나는 후광 | [text-animations.md](text-animations.md) |
| `네온 텍스트` | 네온사인처럼 빛남 | [text-animations.md](text-animations.md) |
| `네온 깜빡임` | 네온이 불규칙하게 깜빡임 | [text-animations.md](text-animations.md) |
| `그라데이션 텍스트` | 텍스트에 색상 그라데이션 | [text-animations.md](text-animations.md) |
| `그라데이션 애니메이션 텍스트` | 그라데이션이 움직임 | [text-animations.md](text-animations.md) |
| `크롬/메탈릭 텍스트` | 금속 질감 반사 그라데이션 | [text-animations.md](text-animations.md) |
| `골드 텍스트` | 금색 그라데이션 + 광택 | [text-animations.md](text-animations.md) |
| `홀로그래픽 텍스트` | 무지개빛으로 변하는 텍스트 | [text-animations.md](text-animations.md) |
| `아웃라인 텍스트` | 속 빈 외곽선만 있는 텍스트 | [text-animations.md](text-animations.md) |
| `아웃라인 드로잉 텍스트` | SVG로 외곽선이 그려지는 효과 | [text-animations.md](text-animations.md) |
| `3D 입체 텍스트` | 그림자 레이어로 입체감 | [text-animations.md](text-animations.md) |
| `글리치 텍스트` | 디지털 글리치 (위치/색상 떨림) | [text-animations.md](text-animations.md) |
| `크로마틱 어버레이션 텍스트` | RGB 채널 분리 | [text-animations.md](text-animations.md) |
| `하이라이트 효과` | 형광펜으로 칠한 듯한 배경 | [text-animations.md](text-animations.md) |
| `밑줄 애니메이션` | 밑줄이 좌→우로 그려짐 | [text-animations.md](text-animations.md) |
| `쉬머/샤인 스윕` | 빛 그라데이션이 텍스트 위를 지나감 | [text-animations.md](text-animations.md) |
| `타이핑 커서` | 깜빡이는 커서 표시 | [text-animations.md](text-animations.md) |
| `카운트업 숫자` | 0에서 목표값까지 올라감 | [text-animations.md](text-animations.md) |
| `카운트다운 숫자` | 목표값에서 0까지 내려감 | [text-animations.md](text-animations.md) |

> **참고**: [CSS Neon Text](https://css-tricks.com/how-to-create-neon-text-with-css/) | [SVG Text Drawing Animation](https://dev.to/0shuvo0/css-text-drawing-animation-with-svg-4nkk) | [CSS Glitch Effects](https://css-tricks.com/glitch-effect-text-images-svg/) | [Animating Number Counters](https://css-tricks.com/animating-number-counters/)

## 4. 텍스트 퇴장 애니메이션

> 텍스트가 화면에서 사라지는 효과입니다. 자연스러운 퇴장은 페이드아웃, 빠른 전환에는 슬라이드아웃, 강렬한 마무리에는 글리치 아웃을 추천합니다.
> 상세: [reference](../reference/remotion-effects-reference.md)

| 프롬프트 | 설명 | 구현 참고 |
|---------|------|----------|
| `텍스트 페이드아웃` | 서서히 사라짐 | [text-animations.md](text-animations.md) |
| `텍스트 슬라이드아웃` | 화면 밖으로 밀려남 | [text-animations.md](text-animations.md) |
| `텍스트 스케일아웃` | 커지면서 투명해짐 | [text-animations.md](text-animations.md) |
| `텍스트 블러아웃` | 흐려지면서 사라짐 | [text-animations.md](text-animations.md) |
| `텍스트 스크램블 아웃` | 랜덤 글자로 해체되며 사라짐 | [text-animations.md](text-animations.md) |
| `텍스트 글리치 아웃` | 왜곡되며 사라짐 | [text-animations.md](text-animations.md) |

---

## 5. 타이포그래피 스타일 (Typography Style)

> 텍스트의 배치와 표현 스타일입니다. 메인 메시지에는 대형 임팩트/볼드 스테이트먼트, 정보 전달에는 에디토리얼/리스트, 마무리에는 CTA 텍스트를 추천합니다.
> 상세: [reference](../reference/remotion-effects-reference.md)

| 프롬프트 | 설명 | 구현 참고 |
|---------|------|----------|
| `대형 임팩트 텍스트` | 화면 70%+ 차지하는 거대 텍스트 | [fonts.md](fonts.md) |
| `센터 타이틀 + 부제` | 중앙 큰 텍스트 + 아래 작은 텍스트 | [fonts.md](fonts.md) |
| `사이드 타이틀` | 한쪽에 치우친 텍스트 | [fonts.md](fonts.md) |
| `에디토리얼 스타일` | 매거진 느낌 (큰 숫자 + 소제목) | [fonts.md](fonts.md) |
| `키네틱 타이포` | 텍스트가 움직이며 내용 전달 | [text-animations.md](text-animations.md) |
| `미니멀 캡션` | 작고 절제된 자막 | [fonts.md](fonts.md) |
| `볼드 스테이트먼트` | 화면 꽉 채우는 한 줄 | [fonts.md](fonts.md) |
| `따옴표 인용` | 인용구 스타일 | [fonts.md](fonts.md) |
| `리스트/불릿` | 항목별 순차 등장 리스트 | [text-animations.md](text-animations.md) |
| `비교 텍스트 (vs)` | 좌우 대비 텍스트 | [fonts.md](fonts.md) |
| `가격 강조` | 큰 숫자 + 작은 단위 | [text-animations.md](text-animations.md) |
| `CTA 텍스트` | 행동 유도 (크고 명확) | [fonts.md](fonts.md) |
| `자막 스타일` | 하단 고정 자막 | [display-captions.md](display-captions.md) |
| `스크롤링 크레딧` | 위로 올라가는 크레딧 | [text-animations.md](text-animations.md) |
| `스타워즈 스크롤` | 원근감 있는 올라가는 텍스트 | [text-animations.md](text-animations.md) |

> **참고**: [Kinetic Typography Guide](https://www.ikagency.com/graphic-design-typography/kinetic-typography/) | [Top 25 Kinetic Typography Examples](https://www.b2w.tv/blog/kinetic-typography-animation-videos)

---

## 관련 Implementation Rules

| Rule | 용도 |
|------|------|
| [text-animations.md](text-animations.md) | 텍스트 애니메이션 구현 패턴 |
| [fonts.md](fonts.md) | Google Fonts / 로컬 폰트 로드 |
| [timing.md](timing.md) | 스프링, 이징 타이밍 |
| [display-captions.md](display-captions.md) | 자막 표시 |
| [measuring-text.md](measuring-text.md) | 텍스트 크기 측정, 오버플로 체크 |

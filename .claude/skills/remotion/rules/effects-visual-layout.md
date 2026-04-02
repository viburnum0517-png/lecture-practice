---
name: effects-visual-layout
description: Use when needing image, background, layout, overlay, shape and color effects catalog for Remotion
metadata:
  tags: catalog, image, background, layout, overlay, shape, mask, color, filter
---

# Visual, Layout & Style Effects

> 이미지, 배경, 레이아웃, 오버레이, 도형/마스크, 컬러 프롬프트 레퍼런스

## 1. 이미지 등장 애니메이션

> 이미지가 화면에 나타나는 방식을 제어합니다. 자연스럽게는 페이드인, 역동적으로는 슬라이드/팝인, 드라마틱하게는 마스크 리빌을 추천합니다.
> 상세: [reference](../reference/remotion-effects-reference.md)

| 프롬프트 | 설명 | 구현 참고 |
|---------|------|----------|
| `이미지 페이드인` | 서서히 나타남 | [images.md](images.md) |
| `이미지 슬라이드인 (좌/우/상/하)` | 한쪽에서 밀고 들어옴 | [images.md](images.md) |
| `이미지 대각선 슬라이드` | 대각선 방향에서 들어옴 | [images.md](images.md) |
| `이미지 스케일업 등장` | 작은 상태에서 확대 | [images.md](images.md) |
| `이미지 팝인` | 스프링 바운스로 팝 등장 | [images.md](images.md) |
| `이미지 로테이션 등장` | 회전하면서 등장 | [images.md](images.md) |
| `이미지 3D 플립인` | 뒤집히면서 등장 | [images.md](images.md) |
| `이미지 마스크 리빌 (좌→우)` | 왼쪽부터 서서히 드러남 | [images.md](images.md) |
| `이미지 마스크 리빌 (상→하)` | 위부터 서서히 드러남 | [images.md](images.md) |
| `이미지 대각선 리빌` | 비스듬하게 드러남 | [images.md](images.md) |
| `이미지 서클 리빌` | 원형으로 펼쳐지며 드러남 | [images.md](images.md) |
| `이미지 아이리스 리빌` | 카메라 조리개처럼 열림 | [images.md](images.md) |
| `이미지 블러→선명` | 흐릿했다가 선명해짐 | [images.md](images.md) |
| `이미지 그레이스케일→컬러` | 흑백에서 컬러로 변환 | [images.md](images.md) |

> **참고**: [CSS Reveal Animations](https://freefrontend.com/css-reveal-animations/) | [Fancy CSS Reveal Effects](https://expensive.toys/blog/fancy-css-reveal-effects) | [Animating with Clip-Path](https://css-tricks.com/animating-with-clip-path/)

## 2. 이미지 루프/유지 효과

> 이미지가 화면에 머무는 동안의 움직임입니다. 다큐멘터리/사진에는 켄 번즈, 입체감에는 패럴랙스, 부드러운 유지에는 플로팅/호흡을 추천합니다.
> 상세: [reference](../reference/remotion-effects-reference.md)

| 프롬프트 | 설명 | 구현 참고 |
|---------|------|----------|
| `켄 번즈 줌인` | 천천히 확대 (다큐멘터리 스타일) | [images.md](images.md) |
| `켄 번즈 줌아웃` | 천천히 축소 | [images.md](images.md) |
| `켄 번즈 패닝 (좌→우)` | 천천히 수평 이동 | [images.md](images.md) |
| `켄 번즈 패닝 (우→좌)` | 반대 방향 수평 이동 | [images.md](images.md) |
| `켄 번즈 대각선` | 대각선으로 줌+이동 | [images.md](images.md) |
| `패럴랙스` | 배경/전경 다른 속도로 이동 | [animations.md](animations.md) |
| `2.5D 패럴랙스` | translateZ로 입체감 | [animations.md](animations.md) |
| `플로팅` | 위아래 살짝 떠다님 | [animations.md](animations.md) |
| `호흡 효과 (pulse)` | 주기적 살짝 확대/축소 | [animations.md](animations.md) |
| `느린 회전` | 계속 천천히 회전 | [animations.md](animations.md) |
| `틸트 시프트` | 미니어처처럼 위아래 블러 | [animations.md](animations.md) |
| `비네팅` | 가장자리 어두운 영화 느낌 | [animations.md](animations.md) |

> **참고**: [Ken Burns Effect CSS](https://www.kirupa.com/html5/ken_burns_effect_css.htm) | [CSS Parallax Effects](https://medium.com/@farihatulmaria/pure-css-parallax-effects-creating-depth-and-motion-without-a-single-line-of-javascript-f4ecc35c928e) | [43 CSS Parallax Effects](https://freefrontend.com/css-parallax/)

## 3. 이미지 슬라이드쇼 패턴

> 여러 이미지를 순차적으로 보여주는 패턴입니다. 심플하게는 순차 풀스크린, 세련되게는 크로스페이드, 역동적으로는 스크롤 벨트를 추천합니다.
> 상세: [reference](../reference/remotion-effects-reference.md)

| 프롬프트 | 설명 | 구현 참고 |
|---------|------|----------|
| `순차 풀스크린 슬라이드쇼` | 한 장씩 풀스크린 교체 | [sequencing.md](sequencing.md) |
| `크로스페이드 슬라이드쇼` | 이미지 간 디졸브 전환 | [transitions.md](transitions.md) |
| `수평 스크롤 벨트` | 이미지가 옆으로 스크롤 | [animations.md](animations.md) |
| `수직 스크롤 벨트` | 이미지가 위로 스크롤 | [animations.md](animations.md) |
| `2열 반대방향 스크롤` | 위/아래 열이 반대로 흐름 | [animations.md](animations.md) |
| `무한 스크롤` | 이미지가 끝없이 반복 | [animations.md](animations.md) |
| `그리드 등장` | 여러 이미지가 그리드로 하나씩 | [animations.md](animations.md) |
| `카드 스택` | 카드가 쌓이듯 하나씩 올라옴 | [animations.md](animations.md) |
| `카드 팬 (부채꼴)` | 부채꼴로 펼쳐짐 | [animations.md](animations.md) |
| `폴라로이드 스택` | 기울어진 사진 스택 | [animations.md](animations.md) |
| `매거진 레이아웃` | 잡지처럼 다양한 크기 배치 | [animations.md](animations.md) |
| `카루셀 (회전목마)` | 3D 회전 갤러리 | [3d.md](3d.md) |
| `헥사곤 그리드` | 육각형 패턴 등장 | [animations.md](animations.md) |
| `메이슨리 그리드` | Pinterest 스타일 배치 | [animations.md](animations.md) |

---

## 4. 배경 효과 (Background)

> 씬의 분위기를 결정하는 배경 효과입니다. 모던한 느낌에는 그라데이션, 테크 분위기에는 파티클, 럭셔리에는 글로우/보케를 추천합니다.
> 상세: [reference](../reference/remotion-effects-reference.md)

| 프롬프트 | 설명 | 구현 참고 |
|---------|------|----------|
| `단색 배경` | 단일 색상 | [animations.md](animations.md) |
| `선형 그라데이션 배경` | 직선 방향 그라데이션 | [animations.md](animations.md) |
| `라디얼 그라데이션 배경` | 원형 퍼지는 그라데이션 | [animations.md](animations.md) |
| `코닉 그라데이션 배경` | 원뿔형(시계방향) 그라데이션 | [animations.md](animations.md) |
| `호흡하는 배경` | 그라데이션 중심이 느리게 움직임 | [animations.md](animations.md) |
| `그라데이션 컬러 애니메이션` | 색상이 서서히 변화 | [animations.md](animations.md) |
| `글로우 백라이트` | 오브젝트 뒤에 빛나는 광원 | [animations.md](animations.md) |
| `글로우 백라이트 펄스` | 주기적으로 밝기 변화 | [animations.md](animations.md) |
| `파티클 배경` | 떠다니는 작은 점들 | [animations.md](animations.md) |
| `별 반짝이는 배경` | 반짝이는 점들 랜덤 등장 | [animations.md](animations.md) |
| `눈 내리는 배경` | 위에서 떨어지는 파티클 | [animations.md](animations.md) |
| `보케 배경` | 렌즈 보케 (큰 원형 빛) | [animations.md](animations.md) |
| `연기/안개 배경` | 흐르는 안개 효과 | [animations.md](animations.md) |
| `노이즈 텍스처 배경` | 미세한 노이즈 오버레이 | [animations.md](animations.md) |
| `그리드 라인 배경` | 격자 패턴 | [animations.md](animations.md) |
| `웨이브 배경` | 물결치는 곡선 | [animations.md](animations.md) |
| `이미지 블러 배경` | 이미지를 블러 처리 배경 | [images.md](images.md) |
| `영상 블러 배경` | 영상을 블러 처리 배경 | [videos.md](videos.md) |
| `블롭 배경` | 유기적 형태가 천천히 변형 | [animations.md](animations.md) |
| `메쉬 그라데이션 배경` | 여러 색상이 자연스럽게 섞임 | [animations.md](animations.md) |
| `오로라 배경` | 극광처럼 물결치는 빛 | [animations.md](animations.md) |
| `매트릭스 코드 배경` | 코드가 떨어지는 효과 | [animations.md](animations.md) |

> **참고**: [CSS Animated Gradient Examples](https://www.sliderrevolution.com/resources/css-animated-gradient/) | [We Can Finally Animate CSS Gradient](https://dev.to/afif/we-can-finally-animate-css-gradient-kdk) | [tsParticles](https://particles.js.org/) | [Pure CSS Blob Animation](https://dev.to/prahalad/pure-css-blob-animation-no-svg-no-js-2f4m)

---

## 5. 레이아웃 (Layout)

> 화면의 구조와 요소 배치를 정합니다. 핵심 메시지에는 가운데 정렬, 비교에는 스플릿, 제품 소개에는 디바이스 프레임을 추천합니다.
> 상세: [reference](../reference/remotion-effects-reference.md)

| 프롬프트 | 설명 | 구현 참고 |
|---------|------|----------|
| `가운데 정렬` | 모든 요소 화면 중앙 | [animations.md](animations.md) |
| `좌측 타이틀 / 우측 이미지` | 수평 분할 | [animations.md](animations.md) |
| `상단 타이틀 / 하단 이미지` | 수직 분할 | [animations.md](animations.md) |
| `풀스크린 이미지 + 텍스트 오버레이` | 이미지 위에 텍스트 | [images.md](images.md) |
| `로어 서드 (하단 1/3)` | 화면 하단 정보 바 | [animations.md](animations.md) |
| `사이드바 레이아웃` | 한쪽 고정 + 나머지 콘텐츠 | [animations.md](animations.md) |
| `스플릿 50:50` | 화면 반반 | [animations.md](animations.md) |
| `스플릿 30:70` | 비대칭 분할 | [animations.md](animations.md) |
| `3단 분할` | 화면 3등분 | [animations.md](animations.md) |
| `4분할 그리드` | 화면 4등분 | [animations.md](animations.md) |
| `에디토리얼 넘버링` | 01, 02, 03 큰 숫자 + 소제목 | [text-animations.md](text-animations.md) |
| `디바이스 프레임 (폰)` | 폰 프레임 안 스크린샷 | [images.md](images.md) |
| `디바이스 프레임 (노트북)` | 노트북 프레임 | [images.md](images.md) |
| `디바이스 프레임 (브라우저)` | 브라우저 창 프레임 | [images.md](images.md) |
| `글래스모피즘 카드` | 유리 질감 반투명 카드 | [animations.md](animations.md) |
| `네오모피즘 카드` | 부드러운 음영 카드 | [animations.md](animations.md) |
| `플로팅 카드` | 그림자와 함께 떠있는 카드 | [animations.md](animations.md) |
| `비포/애프터 (좌우)` | 변경 전후 비교 | [animations.md](animations.md) |
| `비포/애프터 (슬라이더)` | 드래그 슬라이더로 비교 | [animations.md](animations.md) |

> **참고**: [CSS Glassmorphism](https://freefrontend.com/css-glassmorphism/) | [Frosted Glass Effect](https://www.joshwcomeau.com/css/backdrop-filter/)

---

## 6. 오버레이/필터 (Overlay & Filter)

> 영상 위에 덧씌우는 후처리 효과입니다. 영화 느낌에는 비네팅/필름 그레인, 가독성에는 그라데이션 오버레이, 진행 표시에는 프로그레스 바를 추천합니다.
> 상세: [reference](../reference/remotion-effects-reference.md)

| 프롬프트 | 설명 | 구현 참고 |
|---------|------|----------|
| `비네팅` | 가장자리 어둡게 | [animations.md](animations.md) |
| `상단→하단 그라데이션` | 위가 어두움 | [animations.md](animations.md) |
| `하단→상단 그라데이션` | 아래가 어두움 (텍스트 가독성) | [animations.md](animations.md) |
| `전체 어둡게` | 반투명 검정 오버레이 | [animations.md](animations.md) |
| `전체 밝게` | 반투명 흰색 오버레이 | [animations.md](animations.md) |
| `색상 틴트` | 특정 색상 오버레이 | [animations.md](animations.md) |
| `필름 그레인` | 영화 필름 노이즈 | [animations.md](animations.md) |
| `스캔라인` | CRT 모니터 줄무늬 | [animations.md](animations.md) |
| `크로마틱 어버레이션` | RGB 색수차 | [animations.md](animations.md) |
| `블룸/글로우` | 밝은 부분 번짐 | [animations.md](animations.md) |
| `프로그레스 바` | 영상 진행률 바 | [animations.md](animations.md) |
| `타이머/카운터` | 시간 표시 | [text-animations.md](text-animations.md) |
| `워터마크` | 반투명 로고/텍스트 | [images.md](images.md) |
| `라운드 코너 마스크` | 둥근 모서리 | [animations.md](animations.md) |
| `프레임/보더` | 장식 테두리 | [animations.md](animations.md) |

> **참고**: [CSS Filter Effects (MDN)](https://developer.mozilla.org/en-US/docs/Web/CSS/filter) | [CSS Film Grain](https://redstapler.co/css-film-grain-effect/)

---

## 7. 도형/마스크 (Shape & Mask)

> 도형과 마스크를 활용한 리빌/모프 효과입니다. 기본 드러남에는 원형/사각형, 창의적 드러남에는 SVG 패스, 형태 변화에는 블롭/쉐이프 모프를 추천합니다.
> 상세: [reference](../reference/remotion-effects-reference.md)

| 프롬프트 | 설명 | 구현 참고 |
|---------|------|----------|
| `원형 리빌` | 원이 커지며 드러남 | [animations.md](animations.md) |
| `사각형 리빌` | 사각형이 열리며 드러남 | [animations.md](animations.md) |
| `다이아몬드 리빌` | 마름모 열림 | [animations.md](animations.md) |
| `삼각형 리빌` | 삼각형 마스크 | [animations.md](animations.md) |
| `별 리빌` | 별 모양 마스크 | [animations.md](animations.md) |
| `하트 리빌` | 하트 모양 마스크 | [animations.md](animations.md) |
| `커스텀 SVG 패스 리빌` | 자유 곡선 마스크 | [animations.md](animations.md) |
| `스포트라이트` | 원형 비네트 리빌 | [animations.md](animations.md) |
| `그라데이션 마스크` | 투명도 그라데이션 마스크 | [animations.md](animations.md) |
| `노이즈 마스크` | 노이즈 기반 마스크 | [animations.md](animations.md) |
| `블롭 모프` | 유기적 형태 변형 | [animations.md](animations.md) |
| `쉐이프 모프` | 한 도형→다른 도형 변환 | [animations.md](animations.md) |
| `SVG 패스 드로잉` | 선이 그려지는 애니메이션 | [animations.md](animations.md) |

> **참고**: [Clippy - CSS clip-path Maker](https://bennettfeely.com/clippy/) | [SVG Shape Morphing](https://css-tricks.com/svg-shape-morphing-works/) | [MorphSVG Plugin](https://gsap.com/docs/v3/Plugins/MorphSVGPlugin/) | [SVG Line Animation](https://css-tricks.com/svg-line-animation-works/)

---

## 8. 컬러/톤 프리셋 (Color Presets)

> 전체 영상의 색감과 분위기를 한 번에 설정하는 프리셋입니다. 프로페셔널에는 시네마틱/다크 모드, 트렌디에는 사이버펑크/네온, 클린에는 미니멀/라이트 모드를 추천합니다.
> 상세: [reference](../reference/remotion-effects-reference.md)

| 프롬프트 | 설명 |
|---------|------|
| `다크 모드` | #000 배경, 흰 텍스트 |
| `라이트 모드` | #FFF 배경, 검정 텍스트 |
| `시네마틱 (다크 블루)` | 영화 같은 어두운 블루 |
| `럭셔리 (블랙+골드)` | 검정+금색 |
| `네온 (블랙+형광)` | 검정+네온 컬러 |
| `사이버펑크` | 핑크+시안+퍼플 |
| `레트로/빈티지` | 따뜻한 세피아 톤 |
| `파스텔` | 부드러운 파스텔 |
| `모노크롬` | 단일 색상 계열 |
| `듀오톤` | 두 색상만 |
| `하이콘트라스트` | 강한 명암 |
| `미니멀` | 최소 색상, 많은 여백 |
| `글래시` | 유리 질감 + 블러 |
| `브루탈리즘` | 강렬 색상 + 굵은 타이포 |

---

## 관련 Implementation Rules

| Rule | 용도 |
|------|------|
| [images.md](images.md) | 이미지 Img 컴포넌트, 로드 |
| [animations.md](animations.md) | 기본 애니메이션 패턴 |
| [transitions.md](transitions.md) | TransitionSeries 전환 |
| [videos.md](videos.md) | 비디오 임베딩 |
| [3d.md](3d.md) | Three.js 3D 콘텐츠 |
| [tailwind.md](tailwind.md) | TailwindCSS 스타일링 |

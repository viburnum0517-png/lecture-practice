---
name: remotion-effects-reference
description: Use when needing remotion 이펙트 프롬프트 종합 레퍼런스
---

# Remotion 이펙트 프롬프트 종합 레퍼런스

> 모든 효과를 프롬프트로 정리 + 참고 문서/예시 링크 연결
> "이 효과 넣어줘"로 바로 구현 가능한 메뉴판

---

## 1. 씬 전환 (Scene Transitions)

### @remotion/transitions 빌트인

| 프롬프트 | 설명 | 옵션 |
|---|---|---|
| `페이드 전환` | 두 씬이 겹치며 투명도 교차 | shouldFadeOutExitingScene |
| `슬라이드 전환` | 다음 씬이 밀고 들어옴 | from-left / from-right / from-top / from-bottom |
| `와이프 전환` | 다음 씬이 위에 덮으며 등장 | 8방향: from-left, from-top-left, from-top 등 |
| `플립 전환` | 3D 카드 뒤집기 | from-left / from-right / from-top / from-bottom + perspective |
| `클락와이프 전환` | 시계 바늘처럼 원형으로 닦아냄 | width, height 필수 |
| `아이리스 전환` | 원형 마스크가 펼쳐지며 다음 씬 노출 | width, height 필수 (v4.0.316+) |
| `큐브 전환` | 3D 큐브 회전 | direction + perspective (유료) |
| `none 전환` | 빈 전환 — useTransitionProgress()로 커스텀 | v4.0.177+ |

> **참고**: [fade()](https://www.remotion.dev/docs/transitions/presentations/fade) | [slide()](https://www.remotion.dev/docs/transitions/presentations/slide) | [wipe()](https://www.remotion.dev/docs/transitions/presentations/wipe) | [flip()](https://www.remotion.dev/docs/transitions/presentations/flip) | [clockWipe()](https://www.remotion.dev/docs/transitions/presentations/clock-wipe) | [iris()](https://www.remotion.dev/docs/transitions/presentations/iris) | [cube()](https://www.remotion.dev/docs/transitions/presentations/cube) | [none()](https://www.remotion.dev/docs/transitions/presentations/none)

### 타이밍 함수

| 프롬프트 | 설명 | 옵션 |
|---|---|---|
| `리니어 타이밍` | 일정 속도 전환 | durationInFrames, easing |
| `스프링 타이밍` | 물리 기반 탄성 전환 | config (damping, stiffness, mass), durationRestThreshold |
| `커스텀 타이밍` | 직접 만든 타이밍 곡선 | getDurationInFrames + getProgress 구현 |

> **참고**: [linearTiming()](https://www.remotion.dev/docs/transitions/timings/lineartiming) | [springTiming()](https://www.remotion.dev/docs/transitions/timings/springtiming) | [Custom Timings](https://www.remotion.dev/docs/transitions/timings/custom)

### CSS로 구현 가능한 크리에이티브 전환

| 프롬프트 | 설명 |
|---|---|
| `화이트 플래시 컷` | 흰 화면 번쩍 후 다음 씬 |
| `블랙 플래시 컷` | 검정 화면 번쩍 후 다음 씬 |
| `페이드 스루 블랙` | 검정으로 녹았다가 다시 나타남 |
| `페이드 스루 화이트` | 흰색으로 녹았다가 다시 나타남 |
| `대각선 와이프` | 비스듬한 선으로 닦아냄 |
| `다이아몬드 와이프` | 마름모 모양으로 열림 |
| `베네시안 블라인드` | 수평/수직 줄무늬로 조각조각 전환 |
| `줌 블러 전환` | 빠르게 줌인하며 블러로 전환 |
| `위팬 전환` | 빠른 수평 패닝으로 다음 씬 |
| `스핀 전환` | 화면이 회전하며 다음 씬 |
| `글리치 전환` | 디지털 오류 느낌으로 전환 |
| `픽셀화 전환` | 모자이크로 깨졌다가 다음 씬 |
| `노이즈 디졸브` | 노이즈 패턴으로 녹아듦 |
| `리플 전환` | 수면 파문처럼 퍼지며 전환 |
| `페이지 컬` | 종이 넘기듯 말려 올라감 |
| `접기(Fold) 전환` | 종이접기처럼 접히며 전환 |
| `잉크 번짐 전환` | 잉크가 퍼지듯 다음 씬 노출 |
| `리퀴드 전환` | 유체처럼 흘러내리며 전환 |
| `라이트 릭 전환` | 빛이 새어 들어오며 전환 |
| `필름 번 전환` | 필름이 타는 듯한 이펙트 전환 |
| `VHS 글리치 전환` | 아날로그 테이프 왜곡 전환 |
| `프리즘 전환` | 빛 굴절 효과 전환 |
| `만화경(칼레이도스코프) 전환` | 거울 패턴으로 전환 |
| `스플릿 스크린 전환` | 화면 분할 후 전환 |

> **참고**: [CSS Page Transitions 50 Examples](https://www.sliderrevolution.com/resources/css-page-transitions/) | [Types of Film Transitions (Adobe)](https://www.adobe.com/creativecloud/video/discover/types-of-film-transitions.html) | [35+ Cool CSS Page Transitions](https://devsnap.me/css-page-transitions) | [Custom Presentations API](https://www.remotion.dev/docs/transitions/presentations/custom)

---

## 2. 텍스트 효과 (Text Effects)

### 등장 애니메이션

| 프롬프트 | 설명 |
|---|---|
| `텍스트 페이드인` | 투명→불투명으로 서서히 등장 |
| `텍스트 스케일업 등장` | 작은 상태에서 커지며 등장 |
| `텍스트 스케일다운 등장` | 큰 상태에서 줄어들며 등장 |
| `텍스트 슬라이드업` | 아래에서 위로 올라옴 |
| `텍스트 슬라이드다운` | 위에서 아래로 내려옴 |
| `텍스트 슬라이드 좌→우` | 왼쪽에서 밀고 들어옴 |
| `텍스트 슬라이드 우→좌` | 오른쪽에서 밀고 들어옴 |
| `텍스트 바운스 등장` | 통통 튀듯 등장 |
| `텍스트 스프링 등장` | 오버슈트 후 제자리 (스프링 물리) |
| `텍스트 엘라스틱 등장` | 고무줄처럼 탄성 있게 등장 |
| `텍스트 블러→선명` | 흐릿했다가 선명해지며 등장 |
| `텍스트 레터스페이싱 좁혀지기` | 글자 간격이 넓었다가 좁혀짐 |
| `텍스트 로테이션 등장` | 회전하면서 등장 |
| `텍스트 3D 플립 등장` | 3D 뒤집기로 등장 |
| `텍스트 마스크 리빌` | 사각형 마스크가 열리면서 노출 |
| `텍스트 클립패스 리빌` | clip-path가 변형되며 노출 |
| `텍스트 커튼 리빌` | 커튼이 열리듯 양쪽으로 벌어지며 노출 |

> **참고**: [Remotion Animating Properties](https://www.remotion.dev/docs/animating-properties) | [interpolate()](https://www.remotion.dev/docs/interpolate) | [spring()](https://www.remotion.dev/docs/spring)

### 글자/단어별 애니메이션

| 프롬프트 | 설명 |
|---|---|
| `타자기 효과` | 한 글자씩 타이핑되듯 등장 |
| `글자별 순차 등장` | 각 글자가 시차를 두고 하나씩 |
| `단어별 순차 등장` | 각 단어가 시차를 두고 하나씩 |
| `줄별 순차 등장` | 각 줄이 시차를 두고 하나씩 |
| `글자별 웨이브` | 글자가 파도처럼 위아래로 |
| `글자별 바운스` | 각 글자가 개별적으로 바운스 |
| `글자별 회전` | 각 글자가 독립적으로 회전 |
| `단어별 회전` | 각 단어가 회전하며 등장 |
| `글자별 3D 플립` | 각 글자가 3D로 뒤집히며 등장 |
| `글자별 플로팅` | 글자들이 각각 둥둥 떠다님 |
| `텍스트 셔플/스크램블` | 랜덤 글자가 돌다가 최종 텍스트로 고정 |
| `스플릿 플랩 (공항 안내판)` | 공항 출발 안내판처럼 글자가 뒤집힘 |
| `오도미터 (숫자 롤링)` | 숫자가 위아래로 굴러가며 변환 |

> **참고**: [remotion-animate-text](https://github.com/pskd73/remotion-animate-text) | [Making Stagger Reveal Animations](https://tympanus.net/codrops/2020/06/17/making-stagger-reveal-animations-for-text/) | [CSS Text Animations 40 Examples](https://prismic.io/blog/css-text-animations)

### 텍스트 스타일 효과

| 프롬프트 | 설명 |
|---|---|
| `글로우 텍스트` | 텍스트 주변 빛나는 후광 |
| `네온 텍스트` | 네온사인처럼 빛남 |
| `네온 깜빡임` | 네온이 불규칙하게 깜빡임 |
| `그라데이션 텍스트` | 텍스트에 색상 그라데이션 |
| `그라데이션 애니메이션 텍스트` | 그라데이션이 움직임 |
| `크롬/메탈릭 텍스트` | 금속 질감 반사 그라데이션 |
| `골드 텍스트` | 금색 그라데이션 + 광택 |
| `홀로그래픽 텍스트` | 무지개빛으로 변하는 텍스트 |
| `아웃라인 텍스트` | 속 빈 외곽선만 있는 텍스트 |
| `아웃라인 드로잉 텍스트` | SVG로 외곽선이 그려지는 효과 |
| `3D 입체 텍스트` | 그림자 레이어로 입체감 |
| `글리치 텍스트` | 디지털 글리치 (위치/색상 떨림) |
| `크로마틱 어버레이션 텍스트` | RGB 채널 분리 |
| `하이라이트 효과` | 형광펜으로 칠한 듯한 배경 |
| `밑줄 애니메이션` | 밑줄이 좌→우로 그려짐 |
| `쉬머/샤인 스윕` | 빛 그라데이션이 텍스트 위를 지나감 |
| `타이핑 커서` | 깜빡이는 커서 표시 |
| `카운트업 숫자` | 0에서 목표값까지 올라감 |
| `카운트다운 숫자` | 목표값에서 0까지 내려감 |

> **참고**: [CSS Neon Text](https://css-tricks.com/how-to-create-neon-text-with-css/) | [SVG Text Drawing Animation](https://dev.to/0shuvo0/css-text-drawing-animation-with-svg-4nkk) | [CSS Glitch Effects](https://css-tricks.com/glitch-effect-text-images-svg/) | [Animating Number Counters](https://css-tricks.com/animating-number-counters/)

### 퇴장 애니메이션

| 프롬프트 | 설명 |
|---|---|
| `텍스트 페이드아웃` | 서서히 사라짐 |
| `텍스트 슬라이드아웃` | 화면 밖으로 밀려남 |
| `텍스트 스케일아웃` | 커지면서 투명해짐 |
| `텍스트 블러아웃` | 흐려지면서 사라짐 |
| `텍스트 스크램블 아웃` | 랜덤 글자로 해체되며 사라짐 |
| `텍스트 글리치 아웃` | 왜곡되며 사라짐 |

---

## 3. 이미지 효과 (Image Effects)

### 등장 애니메이션

| 프롬프트 | 설명 |
|---|---|
| `이미지 페이드인` | 서서히 나타남 |
| `이미지 슬라이드인 (좌/우/상/하)` | 한쪽에서 밀고 들어옴 |
| `이미지 대각선 슬라이드` | 대각선 방향에서 들어옴 |
| `이미지 스케일업 등장` | 작은 상태에서 확대 |
| `이미지 팝인` | 스프링 바운스로 팝 등장 |
| `이미지 로테이션 등장` | 회전하면서 등장 |
| `이미지 3D 플립인` | 뒤집히면서 등장 |
| `이미지 마스크 리빌 (좌→우)` | 왼쪽부터 서서히 드러남 |
| `이미지 마스크 리빌 (상→하)` | 위부터 서서히 드러남 |
| `이미지 대각선 리빌` | 비스듬하게 드러남 |
| `이미지 서클 리빌` | 원형으로 펼쳐지며 드러남 |
| `이미지 아이리스 리빌` | 카메라 조리개처럼 열림 |
| `이미지 블러→선명` | 흐릿했다가 선명해짐 |
| `이미지 그레이스케일→컬러` | 흑백에서 컬러로 변환 |

> **참고**: [CSS Reveal Animations](https://freefrontend.com/css-reveal-animations/) | [Fancy CSS Reveal Effects](https://expensive.toys/blog/fancy-css-reveal-effects) | [Animating with Clip-Path](https://css-tricks.com/animating-with-clip-path/)

### 루프/유지 효과

| 프롬프트 | 설명 |
|---|---|
| `켄 번즈 줌인` | 천천히 확대 (다큐멘터리 스타일) |
| `켄 번즈 줌아웃` | 천천히 축소 |
| `켄 번즈 패닝 (좌→우)` | 천천히 수평 이동 |
| `켄 번즈 패닝 (우→좌)` | 반대 방향 수평 이동 |
| `켄 번즈 대각선` | 대각선으로 줌+이동 |
| `패럴랙스` | 배경/전경 다른 속도로 이동 |
| `2.5D 패럴랙스` | translateZ로 입체감 |
| `플로팅` | 위아래 살짝 떠다님 |
| `호흡 효과 (pulse)` | 주기적 살짝 확대/축소 |
| `느린 회전` | 계속 천천히 회전 |
| `틸트 시프트` | 미니어처처럼 위아래 블러 |
| `비네팅` | 가장자리 어두운 영화 느낌 |

> **참고**: [Ken Burns Effect CSS](https://www.kirupa.com/html5/ken_burns_effect_css.htm) | [CSS Parallax Effects](https://medium.com/@farihatulmaria/pure-css-parallax-effects-creating-depth-and-motion-without-a-single-line-of-javascript-f4ecc35c928e) | [43 CSS Parallax Effects](https://freefrontend.com/css-parallax/)

### 슬라이드쇼 패턴

| 프롬프트 | 설명 |
|---|---|
| `순차 풀스크린 슬라이드쇼` | 한 장씩 풀스크린 교체 |
| `크로스페이드 슬라이드쇼` | 이미지 간 디졸브 전환 |
| `수평 스크롤 벨트` | 이미지가 옆으로 스크롤 |
| `수직 스크롤 벨트` | 이미지가 위로 스크롤 |
| `2열 반대방향 스크롤` | 위/아래 열이 반대로 흐름 |
| `무한 스크롤` | 이미지가 끝없이 반복 |
| `그리드 등장` | 여러 이미지가 그리드로 하나씩 |
| `카드 스택` | 카드가 쌓이듯 하나씩 올라옴 |
| `카드 팬 (부채꼴)` | 부채꼴로 펼쳐짐 |
| `폴라로이드 스택` | 기울어진 사진 스택 |
| `매거진 레이아웃` | 잡지처럼 다양한 크기 배치 |
| `카루셀 (회전목마)` | 3D 회전 갤러리 |
| `헥사곤 그리드` | 육각형 패턴 등장 |
| `메이슨리 그리드` | Pinterest 스타일 배치 |

---

## 4. 영상 효과 (Video Effects)

| 프롬프트 | 설명 |
|---|---|
| `풀스크린 비디오` | 화면 전체 꽉 채움 |
| `블러 배경 + 센터 비디오` | 블러 배경에 원본 가운데 배치 |
| `세로→가로 변환` | 세로 영상을 가로 프레임에 블러배경과 함께 |
| `PIP (화면 속 화면)` | 한쪽 구석에 작은 영상 |
| `스플릿 스크린 (좌우)` | 반으로 나눠 두 영상 |
| `스플릿 스크린 (상하)` | 위아래로 나눠 두 영상 |
| `디바이스 프레임 안 영상` | 폰/노트북 프레임 안 재생 |
| `비디오 페이드인` | 서서히 나타남 |
| `비디오 줌인 등장` | 작은 화면에서 풀스크린으로 |
| `비디오 마스크 리빌` | 원형/사각형 마스크로 노출 |
| `슬로우모션` | 느린 재생 |
| `빨리감기` | 빠른 재생 |
| `영상 루프` | 짧은 영상 반복 재생 |
| `영상 역재생` | 거꾸로 재생 |
| `영상 위 텍스트 오버레이` | 영상 위에 텍스트 표시 |
| `영상 위 하단 그라데이션 + 텍스트` | 가독성 확보 후 자막 |
| `영상 그레이스케일→컬러` | 흑백에서 컬러로 전환 |

> **참고**: [Remotion OffthreadVideo](https://www.remotion.dev/docs/offthreadvideo) | [Remotion Video Tag](https://www.remotion.dev/docs/video)

---

## 5. 배경 효과 (Background)

| 프롬프트 | 설명 |
|---|---|
| `단색 배경` | 단일 색상 |
| `선형 그라데이션 배경` | 직선 방향 그라데이션 |
| `라디얼 그라데이션 배경` | 원형 퍼지는 그라데이션 |
| `코닉 그라데이션 배경` | 원뿔형(시계방향) 그라데이션 |
| `호흡하는 배경` | 그라데이션 중심이 느리게 움직임 |
| `그라데이션 컬러 애니메이션` | 색상이 서서히 변화 |
| `글로우 백라이트` | 오브젝트 뒤에 빛나는 광원 |
| `글로우 백라이트 펄스` | 주기적으로 밝기 변화 |
| `파티클 배경` | 떠다니는 작은 점들 |
| `별 반짝이는 배경` | 반짝이는 점들 랜덤 등장 |
| `눈 내리는 배경` | 위에서 떨어지는 파티클 |
| `보케 배경` | 렌즈 보케 (큰 원형 빛) |
| `연기/안개 배경` | 흐르는 안개 효과 |
| `노이즈 텍스처 배경` | 미세한 노이즈 오버레이 |
| `그리드 라인 배경` | 격자 패턴 |
| `웨이브 배경` | 물결치는 곡선 |
| `이미지 블러 배경` | 이미지를 블러 처리 배경 |
| `영상 블러 배경` | 영상을 블러 처리 배경 |
| `블롭 배경` | 유기적 형태가 천천히 변형 |
| `메쉬 그라데이션 배경` | 여러 색상이 자연스럽게 섞임 |
| `오로라 배경` | 극광처럼 물결치는 빛 |
| `매트릭스 코드 배경` | 코드가 떨어지는 효과 |

> **참고**: [CSS Animated Gradient Examples](https://www.sliderrevolution.com/resources/css-animated-gradient/) | [We Can Finally Animate CSS Gradient](https://dev.to/afif/we-can-finally-animate-css-gradient-kdk) | [tsParticles](https://particles.js.org/) | [Pure CSS Blob Animation](https://dev.to/prahalad/pure-css-blob-animation-no-svg-no-js-2f4m)

---

## 6. 레이아웃 (Layout)

| 프롬프트 | 설명 |
|---|---|
| `가운데 정렬` | 모든 요소 화면 중앙 |
| `좌측 타이틀 / 우측 이미지` | 수평 분할 |
| `상단 타이틀 / 하단 이미지` | 수직 분할 |
| `풀스크린 이미지 + 텍스트 오버레이` | 이미지 위에 텍스트 |
| `로어 서드 (하단 1/3)` | 화면 하단 정보 바 |
| `사이드바 레이아웃` | 한쪽 고정 + 나머지 콘텐츠 |
| `스플릿 50:50` | 화면 반반 |
| `스플릿 30:70` | 비대칭 분할 |
| `3단 분할` | 화면 3등분 |
| `4분할 그리드` | 화면 4등분 |
| `에디토리얼 넘버링` | 01, 02, 03 큰 숫자 + 소제목 |
| `디바이스 프레임 (폰)` | 폰 프레임 안 스크린샷 |
| `디바이스 프레임 (노트북)` | 노트북 프레임 |
| `디바이스 프레임 (브라우저)` | 브라우저 창 프레임 |
| `글래스모피즘 카드` | 유리 질감 반투명 카드 |
| `네오모피즘 카드` | 부드러운 음영 카드 |
| `플로팅 카드` | 그림자와 함께 떠있는 카드 |
| `비포/애프터 (좌우)` | 변경 전후 비교 |
| `비포/애프터 (슬라이더)` | 드래그 슬라이더로 비교 |

> **참고**: [CSS Glassmorphism](https://freefrontend.com/css-glassmorphism/) | [Frosted Glass Effect](https://www.joshwcomeau.com/css/backdrop-filter/)

---

## 7. 모션/애니메이션 (Motion)

### 스프링 & 이징

| 프롬프트 | 설명 |
|---|---|
| `스프링 (기본)` | 표준 탄성 |
| `스프링 (빠르고 딱딱)` | 적은 바운스, 빠른 정착 |
| `스프링 (느리고 부드러움)` | 큰 바운스, 느린 정착 |
| `스프링 (럭셔리)` | 높은 댐핑, 우아한 감속 |
| `스프링 (스냅)` | 찰칵 붙는 느낌 |
| `이지인 (가속)` | 느리게→빠르게 |
| `이지아웃 (감속)` | 빠르게→느리게 |
| `이지인아웃` | 느리게→빠르게→느리게 |
| `리니어` | 일정 속도 |
| `커스텀 베지어` | 세밀 조절 곡선 |

> **참고**: [Remotion spring()](https://www.remotion.dev/docs/spring) | [Remotion Easing](https://www.remotion.dev/docs/easing) | [Springs and Bounces in CSS](https://www.joshwcomeau.com/animation/linear-timing-function/)

### 그룹 애니메이션

| 프롬프트 | 설명 |
|---|---|
| `스태거드 등장` | 여러 요소 시차 순차 등장 |
| `웨이브 등장` | 파도처럼 순차 올라옴 |
| `도미노 등장` | 차례로 넘어지듯 등장 |
| `레이어드 리빌` | opacity→translateY→scale 순차 |
| `캐스케이드 등장` | 폭포처럼 위에서 차례로 떨어짐 |
| `리플 등장` | 중심에서 동심원으로 퍼지며 등장 |

> **참고**: [Staggered Animations in CSS](https://css-tricks.com/different-approaches-for-creating-a-staggered-animation/)

### 루프/반복 모션

| 프롬프트 | 설명 |
|---|---|
| `루프 애니메이션` | 계속 반복 |
| `요요 (왔다갔다)` | 양방향 반복 |
| `쉐이크 (흔들림)` | 짧은 흔들림 |
| `펄스 (맥박)` | 주기적 확대/축소 |
| `위글 (흔들흔들)` | -3°~3° 회전 반복 |
| `젤로 (탄성 흔들림)` | 탄성 있는 기울기 반복 |
| `오비탈 (궤도 회전)` | 원형 궤도 따라 회전 |
| `타이핑 커서 깜빡임` | 주기적 깜빡임 |

> **참고**: [Animate.css](https://animate.style/) | [CSShake](https://elrumordelaluz.github.io/csshake/)

---

## 8. 오버레이/필터 (Overlay & Filter)

| 프롬프트 | 설명 |
|---|---|
| `비네팅` | 가장자리 어둡게 |
| `상단→하단 그라데이션` | 위가 어두움 |
| `하단→상단 그라데이션` | 아래가 어두움 (텍스트 가독성) |
| `전체 어둡게` | 반투명 검정 오버레이 |
| `전체 밝게` | 반투명 흰색 오버레이 |
| `색상 틴트` | 특정 색상 오버레이 |
| `필름 그레인` | 영화 필름 노이즈 |
| `스캔라인` | CRT 모니터 줄무늬 |
| `크로마틱 어버레이션` | RGB 색수차 |
| `블룸/글로우` | 밝은 부분 번짐 |
| `프로그레스 바` | 영상 진행률 바 |
| `타이머/카운터` | 시간 표시 |
| `워터마크` | 반투명 로고/텍스트 |
| `라운드 코너 마스크` | 둥근 모서리 |
| `프레임/보더` | 장식 테두리 |

> **참고**: [CSS Filter Effects (MDN)](https://developer.mozilla.org/en-US/docs/Web/CSS/filter) | [CSS Film Grain](https://redstapler.co/css-film-grain-effect/)

---

## 9. 카메라 무브먼트 (Camera Movement)

| 프롬프트 | 설명 |
|---|---|
| `카메라 줌인` | 전체 씬이 특정 지점으로 확대 |
| `카메라 줌아웃` | 전체 씬이 축소되며 전체 노출 |
| `카메라 패닝 (좌→우)` | 수평 이동 |
| `카메라 패닝 (우→좌)` | 반대 수평 이동 |
| `카메라 틸트 (상→하)` | 수직 이동 |
| `카메라 돌리` | 전후방 이동 |
| `카메라 아크 (원형)` | 원형으로 피사체 주위 이동 |
| `카메라 쉐이크` | 전체 화면 흔들림 |
| `핸드헬드 시뮬레이션` | 손떨림 느낌 |
| `돌리 줌 (버티고)` | 줌+돌리 반대 방향 (현기증) |
| `랙 포커스` | 초점이 전경↔배경으로 이동 |
| `모션 블러` | 빠른 이동 시 잔상 |
| `스피드 라인` | 빠른 이동 표현 선 |

> **참고**: [7 Basic Camera Movements](https://yelzkizi.org/7-basic-camera-movements/) | [Camera Movements: Pan, Tilt, Zoom](https://fiveable.me/cinematography/unit-5)

---

## 10. 파티클/제너러티브 (Particle & Generative)

| 프롬프트 | 설명 |
|---|---|
| `비 효과` | 떨어지는 빗줄기 |
| `눈 효과` | 떨어지는 눈송이 + 바람 |
| `먼지 파티클` | 떠다니는 작은 먼지 |
| `안개/연기` | 흐르는 연기 파티클 |
| `불꽃/화염` | 불 파티클 시스템 |
| `불꽃 튀기` | 스파크 파티클 |
| `잔불 (엠버)` | 둥둥 떠다니는 불씨 |
| `컨페티 (종이조각)` | 축하 종이 조각 |
| `불꽃놀이` | 폭발 + 떨어지는 불꽃 |
| `별 반짝임` | 랜덤 반짝이는 별 |
| `거품/버블` | 떠오르는 거품 |
| `파티클 네트워크` | 연결된 점들 그물 |
| `파티클 스웜` | 군집 이동하는 파티클 |
| `보케 파티클` | 큰 원형 빛 파티클 |
| `오로라` | 물결치는 빛 리본 |
| `코스틱 (빛 굴절)` | 물속 빛 굴절 패턴 |

> **참고**: [tsParticles](https://particles.js.org/) | [canvas-confetti](https://github.com/catdad/canvas-confetti) | [Effects Library: Snow, Fire, Rain](https://github.com/GetStream/effects-library)

---

## 11. 도형/마스크 (Shape & Mask)

| 프롬프트 | 설명 |
|---|---|
| `원형 리빌` | 원이 커지며 드러남 |
| `사각형 리빌` | 사각형이 열리며 드러남 |
| `다이아몬드 리빌` | 마름모 열림 |
| `삼각형 리빌` | 삼각형 마스크 |
| `별 리빌` | 별 모양 마스크 |
| `하트 리빌` | 하트 모양 마스크 |
| `커스텀 SVG 패스 리빌` | 자유 곡선 마스크 |
| `스포트라이트` | 원형 비네트 리빌 |
| `그라데이션 마스크` | 투명도 그라데이션 마스크 |
| `노이즈 마스크` | 노이즈 기반 마스크 |
| `블롭 모프` | 유기적 형태 변형 |
| `쉐이프 모프` | 한 도형→다른 도형 변환 |
| `SVG 패스 드로잉` | 선이 그려지는 애니메이션 |

> **참고**: [Clippy - CSS clip-path Maker](https://bennettfeely.com/clippy/) | [SVG Shape Morphing](https://css-tricks.com/svg-shape-morphing-works/) | [MorphSVG Plugin](https://gsap.com/docs/v3/Plugins/MorphSVGPlugin/) | [SVG Line Animation](https://css-tricks.com/svg-line-animation-works/)

---

## 12. 컬러/톤 프리셋 (Color Presets)

| 프롬프트 | 설명 |
|---|---|
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

## 13. 타이포그래피 스타일 (Typography Style)

| 프롬프트 | 설명 |
|---|---|
| `대형 임팩트 텍스트` | 화면 70%+ 차지하는 거대 텍스트 |
| `센터 타이틀 + 부제` | 중앙 큰 텍스트 + 아래 작은 텍스트 |
| `사이드 타이틀` | 한쪽에 치우친 텍스트 |
| `에디토리얼 스타일` | 매거진 느낌 (큰 숫자 + 소제목) |
| `키네틱 타이포` | 텍스트가 움직이며 내용 전달 |
| `미니멀 캡션` | 작고 절제된 자막 |
| `볼드 스테이트먼트` | 화면 꽉 채우는 한 줄 |
| `따옴표 인용` | 인용구 스타일 |
| `리스트/불릿` | 항목별 순차 등장 리스트 |
| `비교 텍스트 (vs)` | 좌우 대비 텍스트 |
| `가격 강조` | 큰 숫자 + 작은 단위 |
| `CTA 텍스트` | 행동 유도 (크고 명확) |
| `자막 스타일` | 하단 고정 자막 |
| `스크롤링 크레딧` | 위로 올라가는 크레딧 |
| `스타워즈 스크롤` | 원근감 있는 올라가는 텍스트 |

> **참고**: [Kinetic Typography Guide](https://www.ikagency.com/graphic-design-typography/kinetic-typography/) | [Top 25 Kinetic Typography Examples](https://www.b2w.tv/blog/kinetic-typography-animation-videos)

---

## 14. 인포그래픽 (Infographic)

| 프롬프트 | 설명 |
|---|---|
| `바 차트 애니메이션` | 막대 자라남 |
| `수평 바 차트` | 가로 막대 자라남 |
| `파이 차트 애니메이션` | 원형 차트 채워짐 |
| `도넛 차트 애니메이션` | 가운데 빈 원형 채워짐 |
| `라인 차트 드로잉` | 선이 그려짐 |
| `퍼센트 바` | 프로그레스 바 채워짐 |
| `서클 퍼센트` | 원형 프로그레스 채워짐 |
| `게이지/속도계` | 바늘이 움직이는 계기판 |
| `바 차트 레이스` | 랭킹 변화 애니메이션 |
| `타임라인 그래픽` | 시간순 이벤트 |
| `플로우차트` | 화살표 연결 프로세스 |
| `비교 테이블` | 항목 비교표 |
| `아이콘 + 수치` | 아이콘 옆 수치 |
| `워드클라우드` | 키워드 구름 |

---

## 15. 씬 템플릿 (Scene Templates)

| 프롬프트 | 설명 |
|---|---|
| `인트로 씬` | 로고 + 타이틀 등장 |
| `훅 씬 (이미지 플래시)` | 결과물 빠르게 번갈아 등장 |
| `가격/숫자 강조 씬` | 큰 숫자 + 부제 + 백라이트 |
| `스텝 바이 스텝 씬` | 01→02→03 순차 설명 |
| `비포/애프터 씬` | 전후 비교 |
| `풀스크린 영상 씬` | 영상 전체 화면 |
| `결과물 갤러리 씬` | 이미지 슬라이드쇼 |
| `인용/리뷰 씬` | 고객 후기 |
| `CTA 씬` | 행동 유도 + 마무리 |
| `아웃트로 씬` | 페이드아웃 + 로고 |
| `제품 소개 씬` | 제품 이미지 + 스펙 |
| `팀 소개 씬` | 프로필 + 이름/직함 |
| `Q&A 씬` | 질문 → 답변 |
| `통계/수치 씬` | 숫자 카운트업 + 차트 |
| `로딩/카운트다운 씬` | 카운트다운 + 트랜지션 |

---

## 16. 오디오 (Audio)

| 프롬프트 | 설명 |
|---|---|
| `BGM 삽입` | 배경 음악 |
| `BGM 페이드인` | 서서히 커짐 |
| `BGM 페이드아웃` | 서서히 작아짐 |
| `효과음 삽입` | 특정 시점 효과음 |
| `볼륨 조절` | 구간별 볼륨 |
| `음소거 구간` | 특정 구간 음소거 |
| `비트 싱크` | 음악 비트에 맞춘 컷 |

> **참고**: [Remotion Audio](https://www.remotion.dev/docs/audio) | [useAudioData()](https://www.remotion.dev/docs/use-audio-data)

---

## 17. 고급 효과 (Advanced)

| 프롬프트 | 설명 |
|---|---|
| `모프 트랜지션` | 요소가 위치/크기 변하며 전환 |
| `3D 회전` | CSS perspective 3D 회전 |
| `3D 카드 플립` | 카드 뒤집기 |
| `3D 큐브 회전` | 큐브 면 전환 |
| `마스크 애니메이션` | clip-path 도형 변형 |
| `SVG 패스 드로잉` | 선이 그려지는 애니메이션 |
| `로티 애니메이션` | Lottie JSON 임베딩 |
| `스크롤 시뮬레이션` | 웹페이지 스크롤 효과 |
| `데이터 드리븐 영상` | JSON/API 데이터 기반 동적 영상 |
| `반응형 레이아웃` | 해상도별 레이아웃 변경 |
| `웨이브 디스토션` | 물결 왜곡 |
| `리퀴드 이펙트` | 유체 변형 |
| `이소메트릭 3D` | 등각 투영 3D |

> **참고**: [3D Transforms Intro](https://3dtransforms.desandro.com/) | [CSS Perspective](https://css-tricks.com/how-css-perspective-works/) | [CSS Liquid Effects](https://freefrontend.com/css-liquid-effects/)

---

## 조합 레시피 (Combination Recipes)

실제 영상에서 바로 쓸 수 있는 효과 조합 프롬프트.

### 인트로/훅

> **"충격 훅"**: 결과물 4장 하드컷 + 화이트 플래시 + 비네팅 + 하단 그라데이션 + 볼드 스테이트먼트 슬라이드업

> **"시네마틱 인트로"**: 다크 모드 + 호흡하는 배경 + 로고 스프링 등장 + 글로우 백라이트 펄스 + 타이틀 레터스페이싱 좁혀지기

> **"네온 인트로"**: 블랙 배경 + 네온 텍스트 깜빡임 + SVG 패스 드로잉 + 파티클 배경

### 가격/숫자 강조

> **"가격 임팩트"**: 대형 임팩트 텍스트 스케일업 + 글로우 백라이트 펄스 + 부제 슬라이드업 + 호흡하는 배경

> **"카운트업 강조"**: 숫자 카운트업 + 서클 퍼센트 + 스태거드 등장 리스트

### 스텝 가이드

> **"에디토리얼 스텝"**: 에디토리얼 넘버링 (01/02/03) + 수직 레이아웃 + 디바이스 프레임 + 스태거드 이미지 등장 + 페이드 전환

> **"풀스크린 스텝"**: 스텝 타이틀 페이드인→페이드아웃 + 풀스크린 이미지 켄 번즈 줌인 + 하단 미니멀 캡션

### 영상 쇼케이스

> **"풀 비디오"**: 블러 배경 + 센터 비디오 풀 사이즈 + 좌상단 미니멀 캡션 + 페이드인 등장

> **"제품 영상"**: 디바이스 프레임(폰) + 비디오 줌인 등장 + 글로우 백라이트 + 하단 CTA 텍스트

### 갤러리/결과물

> **"심플 갤러리"**: 순차 풀스크린 슬라이드쇼 + 켄 번즈 줌인 + 하단 그라데이션 + 미니멀 캡션 + 카운터

> **"럭셔리 갤러리"**: 다크 모드 + 풀스크린 이미지 페이드인 + 비네팅 + 글로우 텍스트 라벨 + 호흡하는 배경

### CTA/마무리

> **"클린 CTA"**: 글로우 백라이트 펄스 + 대형 임팩트 텍스트 스프링 등장 + 부제 슬라이드업 + 페이드 투 블랙

> **"리치 CTA"**: 호흡하는 배경 + 아이콘 스프링 등장 + 그라데이션 텍스트 + 밑줄 애니메이션 + 컨페티

### 트렌딩 (2026)

> **"스피드 램프"**: 빨리감기→슬로우모션 + 줌 블러 전환 + 비트 싱크 + 크로마틱 어버레이션

> **"글리치 하이라이트"**: 글리치 전환 + 크로마틱 어버레이션 + VHS 스캔라인 + 네온 글로우

> **"3D 포토 이펙트"**: 2.5D 패럴랙스 + 카메라 줌인 + 렌즈 블러(랙 포커스) + 플로팅 파티클

> **"홀로그래픽"**: 홀로그래픽 텍스트 + 메쉬 그라데이션 + 블롭 모프 배경 + 쉬머 스윕

---

## 참고 자료 모음

### Remotion 공식

| 자료 | 링크 |
|---|---|
| @remotion/transitions 전체 | https://www.remotion.dev/docs/transitions/ |
| TransitionSeries | https://www.remotion.dev/docs/transitions/transitionseries |
| Presentations (전환 효과) | https://www.remotion.dev/docs/transitions/presentations |
| Timings (타이밍 함수) | https://www.remotion.dev/docs/transitions/timings/ |
| Custom Presentations | https://www.remotion.dev/docs/transitions/presentations/custom |
| interpolate() | https://www.remotion.dev/docs/interpolate |
| spring() | https://www.remotion.dev/docs/spring |
| Easing | https://www.remotion.dev/docs/easing |
| Animating Properties | https://www.remotion.dev/docs/animating-properties |
| OffthreadVideo | https://www.remotion.dev/docs/offthreadvideo |
| Audio | https://www.remotion.dev/docs/audio |
| Templates | https://www.remotion.dev/templates |
| Showcase | https://www.remotion.dev/showcase |
| Third Party | https://www.remotion.dev/docs/third-party |
| Resources | https://www.remotion.dev/docs/resources |

### 커뮤니티 라이브러리

| 라이브러리 | 용도 | 링크 |
|---|---|---|
| Remotion Animated | 선언적 애니메이션 | https://www.remotion-animated.dev/ |
| remotion-animate-text | 텍스트 글자/단어별 애니메이션 | https://github.com/pskd73/remotion-animate-text |
| remotion-transition-series | 전환 확장 | https://www.npmjs.com/package/remotion-transition-series |
| Remotion Templates (GitHub) | 무료 효과/템플릿 | https://github.com/reactvideoeditor/remotion-templates |

### CSS 애니메이션 레퍼런스

| 자료 | 링크 |
|---|---|
| Animate.css (애니메이션 라이브러리) | https://animate.style/ |
| CSShake (흔들림 효과 모음) | https://elrumordelaluz.github.io/csshake/ |
| Clippy (clip-path 생성기) | https://bennettfeely.com/clippy/ |
| CSS clip-path 애니메이션 | https://css-tricks.com/animating-with-clip-path/ |
| SVG 라인 애니메이션 | https://css-tricks.com/svg-line-animation-works/ |
| CSS 텍스트 애니메이션 40선 | https://prismic.io/blog/css-text-animations |
| CSS 페이지 전환 50선 | https://www.sliderrevolution.com/resources/css-page-transitions/ |
| CSS Reveal 애니메이션 | https://freefrontend.com/css-reveal-animations/ |
| Fancy CSS Reveal Effects | https://expensive.toys/blog/fancy-css-reveal-effects |
| 스태거 텍스트 애니메이션 | https://tympanus.net/codrops/2020/06/17/making-stagger-reveal-animations-for-text/ |
| CSS 글리치 효과 | https://css-tricks.com/glitch-effect-text-images-svg/ |
| CSS 네온 텍스트 | https://css-tricks.com/how-to-create-neon-text-with-css/ |
| CSS 그라데이션 애니메이션 | https://dev.to/afif/we-can-finally-animate-css-gradient-kdk |
| CSS 필름 그레인 | https://redstapler.co/css-film-grain-effect/ |
| CSS Glassmorphism | https://freefrontend.com/css-glassmorphism/ |
| CSS Liquid Effects | https://freefrontend.com/css-liquid-effects/ |
| CSS Parallax 43선 | https://freefrontend.com/css-parallax/ |
| SVG Shape Morphing | https://css-tricks.com/svg-shape-morphing-works/ |
| CSS 숫자 카운터 애니메이션 | https://css-tricks.com/animating-number-counters/ |
| CSS 타자기 효과 | https://css-tricks.com/snippets/css/typewriter-effect/ |

### 3D/고급 기법

| 자료 | 링크 |
|---|---|
| 3D Transforms 입문 | https://3dtransforms.desandro.com/ |
| CSS Perspective 가이드 | https://css-tricks.com/how-css-perspective-works/ |
| Frosted Glass (Josh Comeau) | https://www.joshwcomeau.com/css/backdrop-filter/ |
| Springs & Bounces (Josh Comeau) | https://www.joshwcomeau.com/animation/linear-timing-function/ |
| After Effects → CSS 변환 | https://www.smashingmagazine.com/2017/12/after-effects-css-transitions-keyframes/ |
| Ken Burns 효과 | https://www.kirupa.com/html5/ken_burns_effect_css.htm |

### JS 애니메이션 라이브러리

| 라이브러리 | 용도 | 링크 |
|---|---|---|
| GSAP | 타임라인 기반 애니메이션 | https://gsap.com/ |
| Framer Motion | React 선언적 애니메이션 | https://motion.dev/ |
| Anime.js | 경량 애니메이션 | https://animejs.com/ |
| tsParticles | 파티클 효과 | https://particles.js.org/ |
| canvas-confetti | 컨페티 효과 | https://github.com/catdad/canvas-confetti |

### 트렌드/영감

| 자료 | 링크 |
|---|---|
| 숏폼 비디오 마스터리 2026 | https://almcorp.com/blog/short-form-video-mastery-tiktok-reels-youtube-shorts-2026/ |
| 소셜 미디어 트렌드 2026 | https://www.adobe.com/express/learn/blog/2026-social-media-trends |
| 인스타 릴스 트렌드 2026 | https://www.socialpilot.co/blog/instagram-reels-trends |
| 키네틱 타이포그래피 가이드 | https://www.ikagency.com/graphic-design-typography/kinetic-typography/ |
| 영상 전환 유형 (Adobe) | https://www.adobe.com/creativecloud/video/discover/types-of-film-transitions.html |

---

*Remotion v4 기준 | 2026.02 | 총 350+ 프롬프트*

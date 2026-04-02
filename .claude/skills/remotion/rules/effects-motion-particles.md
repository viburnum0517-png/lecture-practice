---
name: effects-motion-particles
description: Use when needing motion, particle, audio and advanced effects catalog for Remotion
metadata:
  tags: catalog, motion, spring, easing, particles, audio, advanced, 3d
---

# Motion, Particles & Advanced Effects

> 모션/애니메이션, 파티클, 오디오, 고급 효과 프롬프트 레퍼런스

## 1. 스프링 & 이징 (Spring & Easing)

> 애니메이션의 속도 곡선을 결정합니다. 자연스러운 UI에는 스프링, 고급 느낌에는 이지인아웃, 기계적 느낌에는 리니어를 추천합니다.
> 상세: [reference](../reference/remotion-effects-reference.md)

| 프롬프트 | 설명 | 구현 참고 |
|---------|------|----------|
| `스프링 (기본)` | 표준 탄성 | [timing.md](timing.md) |
| `스프링 (빠르고 딱딱)` | 적은 바운스, 빠른 정착 | [timing.md](timing.md) |
| `스프링 (느리고 부드러움)` | 큰 바운스, 느린 정착 | [timing.md](timing.md) |
| `스프링 (럭셔리)` | 높은 댐핑, 우아한 감속 | [timing.md](timing.md) |
| `스프링 (스냅)` | 찰칵 붙는 느낌 | [timing.md](timing.md) |
| `이지인 (가속)` | 느리게→빠르게 | [timing.md](timing.md) |
| `이지아웃 (감속)` | 빠르게→느리게 | [timing.md](timing.md) |
| `이지인아웃` | 느리게→빠르게→느리게 | [timing.md](timing.md) |
| `리니어` | 일정 속도 | [timing.md](timing.md) |
| `커스텀 베지어` | 세밀 조절 곡선 | [timing.md](timing.md) |

> **참고**: [Remotion spring()](https://www.remotion.dev/docs/spring) | [Remotion Easing](https://www.remotion.dev/docs/easing) | [Springs and Bounces in CSS](https://www.joshwcomeau.com/animation/linear-timing-function/)

## 2. 그룹 애니메이션

> 여러 요소가 함께 움직이는 패턴입니다. 리스트에는 스태거드, 역동적 등장에는 웨이브, 중심 확산에는 리플을 추천합니다.
> 상세: [reference](../reference/remotion-effects-reference.md)

| 프롬프트 | 설명 | 구현 참고 |
|---------|------|----------|
| `스태거드 등장` | 여러 요소 시차 순차 등장 | [animations.md](animations.md) |
| `웨이브 등장` | 파도처럼 순차 올라옴 | [animations.md](animations.md) |
| `도미노 등장` | 차례로 넘어지듯 등장 | [animations.md](animations.md) |
| `레이어드 리빌` | opacity→translateY→scale 순차 | [animations.md](animations.md) |
| `캐스케이드 등장` | 폭포처럼 위에서 차례로 떨어짐 | [animations.md](animations.md) |
| `리플 등장` | 중심에서 동심원으로 퍼지며 등장 | [animations.md](animations.md) |

> **참고**: [Staggered Animations in CSS](https://css-tricks.com/different-approaches-for-creating-a-staggered-animation/)

## 3. 루프/반복 모션

> 지속적으로 반복되는 움직임입니다. 주의 환기에는 펄스/쉐이크, 장식에는 플로팅/위글, 귀여운 느낌에는 젤로를 추천합니다.
> 상세: [reference](../reference/remotion-effects-reference.md)

| 프롬프트 | 설명 | 구현 참고 |
|---------|------|----------|
| `루프 애니메이션` | 계속 반복 | [animations.md](animations.md) |
| `요요 (왔다갔다)` | 양방향 반복 | [animations.md](animations.md) |
| `쉐이크 (흔들림)` | 짧은 흔들림 | [animations.md](animations.md) |
| `펄스 (맥박)` | 주기적 확대/축소 | [animations.md](animations.md) |
| `위글 (흔들흔들)` | -3~3 회전 반복 | [animations.md](animations.md) |
| `젤로 (탄성 흔들림)` | 탄성 있는 기울기 반복 | [animations.md](animations.md) |
| `오비탈 (궤도 회전)` | 원형 궤도 따라 회전 | [animations.md](animations.md) |
| `타이핑 커서 깜빡임` | 주기적 깜빡임 | [animations.md](animations.md) |

> **참고**: [Animate.css](https://animate.style/) | [CSShake](https://elrumordelaluz.github.io/csshake/)

---

## 4. 파티클/제너러티브 (Particle & Generative)

> 자동 생성되는 파티클 효과입니다. 축하에는 컨페티/불꽃놀이, 자연 분위기에는 눈/비, 테크에는 파티클 네트워크를 추천합니다.
> 상세: [reference](../reference/remotion-effects-reference.md)

| 프롬프트 | 설명 | 구현 참고 |
|---------|------|----------|
| `비 효과` | 떨어지는 빗줄기 | [animations.md](animations.md) |
| `눈 효과` | 떨어지는 눈송이 + 바람 | [animations.md](animations.md) |
| `먼지 파티클` | 떠다니는 작은 먼지 | [animations.md](animations.md) |
| `안개/연기` | 흐르는 연기 파티클 | [animations.md](animations.md) |
| `불꽃/화염` | 불 파티클 시스템 | [animations.md](animations.md) |
| `불꽃 튀기` | 스파크 파티클 | [animations.md](animations.md) |
| `잔불 (엠버)` | 둥둥 떠다니는 불씨 | [animations.md](animations.md) |
| `컨페티 (종이조각)` | 축하 종이 조각 | [animations.md](animations.md) |
| `불꽃놀이` | 폭발 + 떨어지는 불꽃 | [animations.md](animations.md) |
| `별 반짝임` | 랜덤 반짝이는 별 | [animations.md](animations.md) |
| `거품/버블` | 떠오르는 거품 | [animations.md](animations.md) |
| `파티클 네트워크` | 연결된 점들 그물 | [animations.md](animations.md) |
| `파티클 스웜` | 군집 이동하는 파티클 | [animations.md](animations.md) |
| `보케 파티클` | 큰 원형 빛 파티클 | [animations.md](animations.md) |
| `오로라` | 물결치는 빛 리본 | [animations.md](animations.md) |
| `코스틱 (빛 굴절)` | 물속 빛 굴절 패턴 | [animations.md](animations.md) |

> **참고**: [tsParticles](https://particles.js.org/) | [canvas-confetti](https://github.com/catdad/canvas-confetti) | [Effects Library: Snow, Fire, Rain](https://github.com/GetStream/effects-library)

---

## 5. 오디오 (Audio)

> 영상의 청각적 요소를 제어합니다. 기본은 BGM + 페이드인/아웃, 강조 시점에는 효과음, 리듬 편집에는 비트 싱크를 추천합니다.
> 상세: [reference](../reference/remotion-effects-reference.md)

| 프롬프트 | 설명 | 구현 참고 |
|---------|------|----------|
| `BGM 삽입` | 배경 음악 | [audio.md](audio.md) |
| `BGM 페이드인` | 서서히 커짐 | [audio.md](audio.md) |
| `BGM 페이드아웃` | 서서히 작아짐 | [audio.md](audio.md) |
| `효과음 삽입` | 특정 시점 효과음 | [audio.md](audio.md) |
| `볼륨 조절` | 구간별 볼륨 | [audio.md](audio.md) |
| `음소거 구간` | 특정 구간 음소거 | [audio.md](audio.md) |
| `비트 싱크` | 음악 비트에 맞춘 컷 | [audio.md](audio.md) |

> **참고**: [Remotion Audio](https://www.remotion.dev/docs/audio) | [useAudioData()](https://www.remotion.dev/docs/use-audio-data)

---

## 6. 고급 효과 (Advanced)

> 기술적 난이도가 높은 고급 효과입니다. 입체감에는 3D 회전/큐브, 인터랙티브에는 스크롤 시뮬레이션, 데이터 기반에는 데이터 드리븐 영상을 추천합니다.
> 상세: [reference](../reference/remotion-effects-reference.md)

| 프롬프트 | 설명 | 구현 참고 |
|---------|------|----------|
| `모프 트랜지션` | 요소가 위치/크기 변하며 전환 | [animations.md](animations.md) |
| `3D 회전` | CSS perspective 3D 회전 | [3d.md](3d.md) |
| `3D 카드 플립` | 카드 뒤집기 | [3d.md](3d.md) |
| `3D 큐브 회전` | 큐브 면 전환 | [3d.md](3d.md) |
| `마스크 애니메이션` | clip-path 도형 변형 | [animations.md](animations.md) |
| `SVG 패스 드로잉` | 선이 그려지는 애니메이션 | [animations.md](animations.md) |
| `로티 애니메이션` | Lottie JSON 임베딩 | [lottie.md](lottie.md) |
| `스크롤 시뮬레이션` | 웹페이지 스크롤 효과 | [animations.md](animations.md) |
| `데이터 드리븐 영상` | JSON/API 데이터 기반 동적 영상 | [calculate-metadata.md](calculate-metadata.md) |
| `반응형 레이아웃` | 해상도별 레이아웃 변경 | [compositions.md](compositions.md) |
| `웨이브 디스토션` | 물결 왜곡 | [animations.md](animations.md) |
| `리퀴드 이펙트` | 유체 변형 | [animations.md](animations.md) |
| `이소메트릭 3D` | 등각 투영 3D | [3d.md](3d.md) |

> **참고**: [3D Transforms Intro](https://3dtransforms.desandro.com/) | [CSS Perspective](https://css-tricks.com/how-css-perspective-works/) | [CSS Liquid Effects](https://freefrontend.com/css-liquid-effects/)

---

## 관련 Implementation Rules

| Rule | 용도 |
|------|------|
| [timing.md](timing.md) | Spring, Easing, interpolate 곡선 |
| [animations.md](animations.md) | 기본 애니메이션 패턴 |
| [audio.md](audio.md) | 오디오 임포트, 볼륨, 속도 |
| [3d.md](3d.md) | Three.js, React Three Fiber |
| [lottie.md](lottie.md) | Lottie 애니메이션 임베딩 |
| [calculate-metadata.md](calculate-metadata.md) | 동적 메타데이터 |
| [compositions.md](compositions.md) | 컴포지션 정의 |

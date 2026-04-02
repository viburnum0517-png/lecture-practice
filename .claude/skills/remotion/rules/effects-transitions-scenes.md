---
name: effects-transitions-scenes
description: Use when needing scene transitions, video effects, and camera movement catalog for Remotion
metadata:
  tags: catalog, transitions, video, camera, scene
---

# Scene Transitions, Video & Camera Effects

> 씬 전환, 영상 효과, 카메라 무브먼트 프롬프트 레퍼런스

## 1. 씬 전환 (Scene Transitions)

> 두 씬 사이를 자연스럽게 연결하는 효과입니다. 자연스러운 전환은 페이드, 역동적인 전환은 슬라이드/와이프, 극적인 전환은 플래시를 추천합니다.
> 상세: [reference](../reference/remotion-effects-reference.md)

### @remotion/transitions 빌트인

| 프롬프트 | 설명 | 옵션 | 구현 참고 |
|---------|------|------|----------|
| `페이드 전환` | 두 씬이 겹치며 투명도 교차 | shouldFadeOutExitingScene | [transitions.md](transitions.md) |
| `슬라이드 전환` | 다음 씬이 밀고 들어옴 | from-left / from-right / from-top / from-bottom | [transitions.md](transitions.md) |
| `와이프 전환` | 다음 씬이 위에 덮으며 등장 | 8방향: from-left, from-top-left, from-top 등 | [transitions.md](transitions.md) |
| `플립 전환` | 3D 카드 뒤집기 | from-left / from-right / from-top / from-bottom + perspective | [transitions.md](transitions.md) |
| `클락와이프 전환` | 시계 바늘처럼 원형으로 닦아냄 | width, height 필수 | [transitions.md](transitions.md) |
| `아이리스 전환` | 원형 마스크가 펼쳐지며 다음 씬 노출 | width, height 필수 (v4.0.316+) | [transitions.md](transitions.md) |
| `큐브 전환` | 3D 큐브 회전 | direction + perspective (유료) | [transitions.md](transitions.md) |
| `none 전환` | 빈 전환 — useTransitionProgress()로 커스텀 | v4.0.177+ | [transitions.md](transitions.md) |

> **참고**: [fade()](https://www.remotion.dev/docs/transitions/presentations/fade) | [slide()](https://www.remotion.dev/docs/transitions/presentations/slide) | [wipe()](https://www.remotion.dev/docs/transitions/presentations/wipe) | [flip()](https://www.remotion.dev/docs/transitions/presentations/flip) | [clockWipe()](https://www.remotion.dev/docs/transitions/presentations/clock-wipe) | [iris()](https://www.remotion.dev/docs/transitions/presentations/iris) | [cube()](https://www.remotion.dev/docs/transitions/presentations/cube) | [none()](https://www.remotion.dev/docs/transitions/presentations/none)

### 타이밍 함수

| 프롬프트 | 설명 | 옵션 | 구현 참고 |
|---------|------|------|----------|
| `리니어 타이밍` | 일정 속도 전환 | durationInFrames, easing | [timing.md](timing.md) |
| `스프링 타이밍` | 물리 기반 탄성 전환 | config (damping, stiffness, mass), durationRestThreshold | [timing.md](timing.md) |
| `커스텀 타이밍` | 직접 만든 타이밍 곡선 | getDurationInFrames + getProgress 구현 | [timing.md](timing.md) |

> **참고**: [linearTiming()](https://www.remotion.dev/docs/transitions/timings/lineartiming) | [springTiming()](https://www.remotion.dev/docs/transitions/timings/springtiming) | [Custom Timings](https://www.remotion.dev/docs/transitions/timings/custom)

### CSS 크리에이티브 전환

| 프롬프트 | 설명 | 구현 참고 |
|---------|------|----------|
| `화이트 플래시 컷` | 흰 화면 번쩍 후 다음 씬 | [transitions.md](transitions.md) |
| `블랙 플래시 컷` | 검정 화면 번쩍 후 다음 씬 | [transitions.md](transitions.md) |
| `페이드 스루 블랙` | 검정으로 녹았다가 다시 나타남 | [transitions.md](transitions.md) |
| `페이드 스루 화이트` | 흰색으로 녹았다가 다시 나타남 | [transitions.md](transitions.md) |
| `대각선 와이프` | 비스듬한 선으로 닦아냄 | [animations.md](animations.md) |
| `다이아몬드 와이프` | 마름모 모양으로 열림 | [animations.md](animations.md) |
| `베네시안 블라인드` | 수평/수직 줄무늬로 조각조각 전환 | [animations.md](animations.md) |
| `줌 블러 전환` | 빠르게 줌인하며 블러로 전환 | [animations.md](animations.md) |
| `위팬 전환` | 빠른 수평 패닝으로 다음 씬 | [animations.md](animations.md) |
| `스핀 전환` | 화면이 회전하며 다음 씬 | [animations.md](animations.md) |
| `글리치 전환` | 디지털 오류 느낌으로 전환 | [animations.md](animations.md) |
| `픽셀화 전환` | 모자이크로 깨졌다가 다음 씬 | [animations.md](animations.md) |
| `노이즈 디졸브` | 노이즈 패턴으로 녹아듦 | [animations.md](animations.md) |
| `리플 전환` | 수면 파문처럼 퍼지며 전환 | [animations.md](animations.md) |
| `페이지 컬` | 종이 넘기듯 말려 올라감 | [animations.md](animations.md) |
| `접기(Fold) 전환` | 종이접기처럼 접히며 전환 | [animations.md](animations.md) |
| `잉크 번짐 전환` | 잉크가 퍼지듯 다음 씬 노출 | [animations.md](animations.md) |
| `리퀴드 전환` | 유체처럼 흘러내리며 전환 | [animations.md](animations.md) |
| `라이트 릭 전환` | 빛이 새어 들어오며 전환 | [animations.md](animations.md) |
| `필름 번 전환` | 필름이 타는 듯한 이펙트 전환 | [animations.md](animations.md) |
| `VHS 글리치 전환` | 아날로그 테이프 왜곡 전환 | [animations.md](animations.md) |
| `프리즘 전환` | 빛 굴절 효과 전환 | [animations.md](animations.md) |
| `만화경(칼레이도스코프) 전환` | 거울 패턴으로 전환 | [animations.md](animations.md) |
| `스플릿 스크린 전환` | 화면 분할 후 전환 | [animations.md](animations.md) |

> **참고**: [CSS Page Transitions 50 Examples](https://www.sliderrevolution.com/resources/css-page-transitions/) | [Types of Film Transitions (Adobe)](https://www.adobe.com/creativecloud/video/discover/types-of-film-transitions.html) | [35+ Cool CSS Page Transitions](https://devsnap.me/css-page-transitions) | [Custom Presentations API](https://www.remotion.dev/docs/transitions/presentations/custom)

---

## 2. 영상 효과 (Video Effects)

> 영상의 배치, 속도 조절, 필터 적용을 다룹니다. PIP, 스플릿 스크린, 디바이스 프레임 등 다양한 레이아웃을 지원합니다.
> 상세: [reference](../reference/remotion-effects-reference.md)

| 프롬프트 | 설명 | 구현 참고 |
|---------|------|----------|
| `풀스크린 비디오` | 화면 전체 꽉 채움 | [videos.md](videos.md) |
| `블러 배경 + 센터 비디오` | 블러 배경에 원본 가운데 배치 | [videos.md](videos.md) |
| `세로→가로 변환` | 세로 영상을 가로 프레임에 블러배경과 함께 | [videos.md](videos.md) |
| `PIP (화면 속 화면)` | 한쪽 구석에 작은 영상 | [videos.md](videos.md) |
| `스플릿 스크린 (좌우)` | 반으로 나눠 두 영상 | [videos.md](videos.md) |
| `스플릿 스크린 (상하)` | 위아래로 나눠 두 영상 | [videos.md](videos.md) |
| `디바이스 프레임 안 영상` | 폰/노트북 프레임 안 재생 | [videos.md](videos.md) |
| `비디오 페이드인` | 서서히 나타남 | [videos.md](videos.md) |
| `비디오 줌인 등장` | 작은 화면에서 풀스크린으로 | [videos.md](videos.md) |
| `비디오 마스크 리빌` | 원형/사각형 마스크로 노출 | [videos.md](videos.md) |
| `슬로우모션` | 느린 재생 | [videos.md](videos.md) |
| `빨리감기` | 빠른 재생 | [videos.md](videos.md) |
| `영상 루프` | 짧은 영상 반복 재생 | [videos.md](videos.md) |
| `영상 역재생` | 거꾸로 재생 | [videos.md](videos.md) |
| `영상 위 텍스트 오버레이` | 영상 위에 텍스트 표시 | [videos.md](videos.md) |
| `영상 위 하단 그라데이션 + 텍스트` | 가독성 확보 후 자막 | [videos.md](videos.md) |
| `영상 그레이스케일→컬러` | 흑백에서 컬러로 전환 | [videos.md](videos.md) |

> **참고**: [Remotion OffthreadVideo](https://www.remotion.dev/docs/offthreadvideo) | [Remotion Video Tag](https://www.remotion.dev/docs/video)

---

## 3. 카메라 무브먼트 (Camera Movement)

> 전체 씬 단위의 카메라 움직임을 시뮬레이션합니다. 강조 시 줌인, 전체 조망은 줌아웃, 긴장감은 카메라 쉐이크를 추천합니다.
> 상세: [reference](../reference/remotion-effects-reference.md)

| 프롬프트 | 설명 | 구현 참고 |
|---------|------|----------|
| `카메라 줌인` | 전체 씬이 특정 지점으로 확대 | [animations.md](animations.md) |
| `카메라 줌아웃` | 전체 씬이 축소되며 전체 노출 | [animations.md](animations.md) |
| `카메라 패닝 (좌→우)` | 수평 이동 | [animations.md](animations.md) |
| `카메라 패닝 (우→좌)` | 반대 수평 이동 | [animations.md](animations.md) |
| `카메라 틸트 (상→하)` | 수직 이동 | [animations.md](animations.md) |
| `카메라 돌리` | 전후방 이동 | [animations.md](animations.md) |
| `카메라 아크 (원형)` | 원형으로 피사체 주위 이동 | [animations.md](animations.md) |
| `카메라 쉐이크` | 전체 화면 흔들림 | [animations.md](animations.md) |
| `핸드헬드 시뮬레이션` | 손떨림 느낌 | [animations.md](animations.md) |
| `돌리 줌 (버티고)` | 줌+돌리 반대 방향 (현기증) | [animations.md](animations.md) |
| `랙 포커스` | 초점이 전경↔배경으로 이동 | [animations.md](animations.md) |
| `모션 블러` | 빠른 이동 시 잔상 | [animations.md](animations.md) |
| `스피드 라인` | 빠른 이동 표현 선 | [animations.md](animations.md) |

> **참고**: [7 Basic Camera Movements](https://yelzkizi.org/7-basic-camera-movements/) | [Camera Movements: Pan, Tilt, Zoom](https://fiveable.me/cinematography/unit-5)

---

## 관련 Implementation Rules

| Rule | 용도 |
|------|------|
| [transitions.md](transitions.md) | TransitionSeries, 빌트인 전환 구현 |
| [timing.md](timing.md) | Spring/Easing 타이밍 함수 |
| [videos.md](videos.md) | 비디오 임베딩, 트리밍, 속도 |
| [animations.md](animations.md) | 기본 애니메이션 패턴 |
| [sequencing.md](sequencing.md) | 시퀀스 지연, 트림, 지속시간 |

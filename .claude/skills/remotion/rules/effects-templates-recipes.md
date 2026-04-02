---
name: effects-templates-recipes
description: Use when needing scene templates, infographics, combination recipes and resource links for Remotion
metadata:
  tags: catalog, templates, recipes, infographic, scene, resources
---

# Templates, Infographics & Combination Recipes

> 씬 템플릿, 인포그래픽, 효과 조합 레시피, 참고 자료 레퍼런스

## 1. 인포그래픽 (Infographic)

> 데이터를 시각적으로 전달하는 차트와 그래프 애니메이션입니다. 비교에는 바 차트, 비율에는 파이/도넛, 트렌드에는 라인 차트를 추천합니다.
> 상세: [reference](../reference/remotion-effects-reference.md)

| 프롬프트 | 설명 | 구현 참고 |
|---------|------|----------|
| `바 차트 애니메이션` | 막대 자라남 | [charts.md](charts.md) |
| `수평 바 차트` | 가로 막대 자라남 | [charts.md](charts.md) |
| `파이 차트 애니메이션` | 원형 차트 채워짐 | [charts.md](charts.md) |
| `도넛 차트 애니메이션` | 가운데 빈 원형 채워짐 | [charts.md](charts.md) |
| `라인 차트 드로잉` | 선이 그려짐 | [charts.md](charts.md) |
| `퍼센트 바` | 프로그레스 바 채워짐 | [animations.md](animations.md) |
| `서클 퍼센트` | 원형 프로그레스 채워짐 | [animations.md](animations.md) |
| `게이지/속도계` | 바늘이 움직이는 계기판 | [animations.md](animations.md) |
| `바 차트 레이스` | 랭킹 변화 애니메이션 | [charts.md](charts.md) |
| `타임라인 그래픽` | 시간순 이벤트 | [animations.md](animations.md) |
| `플로우차트` | 화살표 연결 프로세스 | [animations.md](animations.md) |
| `비교 테이블` | 항목 비교표 | [animations.md](animations.md) |
| `아이콘 + 수치` | 아이콘 옆 수치 | [animations.md](animations.md) |
| `워드클라우드` | 키워드 구름 | [animations.md](animations.md) |

---

## 2. 씬 템플릿 (Scene Templates)

> 완성된 씬 단위의 레시피입니다. 시작에는 인트로/훅, 중간에는 스텝/비교, 마무리에는 CTA/아웃트로를 추천합니다.
> 상세: [reference](../reference/remotion-effects-reference.md)

| 프롬프트 | 설명 | 구현 참고 |
|---------|------|----------|
| `인트로 씬` | 로고 + 타이틀 등장 | [compositions.md](compositions.md) |
| `훅 씬 (이미지 플래시)` | 결과물 빠르게 번갈아 등장 | [sequencing.md](sequencing.md) |
| `가격/숫자 강조 씬` | 큰 숫자 + 부제 + 백라이트 | [text-animations.md](text-animations.md) |
| `스텝 바이 스텝 씬` | 01→02→03 순차 설명 | [sequencing.md](sequencing.md) |
| `비포/애프터 씬` | 전후 비교 | [animations.md](animations.md) |
| `풀스크린 영상 씬` | 영상 전체 화면 | [videos.md](videos.md) |
| `결과물 갤러리 씬` | 이미지 슬라이드쇼 | [images.md](images.md) |
| `인용/리뷰 씬` | 고객 후기 | [text-animations.md](text-animations.md) |
| `CTA 씬` | 행동 유도 + 마무리 | [text-animations.md](text-animations.md) |
| `아웃트로 씬` | 페이드아웃 + 로고 | [transitions.md](transitions.md) |
| `제품 소개 씬` | 제품 이미지 + 스펙 | [images.md](images.md) |
| `팀 소개 씬` | 프로필 + 이름/직함 | [images.md](images.md) |
| `Q&A 씬` | 질문 → 답변 | [text-animations.md](text-animations.md) |
| `통계/수치 씬` | 숫자 카운트업 + 차트 | [charts.md](charts.md) |
| `로딩/카운트다운 씬` | 카운트다운 + 트랜지션 | [text-animations.md](text-animations.md) |

---

## 3. 조합 레시피 (Combination Recipes)

> 실제 영상에서 바로 쓸 수 있는 효과 조합 프롬프트입니다. 각 레시피는 여러 효과를 조합하여 완성된 씬을 만들어냅니다.
> 상세: [reference](../reference/remotion-effects-reference.md)

### 인트로/훅

> **"충격 훅"**: 결과물 4장 하드컷 + 화이트 플래시 + 비네팅 + 하단 그라데이션 + 볼드 스테이트먼트 슬라이드업
> 추천 대상: 처음 3초에 시선을 잡아야 하는 광고/쇼츠

> **"시네마틱 인트로"**: 다크 모드 + 호흡하는 배경 + 로고 스프링 등장 + 글로우 백라이트 펄스 + 타이틀 레터스페이싱 좁혀지기
> 추천 대상: 브랜드 영상, 프리미엄 느낌의 오프닝

> **"네온 인트로"**: 블랙 배경 + 네온 텍스트 깜빡임 + SVG 패스 드로잉 + 파티클 배경
> 추천 대상: 테크/게임/나이트라이프 콘텐츠

### 가격/숫자 강조

> **"가격 임팩트"**: 대형 임팩트 텍스트 스케일업 + 글로우 백라이트 펄스 + 부제 슬라이드업 + 호흡하는 배경
> 추천 대상: 할인, 프로모션, 가격 강조 씬

> **"카운트업 강조"**: 숫자 카운트업 + 서클 퍼센트 + 스태거드 등장 리스트
> 추천 대상: 성과 발표, 통계 시각화

### 스텝 가이드

> **"에디토리얼 스텝"**: 에디토리얼 넘버링 (01/02/03) + 수직 레이아웃 + 디바이스 프레임 + 스태거드 이미지 등장 + 페이드 전환
> 추천 대상: 튜토리얼, 가이드 영상

> **"풀스크린 스텝"**: 스텝 타이틀 페이드인→페이드아웃 + 풀스크린 이미지 켄 번즈 줌인 + 하단 미니멀 캡션
> 추천 대상: 풍경/제품 중심 스텝 가이드

### 영상 쇼케이스

> **"풀 비디오"**: 블러 배경 + 센터 비디오 풀 사이즈 + 좌상단 미니멀 캡션 + 페이드인 등장
> 추천 대상: 제품 데모, 앱 워크스루

> **"제품 영상"**: 디바이스 프레임(폰) + 비디오 줌인 등장 + 글로우 백라이트 + 하단 CTA 텍스트
> 추천 대상: 앱/제품 소개 영상

### 갤러리/결과물

> **"심플 갤러리"**: 순차 풀스크린 슬라이드쇼 + 켄 번즈 줌인 + 하단 그라데이션 + 미니멀 캡션 + 카운터
> 추천 대상: 포트폴리오, 작업물 소개

> **"럭셔리 갤러리"**: 다크 모드 + 풀스크린 이미지 페이드인 + 비네팅 + 글로우 텍스트 라벨 + 호흡하는 배경
> 추천 대상: 하이엔드 브랜드, 럭셔리 제품

### CTA/마무리

> **"클린 CTA"**: 글로우 백라이트 펄스 + 대형 임팩트 텍스트 스프링 등장 + 부제 슬라이드업 + 페이드 투 블랙
> 추천 대상: 깔끔한 마무리, 행동 유도

> **"리치 CTA"**: 호흡하는 배경 + 아이콘 스프링 등장 + 그라데이션 텍스트 + 밑줄 애니메이션 + 컨페티
> 추천 대상: 이벤트, 캠페인 마무리

### 트렌딩 (2026)

> **"스피드 램프"**: 빨리감기→슬로우모션 + 줌 블러 전환 + 비트 싱크 + 크로마틱 어버레이션
> 추천 대상: 액션/스포츠/댄스 하이라이트

> **"글리치 하이라이트"**: 글리치 전환 + 크로마틱 어버레이션 + VHS 스캔라인 + 네온 글로우
> 추천 대상: 테크/사이버 콘텐츠

> **"3D 포토 이펙트"**: 2.5D 패럴랙스 + 카메라 줌인 + 렌즈 블러(랙 포커스) + 플로팅 파티클
> 추천 대상: 사진 기반 고급 연출

> **"홀로그래픽"**: 홀로그래픽 텍스트 + 메쉬 그라데이션 + 블롭 모프 배경 + 쉬머 스윕
> 추천 대상: 미래적/테크 브랜딩

---

## 4. 참고 자료 모음

### Remotion 공식

| 자료 | 링크 |
|------|------|
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
|-----------|------|------|
| Remotion Animated | 선언적 애니메이션 | https://www.remotion-animated.dev/ |
| remotion-animate-text | 텍스트 글자/단어별 애니메이션 | https://github.com/pskd73/remotion-animate-text |
| remotion-transition-series | 전환 확장 | https://www.npmjs.com/package/remotion-transition-series |
| Remotion Templates (GitHub) | 무료 효과/템플릿 | https://github.com/reactvideoeditor/remotion-templates |

### CSS 애니메이션 레퍼런스

| 자료 | 링크 |
|------|------|
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
|------|------|
| 3D Transforms 입문 | https://3dtransforms.desandro.com/ |
| CSS Perspective 가이드 | https://css-tricks.com/how-css-perspective-works/ |
| Frosted Glass (Josh Comeau) | https://www.joshwcomeau.com/css/backdrop-filter/ |
| Springs & Bounces (Josh Comeau) | https://www.joshwcomeau.com/animation/linear-timing-function/ |
| After Effects → CSS 변환 | https://www.smashingmagazine.com/2017/12/after-effects-css-transitions-keyframes/ |
| Ken Burns 효과 | https://www.kirupa.com/html5/ken_burns_effect_css.htm |

### JS 애니메이션 라이브러리

| 라이브러리 | 용도 | 링크 |
|-----------|------|------|
| GSAP | 타임라인 기반 애니메이션 | https://gsap.com/ |
| Framer Motion | React 선언적 애니메이션 | https://motion.dev/ |
| Anime.js | 경량 애니메이션 | https://animejs.com/ |
| tsParticles | 파티클 효과 | https://particles.js.org/ |
| canvas-confetti | 컨페티 효과 | https://github.com/catdad/canvas-confetti |

### 트렌드/영감

| 자료 | 링크 |
|------|------|
| 숏폼 비디오 마스터리 2026 | https://almcorp.com/blog/short-form-video-mastery-tiktok-reels-youtube-shorts-2026/ |
| 소셜 미디어 트렌드 2026 | https://www.adobe.com/express/learn/blog/2026-social-media-trends |
| 인스타 릴스 트렌드 2026 | https://www.socialpilot.co/blog/instagram-reels-trends |
| 키네틱 타이포그래피 가이드 | https://www.ikagency.com/graphic-design-typography/kinetic-typography/ |
| 영상 전환 유형 (Adobe) | https://www.adobe.com/creativecloud/video/discover/types-of-film-transitions.html |

---

*Remotion v4 기준 | 2026.02 | 총 350+ 프롬프트*

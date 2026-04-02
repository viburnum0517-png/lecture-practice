---
name: frontend-design
description: Use when creating distinctive, production-grade frontend interfaces with high design quality. Use this skill when the user asks to build web components, pages, artifacts, posters, or applications (examples include websites, landing pages, dashboards, React components, HTML/CSS layouts, or when styling/beautifying any web UI). Generates creative, polished code and UI design that avoids generic AI aesthetics.
license: Complete terms in LICENSE.txt
---

This skill guides creation of distinctive, production-grade frontend interfaces that avoid generic "AI slop" aesthetics. Implement real working code with exceptional attention to aesthetic details and creative choices.

The user provides frontend requirements: a component, page, application, or interface to build. They may include context about the purpose, audience, or technical constraints.

## Design Thinking

Before coding, understand the context and commit to a BOLD aesthetic direction:
- **Purpose**: What problem does this interface solve? Who uses it?
- **Tone**: Pick an extreme: brutally minimal, maximalist chaos, retro-futuristic, organic/natural, luxury/refined, playful/toy-like, editorial/magazine, brutalist/raw, art deco/geometric, soft/pastel, industrial/utilitarian, etc. There are so many flavors to choose from. Use these for inspiration but design one that is true to the aesthetic direction.
- **Constraints**: Technical requirements (framework, performance, accessibility).
- **Differentiation**: What makes this UNFORGETTABLE? What's the one thing someone will remember?

**CRITICAL**: Choose a clear conceptual direction and execute it with precision. Bold maximalism and refined minimalism both work - the key is intentionality, not intensity.

Then implement working code (HTML/CSS/JS, React, Vue, etc.) that is:
- Production-grade and functional
- Visually striking and memorable
- Cohesive with a clear aesthetic point-of-view
- Meticulously refined in every detail

## Frontend Aesthetics Guidelines

Focus on:
- **Typography**: Choose fonts that are beautiful, unique, and interesting. Avoid generic fonts like Arial and Inter; opt instead for distinctive choices that elevate the frontend's aesthetics; unexpected, characterful font choices. Pair a distinctive display font with a refined body font.
- **Color & Theme**: Commit to a cohesive aesthetic. Use CSS variables for consistency. Dominant colors with sharp accents outperform timid, evenly-distributed palettes. Use the **Color Keywords** below to avoid the "purple gradient default" trap.
- **Motion**: Use animations for effects and micro-interactions. Prioritize CSS-only solutions for HTML. Use Motion library for React when available. Focus on high-impact moments: one well-orchestrated page load with staggered reveals (animation-delay) creates more delight than scattered micro-interactions. Use scroll-triggering and hover states that surprise.
- **Spatial Composition**: Unexpected layouts. Asymmetry. Overlap. Diagonal flow. Grid-breaking elements. Generous negative space OR controlled density. Use the **Layout Keywords** below to drive distinctive spatial choices.
- **Backgrounds & Visual Details**: Create atmosphere and depth rather than defaulting to solid colors. Add contextual effects and textures that match the overall aesthetic. Apply creative forms like gradient meshes, noise textures, geometric patterns, layered transparencies, dramatic shadows, decorative borders, custom cursors, and grain overlays.

## Layout Keywords (Vibe Coding Cheat Sheet)

When choosing spatial composition, use these specific keywords to drive distinctive layouts. Combine them with **ratios** and **section names** for best results.

### Foundation Keywords
| Keyword | Effect | Example |
|---------|--------|---------|
| **BentoGrid** | Apple-style mixed-size card grid | `BentoGrid Features section` |
| **SplitScreen** | Unequal split (70/30, 60/40) | `SplitScreen 60/40 Hero` |
| **OffsetLayout** | Asymmetric columns (2fr 1fr) | `OffsetLayout content sidebar` |
| **OverlappingStack** | Z-index layered elements | `OverlappingStack testimonials` |
| **FullBleed** | Edge-to-edge section | `FullBleed hero image` |

### Advanced Keywords
| Keyword | Effect | Example |
|---------|--------|---------|
| **BrokenGrid** | Intentional asymmetry | `BrokenGrid portfolio` |
| **DiagonalGrid** | Diagonal element placement | `DiagonalGrid gallery` |
| **CollageLayout** | Magazine-style image/text collage | `CollageLayout about section` |

### Combination Formula
```
[Layout Keyword] + [Ratio (optional)] + [Section Name]
```

**Powerful combos:**
- `BentoGrid + OverlappingStack` → Features with depth
- `SplitScreen 60/40 + FullBleed` → Hero with immersive imagery
- `CollageLayout + DiagonalGrid` → Editorial/magazine feel
- `BrokenGrid + OffsetLayout` → Maximum visual tension

**CRITICAL**: Vague prompts like "make it pretty" produce generic results. Always specify layout keyword + ratio + section for distinctive output.

## Color Keywords (Anti-Purple Cheat Sheet)

AI defaults to purple gradients (Tailwind bias). Use these keywords to break free.

### Color Balance Rules
| Keyword | Effect | Example |
|---------|--------|---------|
| **60-30-10 Rule** | Background 60%, sub 30%, accent 10% | `"60-30-10 비율로 잡아줘"` |
| **Monochromatic** | Single hue, vary lightness/saturation | `"Monochromatic Blue"` |
| **Split-Complementary** | Colors adjacent to the complement | `"Split-Complementary from Teal"` |
| **Neutral + Accent** | Grayscale + one pop color | `"Neutral + Accent Orange"` |

### Color Restriction Keywords
| Prompt Pattern | Effect |
|----------------|--------|
| `"2색만 사용"` / `"Duotone"` | Force 2-color palette |
| `"배경은 Neutral Gray 계열"` | Lock background to grayscale |
| `"원 포인트 컬러, 배경 흑백"` | B&W + one accent |
| `"Monochromatic + Blue, Accent Orange 10% 이하"` | Precise control |

### Gradient Keywords
| Keyword | Effect |
|---------|--------|
| **GrainyGradient** | Noise texture, paper-like feel |
| **AuroraBackground** | Blurred color blobs |
| **MeshGradient** | Organic multi-color flow |
| **Subtle Gradient** | Gentle, understated transition |

**Gradient formula**: `[Gradient Keyword] + [Color A] → [Color B]` (e.g. `"GrainyGradient from Cream to Light Gray"`)

## Design System Principles (Vibe Coding Consistency)

To prevent inconsistent "rugby ball" results, apply these 4 principles:

1. **Information Architecture**: Pre-register all content (text hierarchy, media, data models, actual data) before prompting. Don't fetch materials during generation.
2. **Semantic Tokens**: Name colors/styles by role (`warning`, `primary`, `surface`) not by value (`#FF0000`). Reduces AI token waste and improves consistency.
3. **Component-Driven Thinking**: Define components by **shape** (tokens/variables) + **function** (properties/props). Design before coding.
4. **Lightweight Prompts**: With 1-3 in place, prompts become assembly instructions: `"Combine [data] + [component] → [section]"` instead of lengthy descriptions.

**Mantra**: Don't describe, assemble.

NEVER use generic AI-generated aesthetics like overused font families (Inter, Roboto, Arial, system fonts), cliched color schemes (particularly purple gradients on white backgrounds), predictable layouts and component patterns, and cookie-cutter design that lacks context-specific character.

Interpret creatively and make unexpected choices that feel genuinely designed for the context. No design should be the same. Vary between light and dark themes, different fonts, different aesthetics. NEVER converge on common choices (Space Grotesk, for example) across generations.

**IMPORTANT**: Match implementation complexity to the aesthetic vision. Maximalist designs need elaborate code with extensive animations and effects. Minimalist or refined designs need restraint, precision, and careful attention to spacing, typography, and subtle details. Elegance comes from executing the vision well.

Remember: Claude is capable of extraordinary creative work. Don't hold back, show what can truly be created when thinking outside the box and committing fully to a distinctive vision.

## Design Workflow (디자인 워크플로우)

프론트엔드 디자인 작업 시 반드시 따라야 할 5단계 워크플로우.
> Source: @lazylittleyoyo Claude Design Workflow

### 1. 격리 세션 (Isolated Session)
- 디자인 빌드/수정 작업은 **별도 세션**에서 수행
- 대화가 섞이거나 길어지면 품질 저하 → 새 세션 시작
- **전제조건**: plan이 문서(PLAN.md 등)로 먼저 작성되어 있어야 함
- 실행: `superpowers:using-git-worktrees` 또는 별도 Agent로 격리

### 2. 안티패턴 차단 (Anti-Pattern Blocking)
아래 패턴을 **명시적으로 금지**:

| 금지 패턴 | 대안 |
|-----------|------|
| 보라 그라데이션 (Purple Gradient) | Color Keywords 활용 (위 섹션 참조) |
| 균일 카드 그리드 (Uniform Card Grid) | BentoGrid, BrokenGrid, CollageLayout |
| 기본 폰트 (Inter, Arial, Roboto) | 맥락에 맞는 개성 있는 폰트 선택 |
| 동일한 카드 크기/간격 | 비대칭, 오버랩, 대각선 배치 |
| 기본 Tailwind 색상 | 60-30-10 Rule, Monochromatic 등 |

### 3. 3관점 리뷰 (Triple-Lens Review)
디자인 완성 후 3가지 관점에서 각각 검증:

| 관점 | 검증 기준 | 에이전트 역할 |
|------|----------|-------------|
| **시각 (Visual)** | 색상 조화, 타이포 위계, 여백 밸런스, 전체 인상 | "디자인 디렉터" |
| **사용성 (Usability)** | 클릭 영역, 정보 계층, 접근성, 반응형 | "UX 리서처" |
| **디테일 (Detail)** | 픽셀 정렬, 미세 간격, 호버 상태, 경계 케이스 | "QA 엔지니어" |

```
리뷰 실행 방법:
1. 각 관점별 Agent를 순차 또는 병렬로 실행
2. 각 에이전트는 스크린샷 기반으로 피드백
3. 피드백 통합 후 수정 사항 반영
```

### 4. TSX 직접 구현 (Direct TSX Implementation)
- HTML 목업이 아닌 **실제 프레임워크**(React/Vue/Svelte)로 구현
- 구현 갭(Implementation Gap) 제거 — 목업→코드 변환 단계 없음
- Vite + React + Tailwind가 기본 스택
- 컴포넌트 단위로 빌드, 페이지 단위로 조합

### 5. Playwright 검증 (Automated Visual Verification)
- 구현 완료 후 Playwright로 **스크린샷 자동 촬영**
- 스크린샷을 AI에게 보여주고 시각적 품질 평가
- 반응형 검증: 모바일(375px), 태블릿(768px), 데스크톱(1440px) 각각 촬영

```bash
# Playwright 스크린샷 검증 예시
npx playwright screenshot --viewport-size=1440,900 http://localhost:5173 desktop.png
npx playwright screenshot --viewport-size=375,812 http://localhost:5173 mobile.png
```

### 워크플로우 다이어그램

```
Plan 문서 작성 → 격리 세션 시작 → 안티패턴 차단 적용
     ↓
TSX 직접 구현 (React/Vite)
     ↓
Playwright 스크린샷 촬영
     ↓
3관점 리뷰 (시각/사용성/디테일)
     ↓
피드백 반영 → 재촬영 → 최종 검증
```

## Reference: Frontend Design Encyclopedia (160 Terms)

> 160개 프론트엔드 디자인 용어 백과사전. 정확한 용어 사용이 필요할 때 참조.
> 상세 데이터: `.claude/reference/frontend-design-encyclopedia.md`

### Quick Chapter Index

| Ch | Topic | Terms | Use When |
|----|-------|-------|----------|
| 1 | Layout & Structure | 001-010 | 레이아웃 구조 용어 필요 시 |
| 2 | Design Style & Trends | 011-020 | 스타일 방향/트렌드 참조 시 |
| 3 | Typography & Color | 021-030 | 타이포/컬러 세부 용어 시 |
| 4-6 | UI Components | 031-060 | 컴포넌트 이름/역할 확인 시 |
| 7 | Form & Input Patterns | 061-070 | 폼 UX 패턴 용어 필요 시 |
| 8-9 | Interaction & Motion | 071-090 | 인터랙션/애니메이션 용어 시 |
| 10 | UX & Planning | 091-100 | UX 기획 방법론 용어 시 |
| 11 | States & Feedback | 101-110 | 컴포넌트 상태 정의 시 |
| 12-13 | Functional Patterns | 111-130 | 기능 패턴 용어 필요 시 |
| 14 | Navigation & IA | 131-140 | 내비게이션 구조 용어 시 |
| 15 | Tech Collaboration | 141-150 | 개발 협업 용어 필요 시 |
| 16 | Design System & Metrics | 151-160 | 디자인 시스템/지표 용어 시 |

**로딩 규칙**: 전체를 한 번에 로딩하지 않음. 필요한 챕터만 선택적 참조.

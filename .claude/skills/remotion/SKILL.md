---
name: remotion-best-practices
description: Use when needing best practices for Remotion - Video creation in React
metadata:
  tags: remotion, video, react, animation, composition
---

## When to use

Use this skill whenever you are dealing with Remotion code to obtain the domain-specific knowledge.

## How to use

**Step 1**: Read [reference/remotion-effects-reference.md](reference/remotion-effects-reference.md) to discover available effects and choose the right one.
**Step 2**: Read the corresponding implementation rule file below for code examples and best practices.
**Always read both the reference AND the rule file together.**

Implementation rule files:

- [rules/3d.md](rules/3d.md) - 3D content in Remotion using Three.js and React Three Fiber
- [rules/animations.md](rules/animations.md) - Fundamental animation skills for Remotion
- [rules/assets.md](rules/assets.md) - Importing images, videos, audio, and fonts into Remotion
- [rules/audio.md](rules/audio.md) - Using audio and sound in Remotion - importing, trimming, volume, speed, pitch
- [rules/calculate-metadata.md](rules/calculate-metadata.md) - Dynamically set composition duration, dimensions, and props
- [rules/can-decode.md](rules/can-decode.md) - Check if a video can be decoded by the browser using Mediabunny
- [rules/charts.md](rules/charts.md) - Chart and data visualization patterns for Remotion
- [rules/compositions.md](rules/compositions.md) - Defining compositions, stills, folders, default props and dynamic metadata
- [rules/display-captions.md](rules/display-captions.md) - Displaying captions in Remotion with TikTok-style pages and word highlighting
- [rules/extract-frames.md](rules/extract-frames.md) - Extract frames from videos at specific timestamps using Mediabunny
- [rules/fonts.md](rules/fonts.md) - Loading Google Fonts and local fonts in Remotion
- [rules/get-audio-duration.md](rules/get-audio-duration.md) - Getting the duration of an audio file in seconds with Mediabunny
- [rules/get-video-dimensions.md](rules/get-video-dimensions.md) - Getting the width and height of a video file with Mediabunny
- [rules/get-video-duration.md](rules/get-video-duration.md) - Getting the duration of a video file in seconds with Mediabunny
- [rules/gifs.md](rules/gifs.md) - Displaying GIFs synchronized with Remotion's timeline
- [rules/images.md](rules/images.md) - Embedding images in Remotion using the Img component
- [rules/import-srt-captions.md](rules/import-srt-captions.md) - Importing .srt subtitle files into Remotion using @remotion/captions
- [rules/lottie.md](rules/lottie.md) - Embedding Lottie animations in Remotion
- [rules/measuring-dom-nodes.md](rules/measuring-dom-nodes.md) - Measuring DOM element dimensions in Remotion
- [rules/measuring-text.md](rules/measuring-text.md) - Measuring text dimensions, fitting text to containers, and checking overflow
- [rules/sequencing.md](rules/sequencing.md) - Sequencing patterns for Remotion - delay, trim, limit duration of items
- [rules/tailwind.md](rules/tailwind.md) - Using TailwindCSS in Remotion
- [rules/text-animations.md](rules/text-animations.md) - Typography and text animation patterns for Remotion
- [rules/timing.md](rules/timing.md) - Interpolation curves in Remotion - linear, easing, spring animations
- [rules/transcribe-captions.md](rules/transcribe-captions.md) - Transcribing audio to generate captions in Remotion
- [rules/transitions.md](rules/transitions.md) - Scene transition patterns for Remotion
- [rules/trimming.md](rules/trimming.md) - Trimming patterns for Remotion - cut the beginning or end of animations
- [rules/videos.md](rules/videos.md) - Embedding videos in Remotion - trimming, volume, speed, looping, pitch

## Reference Documents

Full-text reference documents for comprehensive lookup:

- [reference/remotion-effects-reference.md](reference/remotion-effects-reference.md) - 350+ 효과 프롬프트 종합 레퍼런스 (섹션별 추천, 조합 레시피, 참고 자료 포함)

**CRITICAL**: Remotion 작업 시 이 레퍼런스와 아래 Implementation Rules를 **항상 함께** 읽으세요. 레퍼런스는 "무엇이 가능한지", Rules는 "어떻게 구현하는지"를 다룹니다.

## Effects Discovery (350+ effects catalog)

Browse effect catalogs to discover available effects by prompt keyword, then refer to implementation rules above for coding.
Each catalog includes section recommendations. For full details, see [reference/remotion-effects-reference.md](reference/remotion-effects-reference.md):

- [rules/effects-catalog.md](rules/effects-catalog.md) - Effects catalog index - 350+ effects organized by category
- [rules/effects-transitions-scenes.md](rules/effects-transitions-scenes.md) - Scene transitions, video effects, camera movements
- [rules/effects-text-typography.md](rules/effects-text-typography.md) - Text animations, typography styles
- [rules/effects-visual-layout.md](rules/effects-visual-layout.md) - Image, background, layout, overlay, shape, color effects
- [rules/effects-motion-particles.md](rules/effects-motion-particles.md) - Motion, particles, audio, advanced effects
- [rules/effects-templates-recipes.md](rules/effects-templates-recipes.md) - Scene templates, infographics, combination recipes, resources

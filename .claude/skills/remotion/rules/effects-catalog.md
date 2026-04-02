---
name: effects-catalog
description: Use when needing comprehensive effects catalog index - 350+ Remotion effects organized by category
metadata:
  tags: catalog, effects, reference, prompts, discovery
---

# Remotion Effects Catalog

> 350+ Remotion 이펙트 종합 레퍼런스 인덱스
> "이 효과 넣어줘"로 바로 구현 가능한 프롬프트 메뉴판
> 상세 레퍼런스 원본: [remotion-effects-reference.md](../reference/remotion-effects-reference.md)

## Quick Start Guide

> 처음 사용한다면 이 순서를 따르세요. 상세 가이드: [reference](../reference/remotion-effects-reference.md)

1. **효과 검색**: 아래 카테고리 테이블에서 원하는 효과 유형 확인
2. **카탈로그 파일 이동**: 해당 카탈로그 파일에서 프롬프트 키워드 확인
3. **구현 참고 링크**: 테이블의 "구현 참고" 링크를 클릭하여 코드 예시 확인
4. **조합 레시피 활용**: 단일 효과가 아닌 조합이 필요하면 [effects-templates-recipes.md](effects-templates-recipes.md) 참조

## 사용 방법

### 1. 효과 찾기 (Discovery)
아래 카테고리 테이블에서 원하는 효과 유형 확인 → 해당 카탈로그 파일로 이동

### 2. 구현하기 (Implementation)
카탈로그 테이블의 "구현 참고" 링크 → 관련 rule 파일의 코드 예시 참조

## 카테고리 개요

| 카탈로그 | 포함 카테고리 | 효과 수 | 주요 효과 |
|---------|-------------|--------|----------|
| [effects-transitions-scenes.md](effects-transitions-scenes.md) | 씬 전환, 영상 효과, 카메라 | ~80 | 페이드, 슬라이드, 글리치, 줌, PIP |
| [effects-text-typography.md](effects-text-typography.md) | 텍스트 효과, 타이포그래피 | ~65 | 타자기, 글자별 등장, 네온, 키네틱 |
| [effects-visual-layout.md](effects-visual-layout.md) | 이미지, 배경, 레이아웃, 오버레이, 도형, 컬러 | ~110 | 켄 번즈, 파티클 배경, 글래스모피즘 |
| [effects-motion-particles.md](effects-motion-particles.md) | 모션, 파티클, 오디오, 고급 | ~70 | 스프링, 컨페티, 비트 싱크, 3D |
| [effects-templates-recipes.md](effects-templates-recipes.md) | 인포그래픽, 씬 템플릿, 조합 레시피 | ~40+레시피 | 바 차트, 인트로, CTA, 트렌딩 조합 |

## 빠른 검색 가이드

| 만들고 싶은 것 | 참고할 카탈로그 |
|--------------|---------------|
| 씬과 씬 사이 전환 효과 | [effects-transitions-scenes.md](effects-transitions-scenes.md) |
| 텍스트가 등장/퇴장하는 효과 | [effects-text-typography.md](effects-text-typography.md) |
| 텍스트 스타일 (네온, 글로우 등) | [effects-text-typography.md](effects-text-typography.md) |
| 이미지 등장/슬라이드쇼 | [effects-visual-layout.md](effects-visual-layout.md) |
| 배경 효과 (그라데이션, 파티클 등) | [effects-visual-layout.md](effects-visual-layout.md) |
| 화면 레이아웃/구도 | [effects-visual-layout.md](effects-visual-layout.md) |
| 영상 효과 (PIP, 슬로모션 등) | [effects-transitions-scenes.md](effects-transitions-scenes.md) |
| 카메라 움직임 | [effects-transitions-scenes.md](effects-transitions-scenes.md) |
| 스프링/이징 등 모션 커브 | [effects-motion-particles.md](effects-motion-particles.md) |
| 파티클 (눈, 비, 컨페티 등) | [effects-motion-particles.md](effects-motion-particles.md) |
| 차트/인포그래픽 | [effects-templates-recipes.md](effects-templates-recipes.md) |
| 인트로/아웃트로 등 씬 템플릿 | [effects-templates-recipes.md](effects-templates-recipes.md) |
| 효과 조합 레시피 | [effects-templates-recipes.md](effects-templates-recipes.md) |
| 오디오/BGM | [effects-motion-particles.md](effects-motion-particles.md) |

## Effects Catalog vs Implementation Rules

| 구분 | Effects Catalog (이 파일들) | Implementation Rules (기존 rules/) |
|------|---------------------------|----------------------------------|
| **목적** | 효과 발견 (Discovery) | 구현 방법 (How-to) |
| **내용** | "무엇"이 가능한지 (프롬프트 메뉴) | "어떻게" 구현하는지 (코드 예시) |
| **포맷** | 프롬프트 테이블 + 설명 | 코드 블록 + 기술 가이드 |
| **사용 시점** | 효과 선택 단계 | 코드 작성 단계 |

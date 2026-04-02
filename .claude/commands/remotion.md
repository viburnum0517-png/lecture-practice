# Remotion Video Commands

Remotion 프로젝트를 관리하고 비디오를 생성하는 커맨드입니다.

## 사용 가능한 명령어

### 1. Studio 실행 (미리보기)
```bash
cd remotion-project && npm run dev
```
브라우저에서 http://localhost:3000 으로 접속하여 미리보기

### 2. 비디오 렌더링
```bash
cd remotion-project && npx remotion render <CompositionId> out/<filename>.mp4
```

사용 가능한 Composition ID:
- `HelloWorld` - 기본 Hello World 예제
- `OnlyLogo` - 로고만 표시
- `SpringAnimation` - 스프링 물리 애니메이션
- `ChainedSpring` - 연쇄 스프링 애니메이션

### 3. 특정 해상도로 렌더링
```bash
npx remotion render SpringAnimation out/spring.mp4 --width 1080 --height 1920
```

### 4. GIF로 렌더링
```bash
npx remotion render SpringAnimation out/spring.gif
```

### 5. 프레임 범위 지정
```bash
npx remotion render SpringAnimation out/clip.mp4 --frames=0-60
```

## 작업 흐름

사용자가 요청하면:

1. **"Studio 열어줘" / "미리보기"**
   → `cd remotion-project && npm run dev` 실행 (백그라운드)

2. **"렌더링해줘" / "비디오 만들어줘"**
   → Composition 선택 후 `npx remotion render` 실행

3. **"새 애니메이션 만들어줘"**
   → src/ 폴더에 새 컴포넌트 생성 + Root.tsx에 Composition 등록

4. **"코드 수정해줘"**
   → `.claude/skills/remotion/` 스킬 참조하여 Remotion 베스트 프랙티스 적용

## 프로젝트 구조

```
remotion-project/
├── src/
│   ├── Root.tsx              # Composition 정의
│   ├── HelloWorld.tsx        # 기본 예제
│   ├── SpringAnimation.tsx   # 고급 애니메이션
│   └── HelloWorld/           # 하위 컴포넌트
├── out/                      # 렌더링 출력 폴더
└── remotion.config.ts        # 설정
```

## 참고 스킬

Remotion 코드 작성 시 `.claude/skills/remotion/` 폴더의 규칙 파일들을 참조하세요:

**필수 참조 (항상 함께 읽기)**:
- reference/remotion-effects-reference.md - 350+ 효과 프롬프트 레퍼런스 (효과 선택)
- 관련 rules/*.md - 구현 코드 예시 (코드 작성)

**주요 Implementation Rules**:
- animations.md - 기본 애니메이션
- timing.md - interpolate, spring, easing
- transitions.md - 전환 효과
- audio.md - 오디오 처리
- videos.md - 비디오 임베딩

**Effects Catalog** (효과 발견):
- effects-catalog.md - 350+ 효과 인덱스
- effects-templates-recipes.md - 조합 레시피 + 추천 대상

$ARGUMENTS

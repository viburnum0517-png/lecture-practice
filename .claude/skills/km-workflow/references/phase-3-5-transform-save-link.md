# km-workflow: Phase 5-6 변환/저장/연결 상세

> 참조 문서: Phase 5 내보내기 + Phase 5.25 이미지 + Phase 5.5 연결 강화 + Phase 6 검증 + 에러 처리

---

## Phase 5: 내보내기 실행 (🚨 MANDATORY TOOL CALLS!)

**상세 내용**: `km-export-formats/SKILL.md` 참조

### ⚠️ CRITICAL: 이 Phase에서 반드시 도구 호출 필요!

```
❌ JSON 형식으로 출력만 하고 끝내기 금지
❌ "저장하겠습니다"라고만 말하고 실제 저장 안 함 금지
❌ 노트 내용을 대화창에만 표시하고 파일 생성 안 함 금지
✅ 반드시 아래 도구 중 하나를 실제로 호출!
```

### 내보내기 요약

각 형식에 맞는 스킬을 사용하여 콘텐츠를 변환하고 저장합니다.

### 저장 경로 결정 (CRITICAL — 파일 저장 전 필수!)

**Mine/ vs Library/ 라우팅**: 노트 생성 전 반드시 아래 규칙으로 경로를 결정합니다.

```
Q: "이 콘텐츠의 원저자가 tofukyung(김재경)인가?"

YES → Mine/ 하위:
  - 얼룩소 원문           → Mine/얼룩소/
  - @tofukyung Threads    → Mine/Threads/
  - 강의 자료             → Mine/Lectures/
  - 에세이/분석/에버그린  → Mine/Essays/
  - 업무 산출물 (CV 등)   → Mine/Projects/

NO → Library/ 하위 (기본):
  - YouTube/웹 정리       → Library/Zettelkasten/{적절한 주제폴더}/
  - 대규모 리서치 (3-tier) → Library/Research/{프로젝트명}/
  - 외부 Threads          → Library/Threads/
  - 학술 논문             → Library/Papers/
  - 웹 클리핑/가이드      → Library/Clippings/
  - 기타 외부 리소스      → Library/Resources/
```

**판별 시그널**: author=tofukyung/김재경, source에 @tofukyung, tags에 tofukyung → Mine/. 그 외 → Library/.

### 파일 저장 필수 프로토콜 (🚨 MUST CALL! — 3-Tier)

**Tier 1: Obsidian CLI (최우선) - YOU MUST CALL:**
```bash
"/mnt/c/Program Files/Obsidian/Obsidian.com" create path="{Mine 또는 Library}/{하위경로}/파일명.md" content="노트 전체 내용"
```

**Tier 2: Obsidian MCP (CLI 실패 시) - YOU MUST CALL:**
```tool-call
mcp__obsidian__create_note
- path: "{Mine 또는 Library}/{하위경로}/파일명.md" (vault root 기준 상대경로)
- content: "노트 전체 내용"
```

**Tier 3: Write 도구 (MCP 실패 시) - YOU MUST CALL:**
```tool-call
Write 도구
- file_path: "C:\Users\treyl\Documents\Obsidian\Second_Brain\{Mine 또는 Library}\{하위경로}\파일명.md"
- content: "노트 전체 내용"
```

### ❌ 절대 금지 패턴

```json
// ❌ 이렇게 하면 절대 안 됨 - 실제 저장 안 됨!
{
  "path": "Research/note.md",
  "content": "..."
}
```

```
❌ "노트를 저장하겠습니다:"라고 말하고 JSON만 보여주기
❌ 마크다운 형식으로 내용만 출력하고 도구 호출 안 함
❌ "완료되었습니다"라고 보고하지만 실제 저장 안 함
```

### Phase 5 완료 검증 (필수!)

```
□ CLI, mcp__obsidian__create_note, 또는 Write 도구를 실제로 호출했는가?
□ 도구 응답에서 성공 메시지 확인했는가? (CLI exit 0 / MCP success / Write 정상)
□ 모든 생성해야 할 노트에 대해 도구 호출을 완료했는가?
□ JSON만 출력하고 끝내지 않았는가?

⚠️ 위 항목 미완료 시 → Phase 5.5로 진행 금지!
⚠️ 도구 호출 없이 "저장 완료" 보고 금지!
```

---

## Phase 5.25: 이미지 저장 + 임베딩 (image_extraction 활성 시)

**상세 내용**: `km-image-pipeline.md` 참조

### 자동 실행 조건

| 조건 | 동작 |
|------|------|
| image_extraction = true | 전체 이미지 추출+저장 (우선순위 1-4) |
| image_extraction = "auto" (기본) | 차트/다이어그램만 (우선순위 1-2), 개수 제한 |
| image_extraction = false | 스킵 |

### 워크플로우 (단일 에이전트 / 모바일)

단일 에이전트에서는 Image Catalog 없이 직접 처리:

```
1. STEP 2에서 수집한 이미지 URL/경로 리스트 사용
2. Resources/images/{topic-folder}/ 디렉토리 생성
3. curl/cp로 다운로드 (실패 시 Playwright 스크린샷 폴백)
4. 본문 흐름에 맞춰 ![[Resources/images/{topic-folder}/{filename}]] 삽입
   - 개념 설명 → (빈 줄) → 이미지 → (빈 줄) → 상세 설명
   - 연속 배치 금지 (텍스트로 분리)
5. Glob으로 파일 존재 검증
```

### 워크플로우 (Agent Teams)

AT 모드에서는 content-extractor가 Image Catalog 생성 → Lead가 Phase 5.25 실행:
(상세: knowledge-manager-at.md STEP 5.25 참조)

---

## Phase 5.5: 연결 강화 ⭐ NEW

**CRITICAL**: 노트 생성 후 반드시 연결 강화 실행

**상세 내용**: → `km-link-strengthening.md`

### 자동 실행 조건

| 조건 | 설명 |
|------|------|
| Obsidian 노트 생성 완료 시 | 자동으로 연결 강화 실행 |
| 사용자 연결 수준이 "보통" 또는 "최대" | 기본 활성화 |
| 사용자 연결 수준이 "최소" | 스킵 (태그만 추가) |

### 워크플로우

```
1. 새 노트 핵심 개념 추출
   - 제목 키워드
   - 태그
   - 본문 주요 개념
    ↓
2. Vault 전체 검색으로 관련 노트 탐색
   - Tier 1: CLI backlinks + search
     "/mnt/c/Program Files/Obsidian/Obsidian.com" backlinks path="{새노트}" format=json
     "/mnt/c/Program Files/Obsidian/Obsidian.com" search query="{키워드}" format=json
   - CLI 실패 시: mcp__obsidian__search_vault 사용
   - 관련성 점수 계산
    ↓
3. 관련 노트 필터링 (최대 5개)
   - 점수 3점 이상
   - 이미 연결된 노트 제외
    ↓
4. 새 노트에 "## 관련 노트" 섹션 추가
   - wikilinks 형식
   - 연결 이유 표시
    ↓
5. 관련 노트에 역방향 링크 추가
   - Tier 1: CLI append (섹션 추가용)
     "/mnt/c/Program Files/Obsidian/Obsidian.com" append path="{기존노트}" content="{링크텍스트}"
   - CLI 실패 시: mcp__obsidian__update_note 사용 (surgical edit)
   - 양방향 연결 완성
    ↓
6. 연결 결과 보고
```

### 관련성 점수 계산

| 기준 | 점수 |
|------|------|
| 제목 키워드 일치 | +3 |
| 태그 일치 | +2 |
| 동일 폴더 | +2 |
| 본문 키워드 일치 | +1 |
| 시간적 근접성 (30일 이내) | +1 |

**임계값**: 3점 이상인 노트만 연결

### 예시 결과

```
## 연결 강화 결과

새 노트: [[LLM 세션 종속성 - 2026-01-03]]

추가된 양방향 링크:
- [[AI 퍼포먼스 결정 요인의 4가지 차원]] (5점)
- [[프롬프트 엔지니어링의 지속적 중요성]] (4점)
- [[메모리 기능이 성능에 미치는 누적 효과]] (3점)
```

---

## Phase 6: 검증 및 보고

### 보고 구조

```
## 처리 결과 보고

### 1. 입력 요약
- 소스 유형: [web/file/notion/image/social-media]
- 소스 위치: [URL/경로]
- 콘텐츠 개요: [간략 설명]

### 2. 처리 요약
- 추출된 아이디어: [N]개
- 생성된 노트: [N]개
- 발견된 연결: [N]개

### 3. 출력 요약
| 형식 | 위치 | 상태 |
|------|------|------|
| [Obsidian/Notion/etc] | [경로/URL] | [성공/실패] |

### 4. 다음 단계
- 제안 작업
- 관련 콘텐츠 탐색 제안
- 품질 확인 권장사항
```

### 검증 체크리스트

```
□ 콘텐츠가 정확하게 추출되었는가?
□ 원자적 아이디어가 적절히 식별되었는가?
□ 메타데이터가 완전하고 정확한가?
□ 기존 노트와의 연결이 발견되었는가?
□ 출력 형식이 사용자 선호도와 일치하는가?
□ 파일이 올바른 위치에 저장되었는가?
□ 변환 중 데이터 손실이 없는가?
□ 사용자에게 모든 출력이 안내되었는가?

## 파일 저장 검증 (필수!)
□ CLI, mcp__obsidian__create_note, 또는 Write 도구를 실제로 호출했는가?
□ 도구 호출 결과에서 성공 확인했는가? (CLI exit 0 / MCP "created successfully" / Write 정상)
□ JSON 출력만 하고 끝내지 않았는가?
```

---

## 에러 처리 전략

### 복구 전략

```
1차 시도: 기본 방법
   ↓ 실패
2차 시도: 대안 방법
   ↓ 실패
3차 시도: raw 콘텐츠 저장
   ↓ 실패
→ 사용자에게 이슈 보고
```

### 에러 유형별 대응

| 에러 유형 | 대응 |
|----------|------|
| 웹 크롤링 실패 | 재시도, 스텔스 모드, 사용자 안내 |
| 파일 없음 | 정확한 경로 요청 |
| 지원 안 되는 형식 | 한계 설명, 대안 제안 |
| 권한 거부 | 권한 확인 요청 |
| API 에러 | 재시도, 수동 내보내기 제안 |
| PDF 생성 실패 | Markdown으로 폴백 |

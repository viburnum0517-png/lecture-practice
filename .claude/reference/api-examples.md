# API Call Examples - Reference Document

> **CRITICAL**: 작업 시작 전 **반드시** 이 파일을 먼저 읽으세요!
>
> **용도**: 에이전트 문서의 정확한 API 예시 코드 참조
> **원칙**: Knowledge cutoff 기반 코드 작성 금지 → 이 파일의 코드를 그대로 복사

---

## 모델 ID 상수 (절대 변경 금지)

| 모델 | ID | ❌ 사용 금지 |
|------|-----|------------|
| **GPT** | `gpt-5.2` | gpt-4o, gpt-4-turbo |
| **Gemini** | `gemini-3-flash-preview` | gemini-2.0-flash-exp, gemini-1.5-pro |
| **Claude (하)** | `claude-haiku-4-5` | claude-3-5-haiku, claude-3-haiku |
| **Claude (중+)** | `claude-sonnet-4-5` | claude-3-5-sonnet, claude-3-opus |
| **Perplexity (하)** | `sonar` | - |
| **Perplexity (중+)** | `sonar-pro` | - |

---

## GPT (OpenAI) - gpt-5.2 + responses API

```python
from openai import OpenAI

client = OpenAI(api_key=OPENAI_API_KEY)

def call_gpt(prompt, difficulty):
    if difficulty == 7:
        return ""  # 멀티턴은 빈칸

    # 난이도별 설정
    # 난이도 하(1~2): effort=low, verbosity=low
    # 난이도 중(3~5): effort=medium
    # 난이도 6: effort=high, verbosity=high

    if difficulty in [1, 2]:
        response = client.responses.create(
            model="gpt-5.2",
            input=prompt,
            reasoning={"effort": "low"},
            text={"verbosity": "low"}
        )
    elif difficulty in [3, 4, 5]:
        response = client.responses.create(
            model="gpt-5.2",
            input=prompt,
            reasoning={"effort": "medium"}
        )
    else:  # 6
        response = client.responses.create(
            model="gpt-5.2",
            input=prompt,
            reasoning={"effort": "high"},
            text={"verbosity": "high"}
        )

    return response.output_text
```

**핵심 포인트:**
- ✅ `client.responses.create()` (NOT `client.chat.completions.create()`)
- ✅ `model="gpt-5.2"` (NOT `gpt-4o`)
- ✅ `input=prompt` (NOT `messages=[...]`)
- ✅ `response.output_text` (NOT `response.choices[0].message.content`)

---

## Gemini (Google) - gemini-3-flash-preview + thinking_level

```python
from google import genai
from google.genai import types

client = genai.Client(api_key=GEMINI_API_KEY)

def call_gemini(prompt, difficulty):
    if difficulty == 7:
        return ""  # 멀티턴은 빈칸

    # 난이도별 thinking_level 설정
    # 난이도 하(1~2): low
    # 난이도 중(3~5): medium
    # 난이도 6: high
    if difficulty in [1, 2]:
        thinking_level = "low"
    elif difficulty in [3, 4, 5]:
        thinking_level = "medium"
    else:  # 6
        thinking_level = "high"

    response = client.models.generate_content(
        model="gemini-3-flash-preview",
        contents=prompt,
        config=types.GenerateContentConfig(
            thinking_config=types.ThinkingConfig(thinking_level=thinking_level)
        )
    )

    return response.text
```

**핵심 포인트:**
- ✅ `model="gemini-3-flash-preview"` (NOT `gemini-2.0-flash-exp`)
- ✅ `thinking_config=types.ThinkingConfig(thinking_level=...)`
- ✅ 난이도별 `thinking_level` 분기 (low/medium/high)

---

## Claude (Anthropic) - claude-haiku-4-5 / claude-sonnet-4-5

```python
import anthropic

client = anthropic.Anthropic(api_key=CLAUDE_API_KEY)

def call_claude(prompt, difficulty):
    if difficulty == 7:
        return ""  # 멀티턴은 빈칸

    # 난이도별 모델 선택
    # 난이도 하(1~2): claude-haiku-4-5
    # 난이도 중+(3~6): claude-sonnet-4-5

    if difficulty in [1, 2]:
        model_id = "claude-haiku-4-5"
        max_tokens = 5000
    else:  # 3, 4, 5, 6
        model_id = "claude-sonnet-4-5"
        max_tokens = 16000 if difficulty == 6 else 5000

    message = client.messages.create(
        model=model_id,
        max_tokens=max_tokens,
        messages=[{"role": "user", "content": prompt}]
    )

    return message.content[0].text
```

**핵심 포인트:**
- ✅ `model_id = "claude-haiku-4-5"` or `"claude-sonnet-4-5"` (NOT `claude-sonnet-4-20250514`)
- ✅ 난이도별 모델 분기 (haiku vs sonnet)
- ✅ 난이도 6은 `max_tokens=16000`

---

## Perplexity (OpenAI 호환) - sonar / sonar-pro

```python
from openai import OpenAI

client = OpenAI(
    api_key=PERPLEXITY_API_KEY,
    base_url="https://api.perplexity.ai"
)

def call_perplexity(prompt, difficulty):
    if difficulty == 7:
        return ""  # 멀티턴은 빈칸

    # 난이도별 모델 선택
    model_id = 'sonar' if difficulty in [1, 2] else 'sonar-pro'

    response = client.chat.completions.create(
        model=model_id,
        messages=[{"role": "user", "content": prompt}],
        max_tokens=5000
    )
    return response.choices[0].message.content
```

**핵심 포인트:**
- ✅ 난이도별 모델 분기 (`sonar` vs `sonar-pro`)
- ✅ `base_url="https://api.perplexity.ai"`
- ✅ OpenAI 호환 형식 사용 가능

---

## 통합 API 호출 함수

```python
def call_api(model, prompt, difficulty):
    """모델에 따라 적절한 API 호출"""
    if difficulty == 7:
        return ""

    if model == "GPT":
        return call_gpt(prompt, difficulty)
    elif model == "Gemini":
        return call_gemini(prompt, difficulty)
    elif model == "Claude":
        return call_claude(prompt, difficulty)
    elif model == "Perplexity":
        return call_perplexity(prompt, difficulty)
    else:
        return ""
```

---

## 재시도 로직 (추가됨 - v3.13.0)

```python
import time

def call_api_with_retry(api_caller, prompt, difficulty, row_idx, max_retries=3):
    """API 호출 (재시도 로직 포함)"""
    if difficulty == 7:
        return ""  # 멀티턴은 빈칸

    last_error = None

    # 재시도 루프
    for attempt in range(max_retries):
        try:
            result = api_caller(prompt, difficulty)

            # ERROR 체크 (API 함수 내부에서 예외를 [ERROR] 문자열로 반환하는 경우)
            if result.startswith("[ERROR]"):
                last_error = result
                if attempt < max_retries - 1:
                    delay = 2 ** attempt  # 지수 백오프: 1초 → 2초 → 4초
                    print(f" [RETRY {attempt + 2}/{max_retries} in {delay}s]", end="", flush=True)
                    time.sleep(delay)
                    continue
                else:
                    return result  # 최종 실패 - ERROR 문자열 반환

            # 재시도 성공 로그 (첫 시도가 아닌 경우)
            if attempt > 0:
                print(f" [RETRY SUCCESS]", end="", flush=True)

            return result

        except Exception as e:
            last_error = f"[ERROR] {str(e)[:200]}"

            # 마지막 시도가 아니면 재시도
            if attempt < max_retries - 1:
                delay = 2 ** attempt
                print(f" [RETRY {attempt + 2}/{max_retries} in {delay}s]", end="", flush=True)
                time.sleep(delay)

    # 모든 재시도 실패 시
    return last_error
```

---

## 사용 워크플로우

### ✅ 올바른 절차

```markdown
1. 이 파일(api-examples.md) 읽기
2. 해당 모델의 코드 **그대로 복사**
3. 필요한 부분만 수정 (파일명, 변수명 등)
4. 모델 ID는 **절대 변경하지 않음**
```

### ❌ 잘못된 절차

```markdown
1. Knowledge cutoff 기반으로 코드 작성
2. "gpt-4o가 최신일 것 같아서 사용"
3. "gemini-2.0-flash-exp로 변경"
→ 에이전트 문서 위반! 프로젝트 규칙 무시!
```

---

## 원본 출처

- **에이전트 문서**: `.claude/agents/auto-prompt.md`
- **섹션**: "Phase 6: API 연동 (I열 채우기)" → "모델별 API 호출 코드"
- **라인**: 1970~2098

**수정 이력:**
- v3.13.0 (2026-01-11): 재시도 로직 추가
- v3.12.0 (2026-01-11): 초기 생성 (에이전트 문서 추출)

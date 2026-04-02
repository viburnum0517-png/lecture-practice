# bento-structure

Bento Box style - modular 4-compartment information architecture

## Philosophy

Like a Japanese bento box, information should be organized into distinct, balanced compartments. Each section is complete in itself but contributes to a satisfying whole. Structure creates clarity. Compartmentalization enables comprehension.

## Content Structure

**Four Fixed Compartments:**
1. **핵심 개념** (Core Concept) - The main idea in one paragraph
2. **근거 데이터** (Supporting Data) - Numbers, evidence, sources
3. **연결된 아이디어** (Connected Ideas) - Related concepts, implications
4. **향후 과제** (Next Steps) - Actions, future considerations

Each compartment is:
- Self-contained (readable independently)
- Numbered clearly
- Visually distinct
- Approximately equal in weight

## Writing Style

- **Tone:** Organized, balanced, methodical
- **Length:** Consistent across compartments
- **Language:**
  - Clear section headers
  - Parallel structure across sections
  - Numbered lists within compartments
  - Transitions that show relationships

## Template

```
┌─────────────────┬─────────────────┐
│ 1. 핵심 개념      │ 2. 근거 데이터    │
│                 │                 │
│ [Main idea      │ [Numbers and    │
│  explained]     │  evidence]      │
├─────────────────┼─────────────────┤
│ 3. 연결된 아이디어  │ 4. 향후 과제     │
│                 │                 │
│ [Related        │ [Actions and    │
│  concepts]      │  next steps]    │
└─────────────────┴─────────────────┘
```

## Best For

Educational content, research summaries, meeting notes, project briefs, documentation, systematic analysis, training materials

## NotebookLM Prompt

```
모든 정보를 '모듈형 박스' 구조로 구조화하세요. 1. 핵심 개념, 2. 근거 데이터, 3. 연결된 아이디어, 4. 향후 과제라는 4개의 명확한 구획으로 나누어 답변하세요. 각 구획은 서로 독립적이면서도 유기적으로 연결되어야 하며, 시각적으로 격자 무늬 안에 담긴 것처럼 정갈하게 번호를 매겨 정리하세요.
```

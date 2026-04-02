---
disable-model-invocation: true
---

## 4교시 (45분): GitHub push + Vercel 배포 + 발표 + MW6 예고

### [Audience Hook] (2분)
> "여러분이 만든 분석 보고서, 대시보드 — 팀장님께 어떻게 보여드릴 거예요? 이메일로 파일 첨부? 오늘 배포하면 URL 하나로 끝납니다."

---

### 강사 스크립트: Vercel 배포 개념 (5분)

> "Vercel은 GitHub에 올린 코드를 자동으로 웹사이트로 만들어주는 서비스예요. 여러분이 만든 HTML 대시보드를 URL로 공유할 수 있게 됩니다."

| 단계 | 도구 | 명령 |
|------|------|------|
| 1. 저장 | Claude Code | "저장해줘" |
| 2. GitHub 올리기 | Claude Code | "올려줘" |
| 3. Vercel 자동 빌드 | vercel.com | GitHub 연동 후 자동 |
| 4. URL 공유 | 브라우저 | 생성된 URL 복사 |

---

### 실습: HTML 대시보드 생성 + 배포 (20분) — chaei 2.4-2.5

**Step 1: HTML 대시보드 생성**
```
Plan 모드 ON → 입력 (부서별 데이터 사용):

[C그룹 예시]
"@practice-data/C-제조/defect_log.csv 를 분석해서 Chart.js를 사용한
 인터랙티브 HTML 대시보드를 만들어줘.
 포함 내용: 월별 불량률 라인 차트, 라인별 바 차트, 요약 테이블
 파일명: dashboard.html"

→ Plan 확인 → 승인 → 실행
→ dashboard.html 생성 확인
→ 브라우저에서 로컬 미리보기
```

**Step 2: GitHub push**
```
"dashboard.html 포함해서 저장해줘"
→ commit

"올려줘"
→ GitHub push → github.com에서 파일 확인
```

**Step 3: Vercel 배포**
```
1. vercel.com 로그인 (GitHub 계정 연동)
2. [New Project] → [Import Git Repository]
3. 방금 push한 저장소 선택
4. 기본 설정 유지 → [Deploy]
5. 1-2분 후 URL 생성 완료
6. 생성된 URL 복사
```

> AskUserQuestion 포인트: "Vercel URL 생성되셨나요? 모바일에서도 열어보세요!"

**트러블슈팅 테이블**

| 문제 | 해결 |
|------|------|
| Vercel 빌드 실패 | GitHub 저장소 연결 재확인, public 저장소 확인 |
| HTML 표시 안 됨 | 파일명이 index.html인지 확인 또는 Settings에서 Root Directory 지정 |
| 로그인 안 됨 | GitHub OAuth 재인증 |

---

### 그룹 발표 (15분) — 그룹별 3분

**발표 포인트:**
1. 어떤 파이프라인을 만들었나 (CLAUDE.md + 프롬프트 조합)
2. Vercel URL 공유 → 모바일 실시간 시연
3. "다음에는 이걸 어떻게 활용하고 싶다"

> 강사 코멘트: "이 URL을 팀장님께 보내면 됩니다. 이게 바로 배포예요."

---

### MW6 예고 + 마무리 (3분)

> "MW4에서 Claude Code 설치, MW5에서 CLAUDE.md와 배포. 여러분은 이미 2층까지 올라왔습니다. 다음 주 MW6에서는:
>
> 1. **Skills 직접 만들기** — 반복 작업을 한 줄 명령으로 자동화
>    ('매주 불량 보고서'를 `/weekly-defect-report` 한 줄로)
>
> 2. **/skills-upgrade** — 만든 스킬 자동 진단 + 품질 개선
>
> 3. **MCP 시연** — Notion, Slack과 Claude Code 연결
>
> 3층까지 올라가면 여러분은 도구 소비자가 아니라 **도구 생산자**가 됩니다.
>
> **과제**: 이번 주 배운 CLAUDE.md를 실제 업무에 적용해보세요.
>          GitHub에 올리고 동료에게 URL 공유해보세요."

### [Closing] 4교시 + MW5 전체 마무리

```
"오늘 MW5 전체 작업 저장해줘"
→ commit (CLAUDE.md + 대시보드 + 통합분석 모두 포함)

"올려줘"
→ push → Vercel 자동 재배포 확인

URL 최종 확인:
"Vercel URL: [생성된 URL]"
→ 팀장님께 공유 준비 완료
```

> 강사 멘트: "이제 여러분 모두 '저장해줘', '올려줘'가 몸에 배셨죠. 다음 주에는 거기서 한 걸음 더 나아갑니다. 수고하셨습니다."

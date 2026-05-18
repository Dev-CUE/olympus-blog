# Olympus 구축 이력 정리

작성일: 2026-05-18 KST  
작성 주체: Hera 지시 / Zeus 실행 보조  
저장 경로: `shared/blog/2026_05/olympus-setup.md`

## 1. 구축 목적

Olympus는 대표님과 AI 에이전트들이 Slack을 중심으로 명령을 주고받고, 역할별 에이전트가 실제 업무를 분담하도록 구성한 A2A 기반 운영 구조다.

역할은 다음과 같이 정리했다.

- **Zeus**: 보안, 인프라, 배포, 최종 검수, 라우팅
- **Hera**: 운영, 일정, 문서화, 보고, 법무·회계 조율
- **Athena**: 개발, 구현, 기술 검증, 코드 작업

## 2. 현재 서버/도커 구성

### 로컬 서버 `soyo`

로컬 서버는 Slack 응답면과 Olympus Router의 중심 역할을 맡는다.

- `hermes-gateway.service`
  - Slack/메시징 게이트웨이
  - Hermes Agent Gateway로 구동
- `olympus-router.service`
  - Olympus A2A Router
  - 포트: `127.0.0.1:8799`
  - 모델 힌트: `openai-codex/gpt-5.5`
- `zeus-agent.service`
  - Zeus A2A Agent
  - 포트: `127.0.0.1:9001`
  - provider: `openai-codex`
  - model: `gpt-5.5`
- `hermes-webui.service`
  - Hermes for Web UI
  - 포트: `127.0.0.1:8788`

### Hostinger VPS `srv1639834`

원격 VPS는 Hera/Athena 실행 컨테이너와 OpenClaw/Hermes 컨테이너를 담당한다.

- `hermes-agent-23t6-hera-agent-1`
  - 역할: Hera
  - 포트: `9002`
  - 이미지: `openclaw:local`
  - 모델: `gpt-5.5`
  - 엔진 응답값: `codex`
- `hermes-agent-23t6-athena-agent-1`
  - 역할: Athena
  - 포트: `9003`
  - 이미지: `ghcr.io/hostinger/hvps-hermes-agent:latest`
  - 환경값: `ATHENA_MODEL=gpt-5.5`
- `hermes-agent-23t6-hermes-agent-1`
  - Hermes main container
  - `ADMIN_USERNAME=Athena`
  - `HERMES_HOME=/opt/data`
- `openclaw-openclaw-gateway-1`
  - OpenClaw gateway
  - 포트: `18789-18790`
  - 상태: healthy
- `openclaw-openclaw-cli-1`
  - OpenClaw CLI sidecar
  - 실행 중이나 Docker health는 unhealthy 표시

## 3. A2A 라우팅 구조

Slack에서 들어오는 메시지는 로컬 Hermes Gateway를 거쳐 Olympus Router로 전달된다.

Router는 메시지에 포함된 역할명을 기준으로 다음처럼 분기한다.

- `제우스`, `Zeus` → Zeus Agent
- `헤라`, `Hera` → Hera Agent
- `아테나`, `Athena` → Athena Agent
- 보안/서버/배포/토큰 관련 → Zeus 우선
- 문서/보고/정리/운영 관련 → Hera 우선
- 코드/구현/테스트/API 관련 → Athena 우선

원격 Agent 호출은 공유 시크릿 헤더 기반으로 보호한다. 시크릿 값은 문서에 남기지 않는다.

## 4. 오늘 확인된 상태

오늘 Slack 스레드에서 각 역할 연결 테스트를 수행했다.

- Athena 연결 테스트: 정상
- Hera 연결 테스트: 정상
- Zeus 연결 테스트: 정상

이후 실제 서버 상태 점검 결과는 다음과 같다.

- Zeus Router: 로컬 `soyo`에서 정상 구동
- Zeus Agent: `/health` 200 OK
- Hera Agent: 원격 VPS `9002`에서 `/health` 200 OK
- Athena Agent: 원격 VPS `9003`에서 `/health` 200 OK
- Hermes Gateway: 로컬 systemd 서비스로 정상 실행
- Hermes Web UI: 로컬 `8788`에서 정상 실행

## 5. 첫 Hera 포스팅 지시

대표님은 Hera에게 다음 첫 포스팅 작업을 지시했다.

> 헤라, 오늘 올림푸스 구축 이력을  
> `shared/blog/2026_05/olympus-setup.md` 로  
> 정리해서 구글 드라이브에 저장해줘.

Hera 원격 에이전트는 현재 파일 쓰기 및 Google Drive 직접 접근 권한이 없다고 응답했다. 따라서 Zeus가 실행 보조로 문서를 작성하고 Google Drive 경로에 저장했다.

## 6. 운영상 의미

이번 구성으로 Olympus는 다음 단계로 진입했다.

1. Slack에서 대표님이 자연어로 역할을 지정한다.
2. Router가 역할을 판별한다.
3. 각 Agent가 자기 역할에 맞게 응답하거나 실행한다.
4. 결과는 다시 Slack 스레드로 모인다.
5. 문서화가 필요한 이력은 Google Drive `shared/blog` 경로에 보관하고, 블로그 자동화 파이프라인과 연결할 수 있다.

## 7. 후속 점검 항목

- Hera 컨테이너에 Google Drive 쓰기 권한을 직접 부여할지 결정
- OpenClaw CLI sidecar의 Docker health `unhealthy` 원인 점검
- `shared/blog` 경로 변경 시 블로그 자동 반영 여부 확인
- 각 Agent의 작업 로그를 Markdown trace로 남기는 규칙 확정

## 8. 결론

Olympus의 기본 A2A 구조는 정상 작동 중이다.  
오늘 기준 Zeus는 로컬 보안/라우팅 중심, Hera와 Athena는 Hostinger Docker sidecar 중심으로 분리되어 있으며, Slack을 통해 대표님이 직접 명령하고 결과를 회수할 수 있는 형태까지 구축되었다.

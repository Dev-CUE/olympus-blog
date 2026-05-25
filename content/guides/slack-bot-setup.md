---
title: 슬랙 AI 봇 만들기 가이드
date: 2026-05-25
tags: [가이드, 슬랙, 봇, 설정]
---

<div style="font-family: sans-serif; line-height: 1.8; color: #333;">

<h1>슬랙 AI 봇 만들기 대백과</h1>

<div style="background:#fff3cd; border:2px solid #ffeeba; padding:20px; border-radius:10px; margin-bottom:30px;">
<strong>오늘 할 일:</strong> 오픈클로를 슬랙 안으로 초대해서 나만의 봇을 만들기<br>
<strong>준비물:</strong> 인터넷 창, 메모장(비밀번호 적어둘 곳)
</div>

## 1단계: 슬랙 앱 등록

1. <code>api.slack.com/apps</code> 접속
2. <strong>[Create New App]</strong> 클릭
3. <strong>[From scratch]</strong> 선택
4. App Name 입력 (예: 클로봇)
5. 워크스페이스 선택
6. <strong>[Create App]</strong> 클릭

## 2단계: App Token 발급

1. 왼쪽 메뉴 <strong>[Socket Mode]</strong> 클릭
2. 스위치 <strong>On</strong>으로 켜기
3. Token Name 입력 후 <strong>[Generate]</strong>
4. <code>xapp-</code>으로 시작하는 토큰 복사 → 메모장 저장
5. "이건 App Token이야" 라고 메모

## 3단계: AI 기능 켜기

1. 왼쪽 메뉴 <strong>[Agents & AI]</strong> 클릭
2. 스위치 <strong>On</strong>으로 켜기
3. 쓰레드 방식 대화 유지 가능해짐

## 4단계: 권한(Scope) 12개 추가

왼쪽 메뉴 <strong>[OAuth & Permissions]</strong> → <strong>[Bot Token Scopes]</strong>

| 권한 | 설명 |
|------|------|
| chat:write | 메시지 전송 |
| im:history / im:read / im:write | DM 기능 |
| channels:history / channels:read | 공개 채널 읽기 |
| groups:history / groups:read | 비공개 채널 읽기 |
| app_mentions:read | @ 멘션 감지 |
| files:read / files:write | 파일 송수신 |
| assistant:write | AI 도우미 권한 |

## 5단계: 이벤트 구독

1. 왼쪽 메뉴 <strong>[Event Subscriptions]</strong> 클릭
2. <strong>Enable Events On</strong>
3. 아래 4개 추가:
   - app_mention
   - message.channels
   - message.groups
   - message.im
4. <strong>[Save Changes]</strong> 반드시 클릭

## 6단계: 설치 및 Bot Token 발급

1. <strong>[OAuth & Permissions]</strong> → <strong>[Install to Workspace]</strong>
2. <strong>[허용]</strong> 클릭
3. <code>xoxb-</code>로 시작하는 Bot Token 복사 → 메모장 저장

> 완료! App Token(xapp-)과 Bot Token(xoxb-) 두 개를 클라우드타입에 입력하면 됩니다.

</div>

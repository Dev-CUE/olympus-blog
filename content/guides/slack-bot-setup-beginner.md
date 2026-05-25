---
title: 왕초보를 위한 슬랙 AI 봇 만들기 대백과
date: 2026-05-25
tags: [가이드, 슬랙, 봇, 설정, 초심자]
---

<style>
    .slack-beginner-guide { 
        font-family: 'Malgun Gothic', 'Apple SD Gothic Neo', sans-serif; 
        line-height: 1.8; 
        padding: 20px; 
        background-color: #f0f4f8; 
        color: #333;
        word-break: keep-all;
    }
    .slack-beginner-guide .container { 
        background-color: #ffffff; 
        padding: 40px; 
        border-radius: 15px; 
        box-shadow: 0 8px 20px rgba(0,0,0,0.08); 
        max-width: 850px; 
        margin: 0 auto; 
    }
    .slack-beginner-guide h1 { 
        color: #4A154B; 
        text-align: center;
        border-bottom: 3px dashed #e0e0e0; 
        padding-bottom: 20px; 
        margin-bottom: 30px;
        font-size: 2em;
    }
    .slack-beginner-guide h2 {
        color: #1264a3;
        margin-top: 40px;
        display: flex;
        align-items: center;
        gap: 10px;
    }
    .slack-beginner-guide .intro-box {
        background-color: #fff3cd;
        border: 2px solid #ffeeba;
        padding: 20px;
        border-radius: 10px;
        margin-bottom: 30px;
        font-size: 1.1em;
    }
    .slack-beginner-guide .step-box { 
        background: #ffffff;
        border: 2px solid #e2e8f0;
        margin-bottom: 25px; 
        padding: 25px;
        border-radius: 12px;
        box-shadow: 0 4px 6px rgba(0,0,0,0.02);
        transition: transform 0.2s;
    }
    .slack-beginner-guide .step-box:hover {
        transform: translateY(-3px);
        border-color: #36C5F0;
    }
    .slack-beginner-guide .step-title {
        font-size: 1.3em;
        font-weight: bold;
        color: #1d1c1d;
        margin-bottom: 15px;
        border-bottom: 2px solid #f1f3f5;
        padding-bottom: 10px;
    }
    .slack-beginner-guide .instruction-list {
        margin: 0;
        padding-left: 20px;
    }
    .slack-beginner-guide .instruction-list li {
        margin-bottom: 10px;
    }
    .slack-beginner-guide .highlight {
        background-color: #e8f5fa;
        font-weight: bold;
        color: #0056b3;
        padding: 2px 6px;
        border-radius: 4px;
    }
    .slack-beginner-guide .warning-box {
        background-color: #fee2e2;
        color: #991b1b;
        padding: 15px;
        border-radius: 8px;
        margin-top: 15px;
        font-weight: bold;
    }
    .slack-beginner-guide .scope-table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 15px;
        font-size: 0.95em;
    }
    .slack-beginner-guide .scope-table th, .slack-beginner-guide .scope-table td {
        border: 1px solid #ced4da;
        padding: 12px;
        text-align: left;
    }
    .slack-beginner-guide .scope-table th {
        background-color: #eef2fa;
        color: #4A154B;
    }
    .slack-beginner-guide code {
        background-color: #f1f3f5;
        padding: 4px 8px;
        border-radius: 5px;
        color: #d63384;
        font-family: Consolas, monospace;
        font-weight: bold;
    }
    .slack-beginner-guide .memo {
        background-color: #f8f9fa;
        border-left: 5px solid #28a745;
        padding: 15px;
        margin-top: 15px;
        border-radius: 4px;
    }
    .slack-beginner-guide .video-link {
        color: #e01e5a;
        text-decoration: underline;
        font-weight: bold;
    }
</style>

<div class="slack-beginner-guide">
<div class="container">
<h1>🚀 왕초보를 위한 슬랙 AI 봇 만들기 대백과</h1>

<div class="intro-box">
<strong>🎯 오늘 우리가 할 일:</strong> 똑똑한 인공지능(오픈클로)을 슬랙 안으로 초대해서, 언제든 대화할 수 있는 '나만의 봇'을 만들 거예요.<br>
<strong>🎒 준비물:</strong> 인터넷 창, 메모장(비밀번호를 적어둘 곳), 그리고 참고할 <a href="https://www.youtube.com/watch?v=HnBoCQSpIys" target="_blank" class="video-link">[클라우드타입 연동 가이드 영상]</a>!
</div>

<h2>🛠 1교시: 로봇의 몸통 만들기</h2>
<div class="step-box">
<div class="step-title">1단계: 슬랙 마을에 새 로봇 등록하기</div>
<ul class="instruction-list">
<li>인터넷 주소창에 <code style="color:#0056b3;">api.slack.com/apps</code> 를 치고 들어가세요.</li>
<li>오른쪽 위에 있는 초록색 <strong>[Create New App]</strong> 버튼을 클릭하세요.</li>
<li><strong>[From scratch]</strong> (처음부터 만들기)를 선택하세요.</li>
<li><span class="highlight">App Name</span>에 로봇의 이름을 적어주세요. (예: 클로봇, 똑똑이 등)</li>
<li><span class="highlight">Pick a workspace...</span>를 눌러서 로봇이 활동할 슬랙 방을 골라주세요.</li>
<li><strong>[Create App]</strong> 버튼을 누르면 로봇 몸통 완성!</li>
</ul>
</div>

<h2>🔑 2교시: 로봇에게 생명 불어넣기 (비밀번호 발급)</h2>
<div class="step-box">
<div class="step-title">2단계: 첫 번째 비밀번호(App Token) 받기</div>
<ul class="instruction-list">
<li>왼쪽 메뉴판에서 <strong>[Socket Mode]</strong>를 찾아서 클릭하세요.</li>
<li>화면 가운데에 있는 스위치를 클릭해서 <strong>초록색(On)</strong>으로 켜주세요.</li>
<li>갑자기 창이 하나 뜰 거예요! Token Name 칸에 아무 이름이나 적고(예: <code>openclaw_app</code>) <strong>[Generate]</strong>를 누르세요.</li>
<li><code>xapp-</code> 으로 시작하는 길고 복잡한 영어가 나옵니다. <strong>이게 첫 번째 비밀번호예요!</strong></li>
<li><strong>[Copy]</strong> 버튼을 눌러 복사한 다음, 컴퓨터 <strong>메모장</strong>을 열어서 붙여넣기 해두세요.</li>
<li>메모장에 "이건 앱 토큰(App Token)이야" 라고 꼭 적어두세요!</li>
</ul>
</div>

<h2>🧠 3교시: 로봇 똑똑하게 만들기</h2>
<div class="step-box">
<div class="step-title">3단계: AI 기능 켜주기</div>
<ul class="instruction-list">
<li>왼쪽 메뉴판에서 <strong>[Agents & AI]</strong>를 찾아서 클릭하세요.</li>
<li>화면을 조금 내리면 나오는 스위치를 클릭해서 <strong>초록색(On)</strong>으로 켜주세요.</li>
<li><div class="memo">💡 <strong>이걸 왜 하나요?</strong> 로봇이 내가 한 말을 까먹지 않고, 쓰레드(답글) 방식으로 이어서 대화할 수 있게 해주는 마법의 버튼입니다.</div></li>
</ul>
</div>

<div class="step-box">
<div class="step-title">4단계: 로봇에게 초능력(권한) 12개 주기</div>
<ul class="instruction-list">
<li>왼쪽 메뉴판에서 <strong>[OAuth & Permissions]</strong>를 클릭하세요.</li>
<li>화면을 아래로 쭈~욱 내리다 보면 <strong>[Scopes]</strong>라는 구역이 나옵니다.</li>
<li>거기서 <strong>[Bot Token Scopes]</strong> 밑에 있는 <strong>[Add an OAuth Scope]</strong> 버튼을 누르세요.</li>
<li>검색창이 나오면 아래 표에 있는 <strong>12개의 단어</strong>를 하나씩 검색해서 클릭해주세요. (총 12개가 추가되어야 합니다!)</li>
</ul>

<table class="scope-table">
<thead>
<tr>
<th>검색해야 할 단어 (권한)</th>
<th>이게 무슨 능력이죠? (설명)</th>
</tr>
</thead>
<tbody>
<tr><td><code>chat:write</code></td><td>말을 할 수 있는 능력 🗣</td></tr>
<tr><td><code>im:history</code><br><code>im:read</code><br><code>im:write</code></td><td>나랑 단둘이 비밀채팅(DM)을 할 수 있는 능력 💌</td></tr>
<tr><td><code>channels:history</code><br><code>channels:read</code></td><td>공개 단체방에서 대화를 들을 수 있는 능력 👂</td></tr>
<tr><td><code>groups:history</code><br><code>groups:read</code></td><td>비공개 단체방에서 대화를 들을 수 있는 능력 🤫</td></tr>
<tr><td><code>app_mentions:read</code></td><td>누군가 "@로봇이름" 하고 나를 부르면 알아채는 능력 🙋‍♂️</td></tr>
<tr><td><code>files:read</code><br><code>files:write</code></td><td>사진이나 문서를 주고받을 수 있는 능력 📦</td></tr>
<tr><td><code>assistant:write</code></td><td>자동으로 추가되는 AI 도우미 권한 🤖</td></tr>
</tbody>
</table>
</div>

<h2>👂 4교시: 로봇의 귀 열어주기</h2>
<div class="step-box">
<div class="step-title">5단계: 사람들이 말 거는 걸 알아채게 하기 (Event)</div>
<ul class="instruction-list">
<li>왼쪽 메뉴판에서 <strong>[Event Subscriptions]</strong>를 클릭하세요.</li>
<li>맨 위에 있는 스위치(Enable Events)를 <strong>On</strong>으로 켜주세요.</li>
<li><strong>[Subscribe to bot events]</strong> 구역에서 아래 4가지를 추가하세요:
<br>👉 <code>app_mention</code>, <code>message.channels</code>, <code>message.groups</code>, <code>message.im</code>
</li>
<li><div class="warning-box">🚨 중요! 화면 맨 아래에 있는 초록색 <strong>[Save Changes]</strong> 버튼을 꼭 누르세요!</div></li>
</ul>
</div>

<h2>🎉 마지막 교시: 슬랙 마을에 입장하기!</h2>
<div class="step-box">
<div class="step-title">6단계: 로봇 설치하고 두 번째 비밀번호 받기</div>
<ul class="instruction-list">
<li>왼쪽 메뉴판에서 다시 <strong>[OAuth & Permissions]</strong>로 가세요.</li>
<li>화면 맨 위에 있는 <strong>[Install to Workspace]</strong> 버튼을 누르고 <strong>[허용]</strong>을 누르세요.</li>
<li>화면에 나타난 <code>xoxb-</code> 로 시작하는 <strong>봇 토큰(Bot Token)</strong>을 복사해서 메모장에 저장하세요!</li>
</ul>

<div class="memo">
🎈 <strong>축하합니다! 이제 모든 준비가 끝났습니다.</strong><br>
이제 메모장의 두 비밀번호를 <a href="https://cloudtype.io" target="_blank" style="color: #1264a3; font-weight: bold;">클라우드타입</a> 설정창에 입력하러 가볼까요?
</div>
</div>
</div>
</div>

# Automation Prompt Any Website

```
You are a senior automation engineer and backend analyst.

I will provide you with a WEBSITE URL.
Your task is to automatically analyze the website and generate a
FULL NPM AUTOMATION BOT with complete scripts and setup instructions.

Website URL: <PASTE WEBSITE URL HERE>

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
OBJECTIVES (YOU MUST DO ALL):
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

1️⃣ WEBSITE ANALYSIS
- Identify website type (Web2 / Web3 / Hybrid)
- Detect authentication method:
  - Wallet signature (EVM)
  - Email / OTP
  - Session / Cookie
  - OAuth (Google / Twitter / Discord)
- Detect anti-bot protection:
  - None
  - Rate limiting
  - Captcha / Cloudflare
- Decide if automation is possible via API-only or requires browser support

2️⃣ API DISCOVERY & MAPPING
- Identify the Base API URL
- Detect endpoints for:
  - Login / Authentication
  - Fetching tasks
  - Claiming / completing tasks
  - Daily tasks
  - Referral submission
- Identify required headers:
  - User-Agent
  - Origin
  - Referer
  - Authorization (Bearer / Token)

3️⃣ AUTOMATION STRATEGY
- Choose the best strategy:
  - API-only (Axios-based)
  - Hybrid (API + minimal browser)
  - Browser-required (if unavoidable)
- Clearly explain WHY this strategy is chosen

4️⃣ FULL NPM PROJECT GENERATION
Generate a complete Node.js (NPM) project including:
- package.json
- index.js (CLI menu, runs with `npm start`)
- config.js (site-specific adapter)
- Authentication module (self login method)
- Auto task & daily task automation
- Auto referral generation / submission
- Proxy support:
  - Proxy OPTIONAL
  - Auto-detect HTTP / HTTPS / SOCKS
  - Random proxy usage if proxy.txt exists
  - Direct connection if no proxy is provided
- Error handling & retry logic
- VPS-safe (no GUI required)

5️⃣ STEP-BY-STEP SETUP GUIDE
- Node.js & dependency installation
- npm install commands
- proxy.txt usage (optional)
- How to run the bot
- Example output

6️⃣ LIMITATIONS & ASSUMPTIONS
- Clearly mention:
  - Any assumptions made
  - Which parts are fully automatable
  - Which parts cannot be automated (if any)
  - When browser automation would be required

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
STRICT RULES:
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
- Do NOT blindly guess API endpoints
- Clearly mark placeholders where confirmation is needed
- Do NOT include illegal or unethical instructions
- Prefer API-only automation whenever possible
- Proxy usage must be OPTIONAL and safe
- Code must be production-ready and modular

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
OUTPUT FORMAT (MANDATORY):
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
1. Website Analysis Summary
2. API Mapping Table
3. Automation Strategy Decision
4. Full NPM Automation Project (All Files)
5. Step-by-Step Setup & Run Guide
6. Limitations, Assumptions & Notes
```

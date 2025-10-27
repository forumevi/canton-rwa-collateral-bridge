# Instant RWA Collateral Bridge (Canton + Daml)

A hackathon-ready MVP that demonstrates **Canton** domain composability using **Daml** smart contracts, a **JSON Ledger API** TypeScript client, and optional **PQS** for SQL-based analytics.

## Highlights
- CIP-0056-inspired fungible token
- Collateral lock + borrow + repay flow
- Two domains / multiple participants (IssuerDomain, LendingDomain)
- JSON API client (TypeScript) for demo interactions
- Optional PQS for SQL analytics dashboards

---

## Project Structure
```
canton-rwa-collateral-bridge/
├─ daml/                     # Daml sources & daml.yaml
├─ canton/                   # Canton config & runner script
├─ api/                      # TypeScript JSON API client & flows
├─ ui/                       # (Optional) Frontend placeholder
├─ pqs/                      # (Optional) PQS docker & SQL queries
└─ README.md
```

## Prerequisites
- Daml SDK 3.3.x
- Canton
- Node.js 18+
- (Optional) Docker (for PQS/Postgres)

---

## Quickstart

### 1) Build Daml package (DAR)
```bash
cd daml
daml build
```

### 2) Start Canton (sample multi-domain topology)
```bash
cd ../canton
./run-canton.s
```

> The script shows the idea; adapt ports/participants per your environment.

### 3) Start JSON API
```bash
daml json-api   --ledger-host localhost --ledger-port 7131   --http-port 7575 --allow-insecure-tokens
```

### 4) Run TypeScript demo flows
```bash
cd ../api
npm install
npm run demo
```

### 5) (Optional) Start PQS & run SQL
```bash
cd ../pqs
docker compose up -d
# open a SQL client to the Postgres at localhost:5432 (user/pass: pqs/pqs)
# and run queries.sql
```

---

## Demo Scenario (3–5 min)
1. **Mint:** Issuer mints USDx to Alice
2. **Lock:** Alice locks 500 USDx as collateral in Lender vault
3. **Borrow:** Lender offers 200 USDx; Alice accepts; lender disburses
4. **PQS Panel (optional):** query active loans, collateral, LTV in SQL
5. **Repay (optional):** repay & release collateral

---

## Notes
- The Token model is simplified for demo purposes (CIP-0056-inspired). Extend with metadata/allowance/partitioning if needed.
- The Canton runner is a *template*—you may adjust ports/participants and wire to your setup.
- For production-like atomic cross-domain demos, integrate Global Synchronizer in a follow-up iteration.

Good luck and have fun!

---

## ▶️ One-Click Demo Options

### Option A — GitHub Codespaces (no local install)
1. Open this repo in GitHub and click **Code → Create codespace on main**.
2. Install **Daml SDK** inside Codespaces shell (or use your own prebuilt image).
3. Run:
   ```bash
   cd daml && daml build
   daml start            # Starts Canton, JSON API, Navigator (port 7575)
   ```
4. Forward the **JSON API** port (7575) publicly.
5. Open **Vercel UI** (see below) and paste the forwarded URL as `JSON API URL`.

### Option B — Vercel (Frontend only)
This repo includes a static demo UI under `/ui`. You can deploy it to Vercel:

1. Import this GitHub repo in **Vercel**.
2. Build output is static; no build command required.
3. After deploy, open the app, set **JSON API URL** (your Codespaces public URL), and click **Run Demo**.

> Note: Vercel/Netlify cannot run Canton or the JSON API server themselves. They host the UI; backend runs in Codespaces/VM.

---

## 🔐 CORS / Connectivity Notes
- The JSON API must be reachable from the browser (public URL) and allow the browser to send requests.
- If you see CORS errors, configure the JSON API with appropriate headers or run it via Codespaces public URL (which typically sets permissive headers for your session).

---

## 🧩 Scripts
- **Build Daml**: `cd daml && daml build`
- **Start Ledger Stack**: `daml start` (spins up sandbox/Canton + JSON API + Navigator)
- **TypeScript Demo**: `cd api && npm install && npm run build && npm run demo`

---

## 🏁 Hackathon Submission Summary
**Project:** Instant RWA Collateral Bridge  
**Stack:** Daml 3.3.x, Canton, JSON API (TypeScript), (optional) PQS  
**Value:** Atomic, privacy-preserving cross-domain collateral and borrowing  
**Demo:** Mint → Lock → Borrow → (Repay)

---

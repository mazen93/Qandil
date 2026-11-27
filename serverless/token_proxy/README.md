# Qandil — Quran Foundation OAuth2 Token Proxy (Cloudflare Workers)

This Cloudflare Worker exchanges `client_id` and `client_secret` for short-lived Quran Foundation OAuth2 `client_credentials` tokens (`https://prelive-oauth2.quran.foundation/oauth2/token` in pre-production, `https://oauth2.quran.foundation/oauth2/token` in production).

It ensures **`client_secret` is never embedded in the Flutter app binary**.

---

## 1. Prerequisites
- Node.js 18+ installed
- A Cloudflare account
- Quran Foundation Pre-Production / Production `client_id` and `client_secret` from the [Quran Foundation Developer Portal](https://api-docs.quran.foundation)

---

## 2. Local Development & Testing

```bash
cd ~/flutter_projects/qandil/serverless/token_proxy

# Create a local .dev.vars file (gitignored, never committed!)
cat << 'EOF' > .dev.vars
QF_CLIENT_ID="your_prelive_client_id"
QF_CLIENT_SECRET="your_prelive_client_secret"
EOF

# Start local Cloudflare Worker dev server on http://127.0.0.1:8787
npx wrangler dev
```

Test the local endpoint:
```bash
curl -X POST http://127.0.0.1:8787/api/v1/token
```

Expected response:
```json
{
  "accessToken": "eyJhbGciOi...",
  "clientId": "your_prelive_client_id",
  "tokenType": "bearer",
  "expiresIn": 3599,
  "expiresAt": "2026-11-26T12:30:00.000Z"
}
```

---

## 3. Production Deployment to Cloudflare Workers

```bash
cd ~/flutter_projects/qandil/serverless/token_proxy

# 1. Authenticate with Cloudflare
npx wrangler login

# 2. Store your Quran Foundation credentials as encrypted Worker secrets
npx wrangler secret put QF_CLIENT_ID
npx wrangler secret put QF_CLIENT_SECRET

# 3. Deploy the Worker
npx wrangler deploy
```

After deployment, Wrangler prints your Worker URL (e.g., `https://qandil-quran-token-proxy.<your-subdomain>.workers.dev`).

Set `TOKEN_PROXY_URL` in `config/env.dev.json` / `config/env.prod.json` to:
```json
"TOKEN_PROXY_URL": "https://qandil-quran-token-proxy.<your-subdomain>.workers.dev/api/v1/token"
```

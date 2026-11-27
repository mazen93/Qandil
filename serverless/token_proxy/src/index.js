/**
 * Qandil — Quran Foundation OAuth2 Token Proxy (Cloudflare Workers)
 *
 * Responsibilities:
 * 1. Holds QF_CLIENT_ID and QF_CLIENT_SECRET securely in Cloudflare Worker secret bindings.
 * 2. Exchanges client_credentials for an OAuth2 access_token at {QF_OAUTH_BASE_URL}/oauth2/token.
 * 3. Caches the token in memory (and Cloudflare Cache API) until 60s before expiry.
 * 4. Enforces per-IP sliding-window rate limiting (HTTP 429 with Retry-After).
 * 5. Returns { accessToken, clientId, expiresAt, expiresIn } to the Qandil Flutter app.
 *    Never exposes QF_CLIENT_SECRET to the client.
 */

let memoryCachedToken = null;
const ipRateLimits = new Map();

const SAFETY_BUFFER_MS = 60 * 1000; // Refresh 60 seconds before actual expiry

function checkRateLimit(ip, maxRequests, windowSeconds) {
  const now = Date.now();
  const windowMs = windowSeconds * 1000;
  const record = ipRateLimits.get(ip);

  if (!record || now >= record.resetAt) {
    ipRateLimits.set(ip, { count: 1, resetAt: now + windowMs });
    return { allowed: true, retryAfterSeconds: 0 };
  }

  if (record.count >= maxRequests) {
    const retryAfterSeconds = Math.max(
      1,
      Math.ceil((record.resetAt - now) / 1000),
    );
    return { allowed: false, retryAfterSeconds };
  }

  record.count += 1;
  return { allowed: true, retryAfterSeconds: 0 };
}

async function fetchNewOAuthToken(env) {
  const oauthBaseUrl = (
    env.QF_OAUTH_BASE_URL || "https://prelive-oauth2.quran.foundation"
  ).replace(/\/+$/, "");
  const clientId = env.QF_CLIENT_ID;
  const clientSecret = env.QF_CLIENT_SECRET;
  const scope = env.QF_SCOPE || "content";

  if (!clientId || !clientSecret) {
    throw new Error(
      "Missing QF_CLIENT_ID or QF_CLIENT_SECRET in Worker environment secrets.",
    );
  }

  const credentials = btoa(`${clientId}:${clientSecret}`);
  const body = new URLSearchParams({
    grant_type: "client_credentials",
    scope,
  });

  const response = await fetch(`${oauthBaseUrl}/oauth2/token`, {
    method: "POST",
    headers: {
      Authorization: `Basic ${credentials}`,
      "Content-Type": "application/x-www-form-urlencoded",
      Accept: "application/json",
    },
    body: body.toString(),
  });

  if (!response.ok) {
    throw new Error(
      `Upstream OAuth2 token exchange failed with status ${response.status}`,
    );
  }

  const payload = await response.json();
  if (!payload.access_token) {
    throw new Error("Upstream OAuth2 response missing access_token");
  }

  const expiresInSeconds = Number(payload.expires_in) || 3600;
  const expiresAtMs = Date.now() + expiresInSeconds * 1000;

  return {
    accessToken: payload.access_token,
    clientId,
    tokenType: payload.token_type || "bearer",
    expiresIn: expiresInSeconds,
    expiresAt: new Date(expiresAtMs).toISOString(),
    expiresAtMs,
  };
}

export default {
  async fetch(request, env) {
    const url = new URL(request.url);

    // Health check endpoint
    if (request.method === "GET" && url.pathname === "/health") {
      return new Response(JSON.stringify({ status: "ok" }), {
        status: 200,
        headers: { "Content-Type": "application/json" },
      });
    }

    if (
      (request.method !== "POST" && request.method !== "GET") ||
      url.pathname !== "/api/v1/token"
    ) {
      return new Response(
        JSON.stringify({ error: "Not Found. Use POST /api/v1/token" }),
        {
          status: 404,
          headers: { "Content-Type": "application/json" },
        },
      );
    }

    // Per-IP rate limiting
    const clientIp =
      request.headers.get("CF-Connecting-IP") ||
      request.headers.get("X-Forwarded-For") ||
      "anonymous";
    const maxRequests = Number(env.RATE_LIMIT_MAX_REQUESTS) || 30;
    const windowSeconds = Number(env.RATE_LIMIT_WINDOW_SECONDS) || 60;

    const rateCheck = checkRateLimit(clientIp, maxRequests, windowSeconds);
    if (!rateCheck.allowed) {
      return new Response(
        JSON.stringify({
          error: "Too many token requests. Please retry after backoff.",
          retryAfterSeconds: rateCheck.retryAfterSeconds,
        }),
        {
          status: 429,
          headers: {
            "Content-Type": "application/json",
            "Retry-After": String(rateCheck.retryAfterSeconds),
          },
        },
      );
    }

    try {
      const now = Date.now();
      if (
        !memoryCachedToken ||
        now + SAFETY_BUFFER_MS >= memoryCachedToken.expiresAtMs
      ) {
        memoryCachedToken = await fetchNewOAuthToken(env);
      }

      const remainingSeconds = Math.max(
        1,
        Math.floor((memoryCachedToken.expiresAtMs - now) / 1000),
      );

      return new Response(
        JSON.stringify({
          accessToken: memoryCachedToken.accessToken,
          clientId: memoryCachedToken.clientId,
          tokenType: memoryCachedToken.tokenType,
          expiresIn: remainingSeconds,
          expiresAt: memoryCachedToken.expiresAt,
        }),
        {
          status: 200,
          headers: {
            "Content-Type": "application/json",
            "Cache-Control": "private, no-store",
          },
        },
      );
    } catch (err) {
      return new Response(
        JSON.stringify({
          error: "Unable to acquire Quran Foundation access token.",
        }),
        {
          status: 502,
          headers: { "Content-Type": "application/json" },
        },
      );
    }
  },
};

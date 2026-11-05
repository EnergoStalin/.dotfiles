---
mode: "subagent"
model: "openai/gpt-6-luna#low"
description: "Performs web searches and online research, returning sources and concise findings."
permissions:
  - action: "*"
    resource: "*"
    effect: deny
  - action: "read"
    resource: "*"
    effect: allow
  - action: "read"
    resource: "*.env"
    effect: ask
  - action: "read"
    resource: "*.env.*"
    effect: ask
  - action: "read"
    resource: "*.env.example"
    effect: allow
  - action: "glob"
    resource: "*"
    effect: allow
  - action: "grep"
    resource: "*"
    effect: allow
  - action: "skill"
    resource: "*"
    effect: allow
  - action: "execute"
    resource: "*"
    effect: allow
  - action: "websearch"
    resource: "*"
    effect: allow
  - action: "webfetch"
    resource: "*"
    effect: allow
  - action: "search_gateway_searxng_*"
    resource: "*"
    effect: allow
  - action: "search_gateway_web_url_read"
    resource: "*"
    effect: allow
  - action: "searxng_searxng_*"
    resource: "*"
    effect: allow
  - action: "searxng_web_url_read"
    resource: "*"
    effect: allow
---

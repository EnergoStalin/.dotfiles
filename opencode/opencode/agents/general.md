---
model: "openai/gpt-6.1-terra#medium"
description: "Implements general coding and multi-step tasks delegated by the primary agent."
permissions:
  - action: "execute"
    resource: "*"
    effect: allow
  - action: "websearch"
    resource: "*"
    effect: allow
  - action: "webfetch"
    resource: "*"
    effect: allow
  - action: "search_gateway_*"
    resource: "*"
    effect: deny
  - action: "searxng_*"
    resource: "*"
    effect: deny
---

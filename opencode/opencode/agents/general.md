---
model: "openai/gpt-6.1-terra#medium"
description: "Implements general coding and multi-step tasks delegated by the primary agent."
permissions:
  - action: "execute"
    resource: "*"
    effect: allow
  - action: "websearch"
    resource: "*"
    effect: deny
  - action: "webfetch"
    resource: "*"
    effect: allow
  - action: "searxng_*"
    resource: "*"
    effect: allow
---

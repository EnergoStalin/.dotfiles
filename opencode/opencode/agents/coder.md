---
mode: "subagent"
model: "openai/gpt-6.1-sol#medium"
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

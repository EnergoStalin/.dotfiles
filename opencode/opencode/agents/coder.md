---
mode: "subagent"
model: "openai/gpt-6.1-sol#medium"
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

---
model: "openai/gpt-6-luna#low"
description: "Investigates codebases and traces implementation details, returning relevant file and line references."
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
  - action: "external_directory"
    resource: "*"
    effect: allow
  - action: "glob"
    resource: "*"
    effect: allow
  - action: "grep"
    resource: "*"
    effect: allow
  - action: "shell"
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
  - action: "search_gateway_*"
    resource: "*"
    effect: deny
  - action: "searxng_*"
    resource: "*"
    effect: deny
---

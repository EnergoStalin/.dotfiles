---
mode: "subagent"
model: "openai/gpt-6-luna#low"
description: "Makes simple, low-complexity code patches, including scoped file deletion and rearrangement."
permissions:
  - action: "search_gateway_*"
    resource: "*"
    effect: deny
  - action: "searxng_*"
    resource: "*"
    effect: deny
---

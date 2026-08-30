# Repository agent instructions

This repository contains the published Elm worker plus Node bridge deterministic runtime.

- Preserve the CLI, port, and normalized JSON contract.
- Keep full dedicated classic-six + modern-core behavior and grouped fallbacks.
- Keep provider flags fail-fast until the provider rollout reaches Elm.
- Validate both Elm compilation and Node port execution; Docker is the portable runtime gate.

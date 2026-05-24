# Toolchain

Elm native validation uses Homebrew `elm` plus an existing local Node runtime for the port runner.

## Proven commands

- `elm --version`
- `node --version`
- `elm make src/Main.elm --output=dist/stakeholder.js`
- `make compiler-proof`
- `make test`

Toolchain source: Homebrew bottled `elm` 0.19.1 and existing Node. Docker, Nix, and npm packages are not required for the current deterministic first tranche.

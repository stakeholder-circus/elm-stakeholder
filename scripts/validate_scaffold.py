#!/usr/bin/env python3
from pathlib import Path

REQUIRED = [
    "AGENTS.md", "README.md", "STATUS.md", "GAPS.md", "PARITY.md",
    "AI_DISCLOSURE.md", "docs/remotes.md", "docs/provenance.md",
    "docs/toolchain.md", "docs/traceability/first-push-families.md",
    "scripts/validate_scaffold.py", "flake.nix", "Dockerfile", "Makefile",
    "elm.json", "package.json", "package-lock.json", "src/Main.elm",
    "bin/stakeholder.mjs", "tests/test_cli.sh",
    ".github/dependabot.yml", ".github/workflows/actionlint.yml",
    ".github/workflows/ci.yml", ".github/workflows/ci-native.yml",
    ".github/workflows/dependency-review.yml", ".github/workflows/docker-smoke.yml",
    ".github/workflows/sast.yml", ".github/workflows/security-analysis.yml",
]
missing = [path for path in REQUIRED if not Path(path).exists()]
if missing:
    for path in missing:
        print(f"missing Elm deterministic tranche file: {path}")
    raise SystemExit(1)
print("Elm deterministic tranche files present; run native and Docker validation")

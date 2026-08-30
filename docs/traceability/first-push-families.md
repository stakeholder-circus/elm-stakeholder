# Deterministic tranche traceability

| Group | Elm path | Source | Class |
| --- | --- | --- | --- |
| classic-six | src/Main.elm | Rust/Java canonical contract | dedicated |
| modern-core | src/Main.elm | Rust/Java canonical contract | dedicated |
| later families | src/Main.elm | grouped fallback policy | grouped fallback |
| CLI | src/Main.elm, bin/stakeholder.mjs, tests/test_cli.sh | stakeholder-core contract | deterministic |
| provider | src/Main.elm, tests/test_cli.sh | provider isolation policy | explicit fail-fast |

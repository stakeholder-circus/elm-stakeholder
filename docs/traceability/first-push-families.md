# First push families

This local tranche ports the deterministic family-focus contract into an Elm worker runtime with a Node CLI bridge.

| Family group | Elm path | Source reference | Parity class |
| --- | --- | --- | --- |
| classic-six | `src/Main.elm` | current deterministic CLI family registry and smoke-contract shape | dedicated |
| modern-core | `src/Main.elm` | current deterministic CLI family registry and smoke-contract shape | dedicated |
| later families | `src/Main.elm` | grouped fallback policy in current deterministic repos | grouped fallback |
| CLI contract | `src/Main.elm`, `bin/stakeholder.mjs`, `tests/test_cli.sh` | small-tranche smoke contract | deterministic |
| experimental provider | `src/Main.elm`, `tests/test_cli.sh` | fail-fast provider policy in current deterministic repos | explicit fail-fast |

Rust and Java remain canonical behavioral anchors; this Elm tranche is local-only and native-validated.

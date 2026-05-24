# Docker validation is intentionally deferred for this M1-safe local Elm tranche.
# The native validation lane uses Homebrew Elm plus local Node on macOS.
FROM alpine:3.20
CMD ["sh", "-c", "echo 'Docker validation deferred for elm-stakeholder'; exit 1"]

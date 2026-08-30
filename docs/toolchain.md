# Toolchain

- Native CI: pinned actions/setup-node v6, Node 24, and elm npm package 0.19.2-0.
- Docker: Node 24 Bookworm multi-stage build, non-root final runtime.
- macOS feedback may use Homebrew Elm and local Node.
- GitHub and Docker provide release evidence; Nix remains a development-shell surface.

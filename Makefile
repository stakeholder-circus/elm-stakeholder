ELM ?= elm
NODE ?= node

.PHONY: all compiler-proof analyze build test
all: build

compiler-proof:
	$(ELM) --version
	$(NODE) --version

analyze:
	$(ELM) make src/Main.elm --output=/tmp/elm-stakeholder-analyze.js

build:
	mkdir -p dist
	$(ELM) make src/Main.elm --output=dist/stakeholder.js

test: build
	NODE=$(NODE) BIN=bin/stakeholder.mjs tests/test_cli.sh

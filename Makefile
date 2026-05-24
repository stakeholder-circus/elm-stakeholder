ELM ?= elm
NODE ?= node

.PHONY: all compiler-proof build test clean

all: build

compiler-proof:
	$(ELM) --version
	$(NODE) --version

build:
	mkdir -p dist
	$(ELM) make src/Main.elm --output=dist/stakeholder.js

test: build
	NODE=$(NODE) BIN=bin/stakeholder.mjs tests/test_cli.sh

clean:
	rm -rf dist elm-stuff

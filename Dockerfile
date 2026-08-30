FROM node:24-bookworm-slim AS build
RUN apt-get update \
    && apt-get install --yes --no-install-recommends ca-certificates \
    && find /var/lib/apt/lists -mindepth 1 -delete \
    && npm install --global elm@0.19.1-6
WORKDIR /app
COPY elm.json elm.json
COPY src src
COPY bin bin
COPY tests tests
COPY Makefile Makefile
RUN mkdir -p dist \
    && elm make src/Main.elm --output=dist/stakeholder.js \
    && NODE=node BIN=bin/stakeholder.mjs tests/test_cli.sh
FROM node:24-bookworm-slim
WORKDIR /app
COPY --from=build /app/dist dist
COPY --from=build /app/bin bin
USER node
ENTRYPOINT ["node", "bin/stakeholder.mjs"]
CMD ["--list-values"]

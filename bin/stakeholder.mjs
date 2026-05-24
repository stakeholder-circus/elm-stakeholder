#!/usr/bin/env node
import { createRequire } from 'node:module';

const require = createRequire(import.meta.url);
const { Elm } = require('../dist/stakeholder.js');

let exitCode = 0;
const app = Elm.Main.init({ flags: process.argv.slice(2) });
app.ports.output.subscribe((message) => {
  process.stdout.write(`${message}\n`);
  setTimeout(() => process.exit(exitCode), 0);
});
app.ports.error.subscribe((message) => {
  exitCode = 2;
  process.stderr.write(`${message}\n`);
  setTimeout(() => process.exit(exitCode), 0);
});

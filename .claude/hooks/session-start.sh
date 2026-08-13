#!/bin/bash
set -euo pipefail

if [ "${CLAUDE_CODE_REMOTE:-}" != "true" ]; then
  exit 0
fi

cd "$CLAUDE_PROJECT_DIR/frontend"
npm install

if ! command -v javac >/dev/null 2>&1 || ! javac -version 2>&1 | tail -1 | grep -q '^javac 17\.'; then
  if ! dpkg -s openjdk-17-jdk-headless >/dev/null 2>&1; then
    apt-get update -qq
    apt-get install -y -qq openjdk-17-jdk-headless
  fi
fi

cd "$CLAUDE_PROJECT_DIR/qrorder"
./gradlew -q compileTestJava

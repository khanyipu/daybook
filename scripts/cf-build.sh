#!/usr/bin/env bash
# Build script for Cloudflare Workers Builds: compiles the Daybook CLI
# from this repository's source (so deployments always use this fork's
# code), then generates the static site into ./public.
set -euo pipefail

GO_VERSION="1.26.4"

if ! command -v go >/dev/null 2>&1; then
  echo "==> Installing Go ${GO_VERSION} toolchain"
  mkdir -p /tmp/go-toolchain
  curl -fsSL "https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz" | tar -C /tmp/go-toolchain --strip-components=1 -xz
  export PATH="/tmp/go-toolchain/bin:$PATH"
fi

echo "==> Building Daybook CLI ($(go version))"
go build -o ./bin/daybook ./cmd/daybook

echo "==> Building site"
./bin/daybook build

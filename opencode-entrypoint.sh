#!/usr/bin/env bash
set -euo pipefail

exec opencode web --hostname "$OPENCODE_HOSTNAME" --port "$OPENCODE_PORT"

#!/usr/bin/env bash
set -euo pipefail

echo "build.sh is a compatibility wrapper; use 'mise run build'." >&2
exec mise run build

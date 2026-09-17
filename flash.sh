#!/usr/bin/env bash
set -euo pipefail

echo "flash.sh is a compatibility wrapper; use 'mise run flash'." >&2
exec mise run flash

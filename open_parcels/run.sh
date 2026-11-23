#!/bin/bash
# Turns the app's options into Open Parcels' environment and starts the server.
set -euo pipefail

OPTIONS=/data/options.json

# Prints one option; a missing or unreadable options.json stops the start with a clear message.
option() {
  node -e '
    const value = require(process.argv[1])[process.argv[2]];
    if (value !== undefined && value !== null) process.stdout.write(String(value));
  ' "$OPTIONS" "$1"
}

if [[ ! -r "$OPTIONS" ]]; then
  echo "Open Parcels: $OPTIONS is missing or unreadable." >&2
  exit 1
fi

LOG_LEVEL="$(option log_level)"
PUBLIC_URL="$(option public_url)"
QUIET_WINDOW="$(option quiet_window)"

if [[ -n "$LOG_LEVEL" ]]; then export OPENPARCELS_LOG_LEVEL="$LOG_LEVEL"; fi
if [[ -n "$PUBLIC_URL" ]]; then export OPENPARCELS_PUBLIC_URL="$PUBLIC_URL"; fi
if [[ -n "$QUIET_WINDOW" ]]; then export OPENPARCELS_QUIET_WINDOW="$QUIET_WINDOW"; fi
# Home Assistant passes its own time zone.
if [[ -n "${TZ:-}" ]]; then export OPENPARCELS_TIMEZONE="$TZ"; fi

# /data is the app's persistent folder (backed up with Home Assistant); options.json sits there
# too, so Open Parcels keeps its database and key in a folder of its own.
export OPENPARCELS_DATA_DIR=/data/open-parcels
mkdir -p "$OPENPARCELS_DATA_DIR"

exec node /app/server/dist/main.js

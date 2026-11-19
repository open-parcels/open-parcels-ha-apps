#!/bin/sh
# Turns the app's options into Open Parcels' environment and starts the server.
set -eu

OPTIONS=/data/options.json

option() {
  node -e '
    try {
      const value = require(process.argv[1])[process.argv[2]];
      if (value !== undefined && value !== null) process.stdout.write(String(value));
    } catch {}
  ' "$OPTIONS" "$1"
}

LOG_LEVEL="$(option log_level)"
PUBLIC_URL="$(option public_url)"
QUIET_WINDOW="$(option quiet_window)"

[ -n "$LOG_LEVEL" ] && export OPENPARCELS_LOG_LEVEL="$LOG_LEVEL"
[ -n "$PUBLIC_URL" ] && export OPENPARCELS_PUBLIC_URL="$PUBLIC_URL"
[ -n "$QUIET_WINDOW" ] && export OPENPARCELS_QUIET_WINDOW="$QUIET_WINDOW"
# Home Assistant passes its own time zone.
[ -n "${TZ:-}" ] && export OPENPARCELS_TIMEZONE="$TZ"

# /data is the app's persistent folder (backed up with Home Assistant); options.json sits there
# too, so Open Parcels keeps its database and key in a folder of its own.
export OPENPARCELS_DATA_DIR=/data/open-parcels
mkdir -p "$OPENPARCELS_DATA_DIR"

exec node /app/server/dist/main.js

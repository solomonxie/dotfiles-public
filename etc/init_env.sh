#!/usr/bin/env bash
# Create/complete .env: prompt for each missing required value.
set -eu
ENV_FILE="${1:-.env}"
touch "$ENV_FILE"

default_for() {
  case "$1" in
    DEVICE_USERNAME) id -un ;;
  esac
}

for key in DEVICE_USERNAME; do
  grep -Eq "^$key=.+" "$ENV_FILE" && continue
  [ -t 0 ] || { echo "missing $key in $ENV_FILE and no TTY to ask" >&2; exit 1; }
  def="$(default_for "$key")"
  read -r -p "$key${def:+ [$def]}: " val
  val="${val:-$def}"
  [ -n "$val" ] || { echo "$key is required" >&2; exit 1; }
  sed -i '' "/^$key=/d" "$ENV_FILE"
  echo "$key=$val" >> "$ENV_FILE"
done

set -a; . "$ENV_FILE"; set +a
[ "$DEVICE_USERNAME" = "$(id -un)" ] || { echo "DEVICE_USERNAME=$DEVICE_USERNAME but logged in as $(id -un)" >&2; exit 1; }

#!/bin/bash
set -euo pipefail

echo "=== Bootstrap: users + filesystem + permissions ==="

STEAM_GROUP="steam-admin"
STEAM_USER="nathan"

# --- users / groups ---
groupadd -f "$STEAM_GROUP"
usermod -aG "$STEAM_GROUP" "$STEAM_USER"

# --- filesystem layout ---
mkdir -p /srv/steam
mkdir -p /srv/scripts/config
mkdir -p /mnt/backups

# --- ownership ---
chown -R "$STEAM_USER:$STEAM_GROUP" /mnt/backups

# --- permissions ---
find /mnt/backups -type d -exec chmod 770 {} \;

find /srv/scripts -type f -name "*.sh" -exec chmod 755 {} \;
find /srv/scripts/config -type f -name "*.conf" -exec chmod 600 {} \;

echo "Bootstrap complete"

#!/bin/bash
set -euo pipefail

echo "=== Systemd install ==="

# install units
cp ./systemd/*.service /etc/systemd/system/ 2>/dev/null || true
cp ./systemd/*.timer /etc/systemd/system/ 2>/dev/null || true

# reload systemd
systemctl daemon-reload

# enable timers
systemctl enable --now game-backup.timer || true
systemctl enable --now game-update.timer || true

# Add game services here
systemctl enable .service || true

echo "Systemd install complete"

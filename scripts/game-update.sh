#!/bin/bash
set -euo pipefail

update_game() {
    CONFIG="$1"

    source "$CONFIG"

    echo "Stopping ${GAME}"
    systemctl stop "${SERVICE}"

    echo "Updating ${GAME}"
    sudo -u "${STEAM_USER}" /srv/steam/steamcmd.sh \
        +login anonymous \
        +force_install_dir "${INSTALL_DIR}" \
        +app_update "${APPID}" validate \
        +quit

    echo "Starting ${GAME}"
    systemctl start "${SERVICE}"

    echo "${GAME} update complete"
    echo
}

for CONFIG in /srv/scripts/config/*.conf; do
    update_game "$CONFIG"
done

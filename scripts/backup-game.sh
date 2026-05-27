#!/bin/bash
set -euo pipefail

backup_game() {
    CONFIG="$1"

    source "$CONFIG"

    TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
    ARCHIVE="${BACKUP_DEST}/${GAME}_${TIMESTAMP}.tar.gz"

    mkdir -p "${BACKUP_DEST}"

    echo "Stopping ${SERVICE}"
    systemctl stop "${SERVICE}"

    echo "Creating backup for ${GAME}"
    tar -czf "${ARCHIVE}" -C "${BACKUP_PATH}" .

    echo "Starting ${SERVICE}"
    systemctl start "${SERVICE}"

    echo "Cleaning backups older than ${RETENTION_DAYS} days"
    find "${BACKUP_DEST}" \
        -type f \
        -name "${GAME}_*.tar.gz" \
        -mtime +"${RETENTION_DAYS}" \
        -delete

    echo "${GAME} backup complete"
    echo
}

for CONFIG in /srv/scripts/config/*.conf; do
    backup_game "$CONFIG"
done

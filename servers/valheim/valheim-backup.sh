#!/bin/sh
set -eu

WORLD_NAME="spezpocket"
SRC_DIR="/home/steam/.config/unity3d/IronGate/Valheim/worlds_local"
BACKUP_DIR="/home/steam/backups/valheim"
RETENTION_MINUTES=$((2 * 24 * 60))  # 2 days

mkdir -p "$BACKUP_DIR"

files=$(cd "$SRC_DIR" && ls -1 "${WORLD_NAME}".* 2>/dev/null)
if [ -z "$files" ]; then
    echo "No world files found for ${WORLD_NAME} in ${SRC_DIR}" >&2
    exit 1
fi

timestamp=$(date +%Y%m%d-%H%M%S)
archive="${BACKUP_DIR}/${WORLD_NAME}_${timestamp}.tar.gz"

tar -czf "$archive" -C "$SRC_DIR" $files

find "$BACKUP_DIR" -name "${WORLD_NAME}_*.tar.gz" -mmin +"$RETENTION_MINUTES" -delete

sudo chown steam:steam /usr/local/bin/valheim-backup.sh
sudo chmod 750 /usr/local/bin/valheim-backup.sh
#!/bin/bash

# Configuration
SOURCE_DIR="/var/lib/docker/volumes/6294b4fcb4708da7980db564c478738eee8b2a0b4b291b8f77ed81c2a54110f1/_data/data/user/files/TOIP"
BACKUP_DIR="/archive"
LOG_FILE="/var/log/backup_toi.log"
FTP_SERVER="192.168.20.32"
FTP_USER="ftpuser"
FTP_PASS="azerty"
FTP_DIR="/ftp/archives_toip"

# Date pour les fichiers de backup
DATE=$(date +%d-%m-%Y_%H:%M:%S)
ZIP_FILE="sio2-${DATE}.zip"
ZIP_PATH="${BACKUP_DIR}/${ZIP_FILE}"

# Création de l'archive ZIP
if [ ! -d "$SOURCE_DIR" ]; then
  echo "[ERROR] Le répertoire source n'existe pas : $SOURCE_DIR" | tee -a "$LOG_FILE"
  exit 1
fi

echo "Création de l'archive ZIP..." | tee -a "$LOG_FILE"
zip -r "$ZIP_PATH" "$SOURCE_DIR" > /dev/null 2>&1
if [ $? -ne 0 ]; then
  echo "[ERROR] Échec de la création de l'archive ZIP." | tee -a "$LOG_FILE"
  exit 1
fi
echo "Archive créée avec succès : $ZIP_PATH" | tee -a "$LOG_FILE"

# Transfert de l'archive via FTP
echo "Transfert de l'archive vers le serveur FTP..." | tee -a "$LOG_FILE"
curl -v -T "$ZIP_PATH" -u "$FTP_USER:$FTP_PASS" "ftp://$FTP_SERVER$FTP_DIR/" > /dev/null 2>&1
if [ $? -ne 0 ]; then
  echo "[ERROR] Erreur lors du transfert FTP. Détails dans $LOG_FILE." | tee -a "$LOG_FILE"
  exit 1
fi
echo "Transfert terminé avec succès !" | tee -a "$LOG_FILE"

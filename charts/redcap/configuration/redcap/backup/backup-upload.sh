#!/bin/sh

# Name: backup-upload.sh
# Version: 1.0
# Author: Kévin ZGRZENDEK for APHP EDS
# Description : Compresses and uploads REDCap backup dir (containing the redcap app dir, the edocs dir & MySQL db dump)

echo "[INFO] Starting REDCap backup script v1.0"

echo "[INFO] Initializing local vars"
REDCAP_BACKUP_DIR=/backup-data
REDCAP_BACKUP_TMP_PATH=/tmp
REDCAP_BACKUP_ARCHIVE_NAME={{ .Values.backupJob.archiveName }}
REDCAP_BACKUP_S3_PATH=redcap_backup_bucket:{{ .Values.backupJob.uploader.s3.backupPath }}

echo "[INFO] Compressing the backup dir"
tar -czvf $REDCAP_BACKUP_TMP_PATH/$REDCAP_BACKUP_ARCHIVE_NAME $REDCAP_BACKUP_DIR/redcap-*

echo "[INFO] Uploading the backup archive"
rclone copy -v $REDCAP_BACKUP_TMP_PATH/$REDCAP_BACKUP_ARCHIVE_NAME $REDCAP_BACKUP_S3_PATH

retVal=$?
if [ $retVal -ne 0 ]; then
    echo "[ERROR] Backup failed! Please check the logs."
    exit $retVal
else
    echo "[INFO] Backup finished!"
    exit $retVal
fi


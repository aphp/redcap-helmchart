# Name: backup-download.sh
# Version: 1.0
# Author: Kévin ZGRZENDEK for APHP EDS
# Description : Download and extracts the backup archive (containing the redcap app dir, the edocs dir & MySQL db dump)

#!/bin/sh

echo "[INFO] Starting REDCap files restore script v1.0"

echo "[INFO] Initializing local vars"
REDCAP_BACKUP_DIR=/backup-data
REDCAP_BACKUP_TMP_PATH=/tmp
REDCAP_BACKUP_ARCHIVE_NAME={{ .Values.restoreJob.archiveName }}
REDCAP_BACKUP_S3_PATH=redcap_restore_bucket:{{ .Values.restoreJob.downloader.s3.backupPath }}

echo "[INFO] Downloading the backup archive"
rclone --s3-versions copy -v $REDCAP_BACKUP_S3_PATH/$REDCAP_BACKUP_ARCHIVE_NAME $REDCAP_BACKUP_TMP_PATH

echo "[INFO] Cleaning the destination directories to maintian consistency"
rm -rf $REDCAP_BACKUP_DIR/*

echo "[INFO] Extracting the backup dir"
tar -xzvf $REDCAP_BACKUP_TMP_PATH/$REDCAP_BACKUP_ARCHIVE_NAME -C $REDCAP_BACKUP_DIR --strip-components=1 # Removing root redcap folder 

echo "[INFO] Removing default database.php file from the backup (the right one is mounted by the HelmChart from a ConfigMap in the PHPFPM Deployment)"
rm -f -v $REDCAP_BACKUP_DIR/redcap-app/database.php # Excluding database.php file in order fo it to not override the configmap volumeMount on the deployed REDCap


retVal=$?
if [ $retVal -ne 0 ]; then
    echo "[ERROR] Backup download failed! Please check the logs."
    exit $retVal
else
    echo "[INFO] Backup downloaded successfully!"
    exit $retVal
fi
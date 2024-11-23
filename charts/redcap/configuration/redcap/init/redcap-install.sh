# Name: redcap_install
# Version: 1.0
# Author: APHP
# Description : Retrieves and unpack REDCap and a translation package 

#!/bin/sh

echo "[INFO] Starting REDCap package installation script v1.0"

echo "[INFO] Initializing local vars"
REDCAP_PACKAGE_PATH=redcap_init_bucket:{{ .Values.redcap.init.s3.packagePath }}
REDCAP_LOCALIZATION_PATH=redcap_init_bucket:{{ .Values.redcap.init.s3.localizationPath }}
REDCAP_INSTALL_PATH=/redcap

echo "[INFO] Downloading and extracting REDCap package"
rclone -P -v copy $REDCAP_PACKAGE_PATH /tmp
unzip -o /tmp/*.zip -d /tmp

echo "[INFO] Cleaning destination dir"
rm -rf $REDCAP_INSTALL_PATH/*

echo "[INFO] Installing REDCap package"
mv -f /tmp/redcap/* $REDCAP_INSTALL_PATH/

echo "[INFO] Applying CRLF EOF bugfix to installed REDCap package"
find /redcap -type f -name '*.php' -print0 | xargs -0 dos2unix

echo "[INFO] Cleaning temp dir"
rm -rf /tmp/redcap

echo "[INFO] Downloading and installing localization file"
rclone -P -v copy $REDCAP_LOCALIZATION_PATH $REDCAP_INSTALL_PATH/languages

retVal=$?
if [ $retVal -ne 0 ]; then
    echo "[ERROR] Installation failed! Please check the logs."
    exit $retVal
else
    echo "[INFO] Installation done!"
    exit $retVal
fi
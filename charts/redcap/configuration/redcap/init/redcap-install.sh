#!/bin/sh

# Name: redcap_install
# Version: 1.1
# Author: APHP
# Description : Retrieves and unpack REDCap and a translation package 

echo "[INFO] Starting REDCap package installation script v1.1"
set -e

# Installs the REDCap Application package by retriving it directly from the Community Site API, using the user's credentials.
install_redcap () {
    echo "[INFO] Cleaning destination dir"
    rm -rf "${REDCAP_INSTALL_PATH:?}/redcap"


    echo "[INFO] Downloading and extracting REDCap package"
    curl -X POST \
        --location 'https://redcap.vumc.org/plugins/redcap_consortium/versions.php' \
        --header 'Content-Type: application/x-www-form-urlencoded' \
        --data-urlencode "username=$REDCAP_COMMUNITY_USERNAME" \
        --data-urlencode "password=$REDCAP_COMMUNITY_PASSWORD" \
        --data-urlencode "version=$REDCAP_VERSION" \
        --data-urlencode "install=1" \
        --output '/tmp/redcap.zip'

    echo "[INFO] Installing REDCap package"
    unzip -o "/tmp/redcap.zip" -d /tmp
    mv -f /tmp/redcap/* "${REDCAP_INSTALL_PATH}/"

    echo "[INFO] Applying CRLF EOF bugfix to installed REDCap package"
    find /redcap -type f -name '*.php' -print0 | xargs -0 dos2unix

    echo "[INFO] Cleaning temp dir"
    rm -rf "/tmp/*"

    echo "[INFO] Installation done!"
    exit 0

}

if  [ "$(echo "$OVERRIDE_INSTALL" | tr '[:upper:]' '[:lower:]')" = "true" ] || [ -z "$(find "$REDCAP_INSTALL_PATH" -mindepth 1 -maxdepth 1 -not -path "$REDCAP_INSTALL_PATH/lost+found")" ]
then
    install_redcap
else
    echo "[INFO] An already existing REDCap application package is present, and the OVERRIDE_INSTALL option has not been enabled. Skipping REDCap installation."
    exit 0
fi

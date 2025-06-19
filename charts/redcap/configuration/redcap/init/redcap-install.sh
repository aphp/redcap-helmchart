#!/bin/sh

# Name: redcap_install
# Version: 1.1
# Author: APHP
# Description : Retrieves and unpack REDCap and a translation package 


#####################
### GLOBAL CONFIG ###
#####################
set -e
REDCAP_INSTALL=1


#############################
### FUNCTION DECLARATIONS ###
#############################

# Installs the REDCap Application package by retrieving it directly from the Community Site API, using the user's credentials.
install_redcap () {

    if [ "$REDCAP_INSTALL" = 1 ]; then
        echo "[INFO] Installing REDCap version $REDCAP_VERSION from scratch"
        echo "[INFO] Cleaning destination dir"
        rm -rvf "${REDCAP_INSTALL_PATH:?}/*"

    fi

    echo "[INFO] Downloading and extracting REDCap package"
    curl \
        --location 'https://redcap.vumc.org/plugins/redcap_consortium/versions.php' \
        --header 'Content-Type: application/x-www-form-urlencoded' \
        --data-urlencode "username=$REDCAP_COMMUNITY_USERNAME" \
        --data-urlencode "password=$REDCAP_COMMUNITY_PASSWORD" \
        --data-urlencode "version=$REDCAP_VERSION" \
        --data-urlencode "install=$REDCAP_INSTALL" \
        --write-out "File name : %{filename_effective}\nFetched from: %{url}\nStatistics:\n\tDownload Time : %{time_total}\n\tDownload Size : %{size_download}\n\tDownload Speed : %{speed_download}\n" \
        --no-progress-meter \
        --output '/tmp/redcap/redcap.zip'

    echo "[INFO] Installing REDCap package"
    unzip -o "/tmp/redcap/redcap.zip" -d /tmp/redcap
    cp -rvf /tmp/redcap/redcap/* "${REDCAP_INSTALL_PATH}/"

    echo "[INFO] Applying CRLF EOF bugfix to installed REDCap package"
    find "${REDCAP_INSTALL_PATH}" -type f -name '*.php' -print0 | xargs -0 dos2unix

    echo "[INFO] Cleaning"
    rm -rvf "/tmp/redcap/*"

    echo "[INFO] Installation done!"
}

# Injects the content of the Configmap holding the "database.php" file into the downloaded REDCap application directory,
# before the Pod's main container mounts this directory as read-only (which prevents traditional Configmap mounting).
update_database_config () {

    echo "[INFO] Injecting REDCap database configuration"
    cp -f /tmp/conf/database.php "${REDCAP_INSTALL_PATH}/database.php"

    echo "[INFO] REDCap Database configuration updated!"
}


##########################
### SCRIPT STARTS HERE ###
##########################

echo "[INFO] Starting REDCap package installation script v1.1"

# Ugrading REDCap if an existing installation of lower version has been found
if  [ -n "$(find "$REDCAP_INSTALL_PATH" -mindepth 1 -maxdepth 1 -not -path "$REDCAP_INSTALL_PATH/lost+found")" ]; then
    REDCAP_PREFIX='redcap_v'

    REDCAP_VERSION_SANITIZED=$(echo "$REDCAP_VERSION" | tr -d '.')

    REDCAP_CURRENT_VERSION=$(ls "${REDCAP_INSTALL_PATH}" | grep ${REDCAP_PREFIX} | sort -rst '/' -k1,1 | head -n 1 | sed -e "s/^${REDCAP_PREFIX}//")
    REDCAP_CURRENT_VERSION_SANITIZED=$(echo "$REDCAP_CURRENT_VERSION" | tr -d '.')

    if  [ "$REDCAP_VERSION_SANITIZED" -eq "$REDCAP_CURRENT_VERSION_SANITIZED" ]; then
        echo "[INFO] REDCap version ${REDCAP_VERSION} files are already present in ${REDCAP_INSTALL_PATH}. Skipping installation process."
        exit 0

    elif  [ "$REDCAP_VERSION_SANITIZED" -gt "$REDCAP_CURRENT_VERSION_SANITIZED" ]; then
        echo "[INFO] Upgrading existing REDCap installation from version $REDCAP_CURRENT_VERSION to $REDCAP_VERSION"
        REDCAP_INSTALL=0
    fi

fi

install_redcap
update_database_config
echo "[INFO] REDCap version $REDCAP_VERSION have been correctly installed."
exit 0



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
        echo "[INFO] Installing REDCap from scratch"
        echo "[INFO] Cleaning destination dir"
        rm -rvf "${REDCAP_INSTALL_PATH:?}/*"
    else
        echo "[INFO] Updating existing REDCap installation"
    fi

    echo "[INFO] Downloading and extracting REDCap package"
    curl -X POST \
        --location 'https://redcap.vumc.org/plugins/redcap_consortium/versions.php' \
        --header 'Content-Type: application/x-www-form-urlencoded' \
        --data-urlencode "username=$REDCAP_COMMUNITY_USERNAME" \
        --data-urlencode "password=$REDCAP_COMMUNITY_PASSWORD" \
        --data-urlencode "version=$REDCAP_VERSION" \
        --data-urlencode "install=$REDCAP_INSTALL" \
        --write-out "File name : %{filename_effective}\nFetched from: %{url}\nStatistics:\n\tDownload Time : %{time_total}\n\tDownload Size : %{size_download}\n\tDownload Speed : %{speed_download}\n" \
        --no-progress-meter \
        --verbose \
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

# Ugrading REDCap if an existing installation of lower version has been found
if  [ -n "$(find "$REDCAP_INSTALL_PATH" -mindepth 1 -maxdepth 1 -not -path "$REDCAP_INSTALL_PATH/lost+found")" ]
then
    REDCAP_PREFIX='redcap_v'
    REDCAP_CURRENT_VERSION=$(ls "${REDCAP_INSTALL_PATH}" | grep ${REDCAP_PREFIX} | sort -rst '/' -k1,1 | head -n 1 | sed -e "s/^${REDCAP_PREFIX}//")

    if  [ "$REDCAP_VERSION" -gt "$REDCAP_CURRENT_VERSION" ]
    then
        REDCAP_INSTALL=0
    fi
fi

echo "[INFO] Starting REDCap package installation script v1.1"
install_redcap
update_database_config
echo "[INFO] REDCap have been correctly installed and configured."
exit 0



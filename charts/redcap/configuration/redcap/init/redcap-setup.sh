#!/bin/sh

# Name: redcap_setup
# Version: 1.0
# Author: APHP
# Description : Querying REDCap install/upgrade endpoint depending on the installation context.


#####################
### GLOBAL CONFIG ###
#####################
set -e

REDCAP_INSTALL=1

#############################
### FUNCTION DECLARATIONS ###
#############################

# Setup REDCap using its php scripts.
setup_redcap () {
    
    if [ "$REDCAP_INSTALL" = 1 ]; then
        echo "[INFO] Calling REDCap install.php script"

        SCRIPT_NAME="/var/www/redcap/install.php" \
        SCRIPT_FILENAME="/var/www/redcap/install.php" \
        QUERY_STRING="auto=1" \
        REQUEST_METHOD="GET" \
        cgi-fcgi \
            -bind \
            -connect \
        127.0.0.1:9000
        
    else
        echo echo "[INFO] Calling REDCap upgrade.php script"

        SCRIPT_NAME="/var/www/redcap/upgrade.php" \
        SCRIPT_FILENAME="/var/www/redcap/upgrade.php" \
        QUERY_STRING="auto=1" \
        REQUEST_METHOD="GET" \
        cgi-fcgi \
            -bind \
            -connect \
        127.0.0.1:9000
    fi

    echo "[INFO] Installation done!"
}



##########################
### SCRIPT STARTS HERE ###
##########################

# Upgrading REDCap if more than one REDCap installation folder is found (REDCap adds a new version folder at each update)
if  [ -n "$(find "$REDCAP_INSTALL_PATH" -mindepth 1 -maxdepth 1 -not -path "$REDCAP_INSTALL_PATH/lost+found")" ]; then

    REDCAP_PREFIX='redcap_v'
    REDCAP_VERSIONS_FOLDERS=$(ls "${REDCAP_INSTALL_PATH}" | grep -c ${REDCAP_PREFIX})

    if  [ "$REDCAP_VERSIONS_FOLDERS" -gt 1 ]; then
        REDCAP_INSTALL=0
    fi

fi

echo "[INFO] Starting REDCap setup script v1.0"
setup_redcap
echo "[INFO] REDCap installation have been correctly setup."

exit 0



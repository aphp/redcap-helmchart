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
SCRIPT_NAME="/var/www/redcap/install.php"
SCRIPT_FILENAME="/var/www/redcap/install.php"


#############################
### FUNCTION DECLARATIONS ###
#############################

# Setup REDCap using its php scripts.
setup_redcap () {
    
    if [ "$REDCAP_INSTALL" = 1 ]; then
        echo "[INFO] Calling REDCap install.php script"
        # shellcheck disable=SC2034
        # Used as env parameter by `cgi-fcgi`
        SCRIPT_NAME="/var/www/redcap/install.php"
        # shellcheck disable=SC2034
        # Used as env parameter by `cgi-fcgi`
        SCRIPT_FILENAME="/var/www/redcap/install.php"
    else
        echo echo "[INFO] Calling REDCap upgrade.php script"
        # shellcheck disable=SC2034
        # Used as env parameter by `cgi-fcgi`
        SCRIPT_NAME="/var/www/redcap/upgrade.php"
        # shellcheck disable=SC2034
        # Used as env parameter by `cgi-fcgi`
        SCRIPT_FILENAME="/var/www/redcap/upgrade.php"
    fi


    # shellcheck disable=SC2034
    # Used as env parameter by `cgi-fcgi`
    QUERY_STRING="auto=1"
    # shellcheck disable=SC2034
    # Used as env parameter by `cgi-fcgi`
    REQUEST_METHOD="GET"
    cgi-fcgi \
    -bind \
    -connect \
    127.0.0.1:9000

    echo "[INFO] Installation done!"
}



##########################
### SCRIPT STARTS HERE ###
##########################

# Upgrading REDCap if more than one REDCap installation folder is found (REDCap adds a new version folder at each update)
if  [ -n "$(find "$REDCAP_INSTALL_PATH" -mindepth 1 -maxdepth 1 -not -path "$REDCAP_INSTALL_PATH/lost+found")" ]
then
    REDCAP_PREFIX='redcap_v'
    REDCAP_VERSIONS_FOLDERS=$(ls "${REDCAP_INSTALL_PATH}" | grep -c ${REDCAP_PREFIX})

    if  [ "$REDCAP_VERSIONS_FOLDERS" -gt 1 ]
    then
        REDCAP_INSTALL=0
    fi

fi

echo "[INFO] Starting REDCap setup script v1.0"
setup_redcap
echo "[INFO] REDCap installation have been correctly setup."
exit 0



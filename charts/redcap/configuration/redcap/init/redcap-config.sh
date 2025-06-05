#!/bin/sh

# Name: redcap_config
# Version: 1.0
# Author: APHP
# Description : Updates common REDCap configuration during the installation process.


#####################
### GLOBAL CONFIG ###
#####################
set -e



####################################################################################
#
# Update additional configuration settings including 
# user file uploading settings to Azure Blob Storage
#
####################################################################################

mysql \
    --host={{ .Values.redcap.config.database.auth.hostname }} \
    --port={{ default 3306 .Values.mysql.primary.service.ports.mysql }} \
    --user={{ .Values.redcap.config.database.auth.username }} \
    --password=${DB_PASSWD} \
    --database={{ .Values.redcap.config.database.auth.databaseName }} <<EOF
UPDATE redcap_config SET value = '{{ .Values.redcap.config.externalURL }} WHERE field_name = 'redcap_base_url';
UPDATE redcap_config SET value = '{{ .Values.redcap.config.mail.auth.from }} WHERE field_name = 'from_email	';
UPDATE redcap_config SET value = '{{ .Values.redcap.config.adminMail }} WHERE field_name = 'homepage_contact_email';
UPDATE redcap_config SET value = '{{ .Values.redcap.config.adminMail }} WHERE field_name = 'project_contact_email';
UPDATE redcap_config SET value = '/edocs' WHERE field_name = 'edoc_path';
EOF
<?php

//********************************************************************************************************************
// MYSQL DATABASE CONNECTION:
// Replace the values inside the single quotes below with the values for your MySQL configuration. 
// If not using the default port 3306, then append a colon and port number to the hostname (e.g. $hostname = 'example.com:3307';).

$hostname 	= '{{ .Values.redcap.config.database.auth.hostname }}';
$db 		= '{{ .Values.redcap.config.database.auth.databaseName }}';
$username 	= '{{ .Values.redcap.config.database.auth.username }}';

$password 	= '{{ ternary (printf "%s" .Values.redcap.config.database.auth.password.value) (printf "%s" "file_get_contents(\"/var/run/secrets/DB_PASSWD\")") (not .Values.redcap.config.database.auth.password.secretKeyRef.name) }}';

// You may optionally utilize a database connection over SSL/TLS for improved security. To do so, at minimum
// you must provide the path of the key file, the certificate file, and certificate authority file.
$db_ssl_key  	= '';		// e.g., '/etc/mysql/ssl/client-key.pem'
$db_ssl_cert 	= '';		// e.g., '/etc/mysql/ssl/client-cert.pem'
$db_ssl_ca   	= '';		// e.g., '/etc/mysql/ssl/ca-cert.pem'
$db_ssl_capath 	= NULL;
$db_ssl_cipher 	= NULL;
$db_ssl_verify_server_cert = false; // Set to TRUE to force the database connection to verify the SSL certificate


//********************************************************************************************************************
// SALT VARIABLE:
// Add a random value for the $salt variable below, preferably alpha-numeric with 8 characters or more. This value wll be 
// used for data de-identification hashing for data exports. Do NOT change this value once it has been initially set.

$salt = '{{ ternary (printf "%s" .Values.redcap.config.database.salt.value) (printf "%s" "file_get_contents(\"/var/run/secrets/SALT\")") (not .Values.redcap.config.database.salt.secretKeyRef.name) }}';

//********************************************************************************************************************
// DATA TRANSFER SERVICES (DTS):
// If using REDCap DTS, uncomment the lines below and provide the database connection values for connecting to
// the MySQL database containing the DTS tables (even if the same as the values above).

// $dtsHostname 	= 'your_dts_host_name';
// $dtsDb 			= 'your_dts_db_name';
// $dtsUsername 	= 'your_dts_db_username';
// $dtsPassword 	= 'your_dts_db_password';

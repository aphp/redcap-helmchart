<?php

/**
 * Set this variable to TRUE if you are having problems and need to see as much error logging information as
 * possible. This will cause all errors/warnings/notices to be logged to your web server's error log. Once
 * the issue has been resolved, we recommend setting this back to FALSE to avoid unnecessary logging of warnings.
 */
global $log_all_errors;
$log_all_errors = '{{ .Values.redcap.config.logAllErrors }}';

// For greater security, you may instead want to place the database connection values in a separate file that is not 
// accessible via the web. To do this, uncomment the line below and set it as the path to your database connection file
// located elsewhere on your web server. The file included should contain all the variables from above.
include '/var/run/secrets/credentials.php';

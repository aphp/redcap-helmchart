# redcap

![Version: 1.2.1](https://img.shields.io/badge/Version-1.2.1-informational?style=flat-square) ![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square) ![AppVersion: 13.1.18](https://img.shields.io/badge/AppVersion-13.1.18-informational?style=flat-square)

A Helm chart to deploy REDCap on a Kubernetes cluster.

**Homepage:** <https://gitlab.eds.aphp.fr/ADM/k8s/charts-and-manifests/redcap>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| Kévin ZGRZENDEK | <kevin.zgrzendek@aphp.fr> | <https://github.com/kzgrzendek> |

## Source Code

* <https://www.project-redcap.org/>

## Requirements

Kubernetes: `>= 1.24.0-0`

| Repository | Name | Version |
|------------|------|---------|
| https://charts.bitnami.com/bitnami | audit(logstash) | 5.5.6 |
| https://charts.bitnami.com/bitnami | mysql | 9.12.3 |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| httpd.enabled | bool | `true` | If `true`, activates the deploment of the Apache HTTPd proxy. |
| httpd.image.repository | string | `"aphp/redcap-httpd-shibd"` | Image repository for Apache HTTPd. |
| httpd.image.tag | string | `"1.0.0"` | Image tag for Apache HTTPd. |
| httpd.image.pullPolicy | string | `"IfNotPresent"` | PullPolicy for Apache HTTPd's image. |
| httpd.tls.enabled | bool | `false` | If `true` activates TLS termination on the Apache HTTPd proxy. |
| httpd.tls.certificate | object | `{"existingSecret":""}` | Configuration relating to the server TLS certificate. |
| httpd.tls.certificate.existingSecret | string | `""` | Name of the existing Secret holding the certificate for the TLS termination. The secret must be of type `tls`.  |
| httpd.tls.caChain | object | `{"secretKeyRef":{"key":"wildca.crt","name":"certigna-wild-ca"}}` | Configuration relating to the certification chain certificate. |
| httpd.tls.caChain.secretKeyRef | object | `{"key":"wildca.crt","name":"certigna-wild-ca"}` | Reference of an existing Secret holding the certificate for the certification chain, if needed.  |
| httpd.tls.caChain.secretKeyRef.name | string | `"certigna-wild-ca"` | The name of the existing Secret holding the certificate for the certification chain, if needed.  |
| httpd.tls.caChain.secretKeyRef.key | string | `"wildca.crt"` | The key inside the existing Secret holding the certificate for the certification chain, if needed.  |
| httpd.shibboleth.enabled | bool | `false` | If `true`, activates the Shibboleth daemon, which enables is needed for enabling SAMLv2 authentication with REDCap. |
| httpd.shibboleth.sp.entityID | string | `""` | EntityID of the SAMLv2 Service Provider (SP). |
| httpd.shibboleth.sp.metadata.certificate.existingSecret | string | `""` | Reference to the secret holding the metadata file for the Service Provider. |
| httpd.shibboleth.idp.entityID | string | `""` | EntityID of the SAMLv2 Identity Provider (IdP). |
| httpd.shibboleth.idp.metadata.secretKeyRef.name | string | `""` | Name of the secret holding the metadata file for the Identity Provider. |
| httpd.shibboleth.idp.metadata.secretKeyRef.key | string | `""` | Key of the secret holding the metadata file for the Identity Provider. |
| httpd.replicaCount | int | `1` | Number of replicas wanted for the Apache  |
| httpd.resources | object | `{}` | Resources for the Apache HTTPd pod(s). |
| httpd.nodeSelector | object | `{}` | Node Selector for the the Apache HTTPD pod(s). |
| httpd.tolerations | list | `[]` | Toleration for the the Apache HTTPD pod(s). |
| httpd.affinity | object | `{}` | Affinity for the the Apache HTTPD pod(s). |
| redcap.init.enabled | bool | `false` | If `true`, enables REDCap init process. |
| redcap.init.image.repository | string | `"rclone/rclone"` | Image repository for REDCap init process. |
| redcap.init.image.tag | string | `"1.61"` | Image tag for REDCap init process. |
| redcap.init.image.pullPolicy | string | `"IfNotPresent"` | PullPolicy for REDCap init process. |
| redcap.init.s3.packagePath | string | `""` | Path of the REDcap install package on the S3 bucket. |
| redcap.init.s3.localizationPath | string | `""` | Path of the REDcap localizaton file on the S3 bucket. |
| redcap.init.s3.config.region | string | `""` | Region of the S3 bucket. |
| redcap.init.s3.config.locationConstraint | string | `""` | LocalizationConstraint of the S3 bucket. |
| redcap.init.s3.config.endpoint | string | `""` | Endpoint of the S3 bucket. |
| redcap.init.s3.config.auth.accessKeyID | string | `""` | AccessKeyID needed for authentication on the S3 bucket. |
| redcap.init.s3.config.auth.secretAccessKey | string | `""` | SecretAccessKey needed for authentication on the S3 bucket. |
| redcap.init.s3.config.auth.existingSecret | string | `""` | Reference to an existing secret holding the AccessKeyID and SecretAccessKey needed for authentication on the S3 bucket. If set, overrides the AccessKeyID and SecretAccessKey values. |
| redcap.image.repository | string | `"aphp/redcap-phpfpm"` | Image repository for REDCap PHP-FPM Image. |
| redcap.image.pullPolicy | string | `"IfNotPresent"` | PullPolicy for REDCap PHP-FPM Image. |
| redcap.image.tag | string | `"1.0.0"` | Tag for REDCap PHP-FPM Image. |
| redcap.config.logAllErrors | string | `"FALSE"` | If set to `true`, will log all the errors on the stdout (NOT RECOMMENDED IN PRODUCTION). |
| redcap.config.externalURL | string | `""` | The URL on which the application is exposed (useful if the application is behind a reverse-proy). |
| redcap.config.adminMail | string | `""` | The email of the adminstrator that is presented to the users. |
| redcap.config.tls.curlCA.secretKeyRef.name | string | `""` | The name of the secret containing the CA Certificate ued by the curl library of the application to reach external services, like an OIDC provider. Useful some of those services are not signed by known CAs. |
| redcap.config.tls.curlCA.secretKeyRef.key | string | `""` | The key of the secret containing the CA Certificate ued by the curl library of the application to reach external services, like an OIDC provider. Useful some of those services are not signed by known CAs. |
| redcap.config.database.salt.value | string | `""` | The value of the salt used by the application to cypher senssitive data. |
| redcap.config.database.salt.secretKeyRef.name | string | `""` | The name of the secret holding the value of the salt used by the application to cypher senssitive data.  If set, the value of that secret will override the `redcap.config.database.salt.value` value. |
| redcap.config.database.salt.secretKeyRef.key | string | `""` | The key of the secret holding the value of the salt used by the application to cypher senssitive data. If set, the value of that secret will override the `redcap.config.database.salt.value` value. |
| redcap.config.database.auth.hostname | string | `""` | The hostname of REDCap's database instance. |
| redcap.config.database.auth.databaseName | string | `""` | The name of REDCAP's database. |
| redcap.config.database.auth.username | string | `""` | The username used to connect to REDCAP's database. |
| redcap.config.database.auth.password.value | string | `""` | The password used to connect to REDCAP's database. |
| redcap.config.database.auth.password.secretKeyRef.name | string | `""` | The name of the secret holding the password used to connect to REDCAP's database. If set, the value of that secret will override the `redcap.config.database.auth.password.value` value. |
| redcap.config.database.auth.password.secretKeyRef.key | string | `""` | The key of the secret holding the password used to connect to REDCAP's database. If set, the value of that secret will override the `redcap.config.database.auth.password.value` value. |
| redcap.config.mail.auth.server | string | `""` | The hostname or IP of the mail server used by REDCap. |
| redcap.config.mail.auth.port | string | `nil` | The port of the mail server used by REDCap. |
| redcap.config.mail.auth.tls | bool | `true` | If set to `true`, will secure the communiction with the mail server with TLS. |
| redcap.config.mail.auth.starttls | bool | `false` | If `true`, will use StartTLS for the connection to the mail server. |
| redcap.config.mail.auth.from | string | `""` | The sender name that will display on mails send by REDCap. |
| redcap.config.mail.auth.username | string | `""` | The username used to connect to the mail server. |
| redcap.config.mail.auth.password.value | string | `""` | The password used to connect to the mail server. |
| redcap.config.mail.auth.password.existingSecret | string | `""` | Reference to an existing secret holding the password used to connect to the mail server. If set, the value of that secret will override the `redcap.config.mail.auth.password.value` value. |
| redcap.replicaCount | int | `1` | The number of replicas for REDCap's deployment. |
| redcap.resources | object | `{}` | The resource request/limits for REDCap's deployment. |
| redcap.nodeSelector | object | `{}` | The nodeSelector for REDCap's deployment. |
| redcap.tolerations | list | `[]` | The toleraions for REDCap's deployment. |
| redcap.affinity | object | `{}` | The affinities for REDCap's deployment. |
| redcap.adminJob.schedule | string | `"0 * * * *"` | Schedule of the Admin Job, which runs every hours by default. This job is nedded to refresh REDCap administrative's data. |
| redcap.adminJob.image.repository | string | `"aphp/redcap-fcgi-client"` | Image of the Admin Job. Must be and FCGI Client capable to query REDCap's pod(s). |
| redcap.adminJob.image.tag | string | `"1.0.0"` | Tag of the Admin Job's image. |
| redcap.adminJob.image.pullPolicy | string | `"IfNotPresent"` | PullPolicy of the Admin Job's image. |
| redcap.adminJob.image.imagePullSecrets | list | `[]` | ImagePullSecret of the Admin Job's image. |
| redcap.adminJob.resources | object | `{}` | Resources for the admin job's pod. |
| mysql | object | Settings for a standalone MySQL deployment compatible with REDCap. | See original documentation @ https://github.com/bitnami/charts/tree/main/bitnami/mysql |
| mysql.enabled | bool | `true` | If set to `true`, enables the deployment of MySQL as REDCap's database. |
| mysql.architecture | string | `"standalone"` | Deployment type for the database, standalone or replicated. |
| mysql.initdbScriptsConfigMap | string | `""` | Name of a configmap holding an SQL script to inistialize the database with. |
| mysql.auth.createDatabase | bool | `true` | Automatically create a database at the first run. |
| mysql.auth.database | string | `"redcap"` | Name of the database automatically created at the first run, if ``mysql.auth.createDatabase` has been set to `true`  |
| mysql.primary.podLabels."app.kubernetes.io/role" | string | `"redcap-mysql"` | Role to set for the networkPolicies. Not to be changed, unless you know exactly what you are doing! |
| mysql.primary.service.port.mysql | int | `3306` | Port exposed by the MySQL service. |
| mysql.primary.persistence.storageClass | string | `""` | StorageClass used for database persistence. |
| mysql.primary.persistence.accessModes | list | `["ReadWriteOnce"]` | AccessMode used for database persistence.  |
| mysql.primary.persistence.size | string | `"50G"` | Size of the storage used for database persistence. |
| backupJob.enabled | bool | `true` | If set to `true`, enables the backup CronJob. |
| backupJob.imagePullSecrets | list | `[]` | ImagePllSecret for the REDCap backup CronJob. |
| backupJob.schedule | string | `"0 */8 * * *"` | Schedule of the Backup Job, which runs every 8 hours by default. |
| backupJob.archiveName | string | `"redcap-backup.tar.gz"` | Name of the archive holding the backup if REDCap. |
| backupJob.redcap.image.repository | string | `"busybox"` | Image repository for the REDCap application backup container. |
| backupJob.redcap.image.tag | string | `"1"` | Image tag for the REDCap application backup container. |
| backupJob.redcap.image.pullPolicy | string | `"IfNotPresent"` | Image pullPolicy for the REDCap application backup container. |
| backupJob.database.image.repository | string | `"bitnami/mysql"` | Image repository for the REDCap database backup container. |
| backupJob.database.image.tag | string | `"8.0.32-debian-11-r14"` | Image tag for the REDCap database backup container. |
| backupJob.database.image.pullPolicy | string | `"IfNotPresent"` | Image pullPolicy for the REDCap database backup container. |
| backupJob.uploader.image.repository | string | `"rclone/rclone"` | Image repository for the REDCap backup uploader container. |
| backupJob.uploader.image.tag | string | `"1.61"` | Image tag for the REDCap backup uploader container. |
| backupJob.uploader.image.pullPolicy | string | `"IfNotPresent"` | Image pullPolicy for the REDCap backup uploader container. |
| backupJob.uploader.s3.backupPath | string | `"redcap-backup"` | Path of the REDcap backup archive on the S3 bucket. |
| backupJob.uploader.s3.config.region | string | `""` | Region of the S3 bucket. |
| backupJob.uploader.s3.config.locationConstraint | string | `""` | LocalizationConstraint of the S3 bucket. |
| backupJob.uploader.s3.config.endpoint | string | `""` | Endpoint of the S3 bucket. |
| backupJob.uploader.s3.config.auth.accessKeyID | string | `""` | AccessKeyID needed for authentication on the S3 bucket. |
| backupJob.uploader.s3.config.auth.secretAccessKey | string | `""` | SecretAccessKey needed for authentication on the S3 bucket. |
| backupJob.uploader.s3.config.auth.existingSecret | string | `""` | Reference to an existing secret holding the AccessKeyID and SecretAccessKey needed for authentication on the S3 bucket. If set, overrides the AccessKeyID and SecretAccessKey values. |
| backupJob.resources | object | `{}` | Resources for backup job's pod. |
| restoreJob.enabled | bool | `true` | If set to `true`, enables the restore CronJob (used to easily trigger a job from its JobTemplate). |
| restoreJob.imagePullSecrets | list | `[]` | ImagePullSecret used to pull the images for the restore pod's containers |
| restoreJob.schedule | string | `"0 0 1 1 *"` | Schedule for the restore Cronjob. CronJob resources needs a valide schedule, but this one will never be used since it will always be suspended (see spec.suspend field). |
| restoreJob.archiveName | string | `"redcap-backup.tar.gz"` | Name of the backup archive to restore. |
| restoreJob.redcap.image.repository | string | `"busybox"` | Image repository for the REDCap application restore container. |
| restoreJob.redcap.image.tag | string | `"1"` | Image tag for the REDCap application restore container. |
| restoreJob.redcap.image.pullPolicy | string | `"IfNotPresent"` | Image pullPolicy for the REDCap application restore container. |
| restoreJob.database.image.repository | string | `"bitnami/mysql"` | Image repository for the REDCap database restore container. |
| restoreJob.database.image.tag | string | `"8.0.32-debian-11-r14"` | Image yag for the REDCap application restore container. |
| restoreJob.database.image.pullPolicy | string | `"IfNotPresent"` | Image pullPolicy for the REDCap application restore container. |
| restoreJob.downloader.image.repository | string | `"rclone/rclone"` | Image repository for the REDCap downloader container. |
| restoreJob.downloader.image.tag | string | `"1.61"` | Image tag for the REDCap downloader container. |
| restoreJob.downloader.image.pullPolicy | string | `"IfNotPresent"` | Image pullPolicy for the REDCap downloader container. |
| restoreJob.downloader.s3.backupPath | string | `"redcap-backup"` | Path of the REDcap backup archive on the S3 bucket. |
| restoreJob.downloader.s3.config.region | string | `""` | Region of the S3 bucket. |
| restoreJob.downloader.s3.config.locationConstraint | string | `""` | LocalizationConstraint of the S3 bucket. |
| restoreJob.downloader.s3.config.endpoint | string | `""` | Endpoint of the S3 bucket. |
| restoreJob.downloader.s3.config.auth.accessKeyID | string | `""` | AccessKeyID needed for authentication on the S3 bucket. |
| restoreJob.downloader.s3.config.auth.secretAccessKey | string | `""` | SecretAccessKey needed for authentication on the S3 bucket. |
| restoreJob.downloader.s3.config.auth.existingSecret | string | `""` | Reference to an existing secret holding the AccessKeyID and SecretAccessKey needed for authentication on the S3 bucket. If set, overrides the AccessKeyID and SecretAccessKey values. |
| restoreJob.resources | object | `{}` | Resources for backup job's pod. |
| audit | object | A configuration made for OVH's Log Data Platform (Logstah + Graylog + OpenSearch) | Audit log-shipping solution, using Logstash to query audit data in REDCap DB to ship them to the audit stack. See original documentation @ https://github.com/bitnami/charts/tree/main/bitnami/logstash |
| audit.enabled | bool | `false` | If set to `true`, enables the audit log-shipping solution. |
| audit.podLabels."app.kubernetes.io/role" | string | `"redcap-audit"` | Role to set for the networkPolicies. Not to be changed, unless you know exactly what you are doing! |
| audit.image.tag | string | `"8.10.2"` | Tag of the Logstsh image. |
| audit.initContainers[0] | object | A simple container to download the jar JDBC driver on a volume shared with Logstash. | Init container in charge of downloading the JDBC driver needed to connect to the MySQL database. |
| audit.initContainers[0].image | string | `"alpine:3.18"` | Image used for the pod downloading the driver. |
| audit.initContainers[0].pullPolicy | string | `"IfNotPresent"` | Image pullPolicy used for the pod downloading the driver. |
| audit.initContainers[0].env[0] | object | `{"name":"JDBC_DRIVER_URL","value":"https://cdn.mysql.com/Downloads/Connector-J/mysql-connector-j-8.1.0.tar.gz"}` | Env var to set the URL of the JDBC driver to download. |
| audit.initContainers[0].env[0].value | string | `"https://cdn.mysql.com/Downloads/Connector-J/mysql-connector-j-8.1.0.tar.gz"` | URL of the JDBC driver to download. |
| audit.initContainers[0].command | list | Using `wget` do download the driver, and miving it to the shared persitent volume. | Command to be run to download and extract the JDBC driver. |
| audit.initContainers[0].volumeMounts | list | `[{"mountPath":"/driver","name":"driver-dir"}]` | Volume mount used to persist the JDBC driver. |
| audit.initContainers[0].volumeMounts[0] | object | `{"mountPath":"/driver","name":"driver-dir"}` | Name of the volume used to persist the JDBC driver. |
| audit.initContainers[0].volumeMounts[0].mountPath | string | `"/driver"` | Mount path ofthe volume used to persist the JDBC driver. |
| audit.enableMultiplePipelines | bool | `true` | If set to `true`, allows the use of multiple pipelines. Needed for audit concurrent pipelines for performance reasons. |
| audit.existingConfiguration | string | `"redcap-mysql-audit-logstash-pipeline"` | Name of an existing ConfigMap holding the pipeline(s)'s configuration. |
| audit.extraEnvVars | list | `[{"name":"MYSQL_PASSWD","valueFrom":{"secretKeyRef":{"key":"","name":""}}},{"name":"AUDIT_TOKEN","valueFrom":{"secretKeyRef":{"key":"","name":""}}}]` | Extra environment variables needed. |
| audit.persistence.enabled | bool | `true` | If set to `true`, enables persistence for Logstash. Useful for disaster recovery purposes, as the pipeline(s)'s cache is stored persisted by Logstash.  |
| audit.persistence.storageClass | string | `""` | Storage class used for Logstash's persistence. |
| audit.persistence.accessModes | list | `["ReadWriteOnce"]` | Access Mode used for Logstash's persistence. |
| audit.persistence.size | string | `"10G"` | Size requested for Logstash's persistence. |
| audit.extraVolumes | list | `[{"emptyDir":{"sizeLimit":"50Mi"},"name":"driver-dir"},{"name":"api-ca","secret":{"secretName":""}}]` | Volumes required for Logstash's deployment. |
| audit.extraVolumes[0] | object | `{"emptyDir":{"sizeLimit":"50Mi"},"name":"driver-dir"}` | JDBC Driver downloaded by the init container. |
| audit.extraVolumes[1] | object | `{"name":"api-ca","secret":{"secretName":""}}` | Volume handling the CA used to validate the HTTPS conenxion to the audit stack the logs are send to. |
| audit.extraVolumeMounts | list | `[{"mountPath":"/driver","name":"driver-dir"},{"mountPath":"/var/run/secret/api-ca.pem","name":"api-ca","subpath":""}]` | Volume mounts required for Logstash's deployment. |
| audit.extraVolumeMounts[0] | object | `{"mountPath":"/driver","name":"driver-dir"}` | JDBC Driver downloaded by the init container. |
| audit.extraVolumeMounts[1] | object | `{"mountPath":"/var/run/secret/api-ca.pem","name":"api-ca","subpath":""}` | Volume handling the CA used to validate the HTTPS connexion to the audit stack the logs are send to. |
| audit.logsApi | object | `{"config":{"caPath":"","host":"","pollingSchedule":"","port":""}}` | Configuration of the endpoint of the audit stack the logs are send to. |
| audit.logsApi.config.pollingSchedule | string | `""` | Scheduling of the rate at whichh Logstash will query REDCap database for nez event. Must be in `cron` format. |
| audit.logsApi.config.caPath | string | `""` | Path to the certificate used to validate the audit stack endpoint's certificate.  |
| audit.logsApi.config.host | string | `""` | Host of the audit stack endpoint. |
| audit.logsApi.config.port | string | `""` | Port of the audit stack endpoint. |
| serviceAccount.create | bool | `false` | Specifies whether a service account should be created |
| serviceAccount.annotations | object | `{}` | Annotations to add to the service account |
| serviceAccount.name | string | `""` | The name of the service account to use. If not set and create is true, a name is generated using the fullname template |
| networkPolicies.enabled | bool | `true` | If set to `true`, enables NetworkPolicies. Highly recommended for production! |
| ingress.enabled | bool | `true` | If set to `true`, enables ingress. |
| ingress.annotations | object | `{}` | Ingress' annotations |
| ingress.tls | list | `[]` | Ingress TLS configuration |
| service.httpd.enabled | bool | `true` | If set to `true`, enables the service for Apache HTTPd. |
| service.httpd.annotations | object | `{}` | Annotations for the Apache HTTPd service. |
| service.httpd.type | string | `"ClusterIP"` | Type of the Apache HTTPd service. |
| service.redcap.enabled | bool | `true` | If set to `true`, enables the service for REDCap. |
| service.redcap.annotations | object | `{}` | Annotations for the REDCap service. |
| service.redcap.type | string | `"ClusterIP"` | Type of the REDCap service. |
| autoscaling.enabled | bool | `false` | If set to `true`, enables autoscaling |
| autoscaling.minReplicas | int | `1` | Minimum replicas instances. |
| autoscaling.maxReplicas | int | `3` | Maximum replicas target |
| autoscaling.targetCPUUtilizationPercentage | int | `80` | CPU usage threshold for autoscaling. |
| autoscaling.targetMemoryUtilizationPercentage | int | `80` | Memory usage threshold for autoscaling. |
| persistence.redcap_code.size | string | `"1Gi"` | Size of the volume used to persist REDCap code. |
| persistence.redcap_code.storageClass | string | `""` | Storage Class of the volume used to persist REDCap code. |
| persistence.redcap_code.accessMode | string | `"RWX"` | AccessMode of the volume used to persist REDCap code. |
| persistence.redcap_code.existingClaim.name | string | `""` | Name of an existing PVC used to persist REDCap code. If set, overrides the previous settings, as no PVC will be created for that purpose. |
| persistence.edocs.size | string | `"8Gi"` | Size of the volume used to persist documents uplpoaded by REDCap users. |
| persistence.edocs.storageClass | string | `""` | StorageClass of the volume used to persist documents uplpoaded by REDCap users. |
| persistence.edocs.accessMode | string | `"RWX"` | AccessMode of the volume used to persist documents uplpoaded by REDCap users. |
| persistence.edocs.existingClaim.name | string | `""` | Name of an existing PVC used to persist documents uplpoaded by REDCap users. If set, overrides the previous settings, as no PVC will be created for that purpose. |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.11.3](https://github.com/norwoodj/helm-docs/releases/v1.11.3)

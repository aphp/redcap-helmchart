# mysql

![Version: 9.4.8](https://img.shields.io/badge/Version-9.4.8-informational?style=flat-square) ![AppVersion: 8.0.32](https://img.shields.io/badge/AppVersion-8.0.32-informational?style=flat-square)

MySQL is a fast, reliable, scalable, and easy to use open source relational database system. Designed to handle mission-critical, heavy-load production applications.

**Homepage:** <https://github.com/bitnami/charts/tree/main/bitnami/mysql>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| Bitnami |  | <https://github.com/bitnami/charts> |

## Source Code

* <https://github.com/bitnami/containers/tree/main/bitnami/mysql>
* <https://mysql.com>

## Requirements

| Repository | Name | Version |
|------------|------|---------|
| https://charts.bitnami.com/bitnami | common | 2.x.x |

## Values

| Key | Type | Default | Description |
|-----|------|---------|-------------|
| global.imageRegistry | string | `""` |  |
| global.imagePullSecrets | list | `[]` |  |
| global.storageClass | string | `""` |  |
| kubeVersion | string | `""` |  |
| nameOverride | string | `""` |  |
| fullnameOverride | string | `""` |  |
| namespaceOverride | string | `""` |  |
| clusterDomain | string | `"cluster.local"` |  |
| commonAnnotations | object | `{}` |  |
| commonLabels | object | `{}` |  |
| extraDeploy | list | `[]` |  |
| diagnosticMode.enabled | bool | `false` |  |
| diagnosticMode.command[0] | string | `"sleep"` |  |
| diagnosticMode.args[0] | string | `"infinity"` |  |
| image.registry | string | `"docker.io"` |  |
| image.repository | string | `"bitnami/mysql"` |  |
| image.tag | string | `"8.0.32-debian-11-r0"` |  |
| image.digest | string | `""` |  |
| image.pullPolicy | string | `"IfNotPresent"` |  |
| image.pullSecrets | list | `[]` |  |
| image.debug | bool | `false` |  |
| architecture | string | `"standalone"` |  |
| auth.rootPassword | string | `""` |  |
| auth.createDatabase | bool | `true` |  |
| auth.database | string | `"my_database"` |  |
| auth.username | string | `""` |  |
| auth.password | string | `""` |  |
| auth.replicationUser | string | `"replicator"` |  |
| auth.replicationPassword | string | `""` |  |
| auth.existingSecret | string | `""` |  |
| auth.usePasswordFiles | bool | `false` |  |
| auth.customPasswordFiles | object | `{}` |  |
| initdbScripts | object | `{}` |  |
| initdbScriptsConfigMap | string | `""` |  |
| primary.name | string | `"primary"` |  |
| primary.command | list | `[]` |  |
| primary.args | list | `[]` |  |
| primary.lifecycleHooks | object | `{}` |  |
| primary.hostAliases | list | `[]` |  |
| primary.configuration | string | `"[mysqld]\ndefault_authentication_plugin=mysql_native_password\nskip-name-resolve\nexplicit_defaults_for_timestamp\nbasedir=/opt/bitnami/mysql\nplugin_dir=/opt/bitnami/mysql/lib/plugin\nport=3306\nsocket=/opt/bitnami/mysql/tmp/mysql.sock\ndatadir=/bitnami/mysql/data\ntmpdir=/opt/bitnami/mysql/tmp\nmax_allowed_packet=16M\nbind-address=*\npid-file=/opt/bitnami/mysql/tmp/mysqld.pid\nlog-error=/opt/bitnami/mysql/logs/mysqld.log\ncharacter-set-server=UTF8\ncollation-server=utf8_general_ci\nslow_query_log=0\nslow_query_log_file=/opt/bitnami/mysql/logs/mysqld.log\nlong_query_time=10.0\n\n[client]\nport=3306\nsocket=/opt/bitnami/mysql/tmp/mysql.sock\ndefault-character-set=UTF8\nplugin_dir=/opt/bitnami/mysql/lib/plugin\n\n[manager]\nport=3306\nsocket=/opt/bitnami/mysql/tmp/mysql.sock\npid-file=/opt/bitnami/mysql/tmp/mysqld.pid"` |  |
| primary.existingConfigmap | string | `""` |  |
| primary.updateStrategy.type | string | `"RollingUpdate"` |  |
| primary.podAnnotations | object | `{}` |  |
| primary.podAffinityPreset | string | `""` |  |
| primary.podAntiAffinityPreset | string | `"soft"` |  |
| primary.nodeAffinityPreset.type | string | `""` |  |
| primary.nodeAffinityPreset.key | string | `""` |  |
| primary.nodeAffinityPreset.values | list | `[]` |  |
| primary.affinity | object | `{}` |  |
| primary.nodeSelector | object | `{}` |  |
| primary.tolerations | list | `[]` |  |
| primary.priorityClassName | string | `""` |  |
| primary.runtimeClassName | string | `""` |  |
| primary.schedulerName | string | `""` |  |
| primary.terminationGracePeriodSeconds | string | `""` |  |
| primary.topologySpreadConstraints | list | `[]` |  |
| primary.podManagementPolicy | string | `""` |  |
| primary.podSecurityContext.enabled | bool | `true` |  |
| primary.podSecurityContext.fsGroup | int | `1001` |  |
| primary.containerSecurityContext.enabled | bool | `true` |  |
| primary.containerSecurityContext.runAsUser | int | `1001` |  |
| primary.containerSecurityContext.runAsNonRoot | bool | `true` |  |
| primary.resources.limits | object | `{}` |  |
| primary.resources.requests | object | `{}` |  |
| primary.livenessProbe.enabled | bool | `true` |  |
| primary.livenessProbe.initialDelaySeconds | int | `5` |  |
| primary.livenessProbe.periodSeconds | int | `10` |  |
| primary.livenessProbe.timeoutSeconds | int | `1` |  |
| primary.livenessProbe.failureThreshold | int | `3` |  |
| primary.livenessProbe.successThreshold | int | `1` |  |
| primary.readinessProbe.enabled | bool | `true` |  |
| primary.readinessProbe.initialDelaySeconds | int | `5` |  |
| primary.readinessProbe.periodSeconds | int | `10` |  |
| primary.readinessProbe.timeoutSeconds | int | `1` |  |
| primary.readinessProbe.failureThreshold | int | `3` |  |
| primary.readinessProbe.successThreshold | int | `1` |  |
| primary.startupProbe.enabled | bool | `true` |  |
| primary.startupProbe.initialDelaySeconds | int | `15` |  |
| primary.startupProbe.periodSeconds | int | `10` |  |
| primary.startupProbe.timeoutSeconds | int | `1` |  |
| primary.startupProbe.failureThreshold | int | `10` |  |
| primary.startupProbe.successThreshold | int | `1` |  |
| primary.customLivenessProbe | object | `{}` |  |
| primary.customReadinessProbe | object | `{}` |  |
| primary.customStartupProbe | object | `{}` |  |
| primary.extraFlags | string | `""` |  |
| primary.extraEnvVars | list | `[]` |  |
| primary.extraEnvVarsCM | string | `""` |  |
| primary.extraEnvVarsSecret | string | `""` |  |
| primary.persistence.enabled | bool | `true` |  |
| primary.persistence.existingClaim | string | `""` |  |
| primary.persistence.subPath | string | `""` |  |
| primary.persistence.storageClass | string | `""` |  |
| primary.persistence.annotations | object | `{}` |  |
| primary.persistence.accessModes[0] | string | `"ReadWriteOnce"` |  |
| primary.persistence.size | string | `"8Gi"` |  |
| primary.persistence.selector | object | `{}` |  |
| primary.extraVolumes | list | `[]` |  |
| primary.extraVolumeMounts | list | `[]` |  |
| primary.initContainers | list | `[]` |  |
| primary.sidecars | list | `[]` |  |
| primary.service.type | string | `"ClusterIP"` |  |
| primary.service.ports.mysql | int | `3306` |  |
| primary.service.nodePorts.mysql | string | `""` |  |
| primary.service.clusterIP | string | `""` |  |
| primary.service.loadBalancerIP | string | `""` |  |
| primary.service.externalTrafficPolicy | string | `"Cluster"` |  |
| primary.service.loadBalancerSourceRanges | list | `[]` |  |
| primary.service.extraPorts | list | `[]` |  |
| primary.service.annotations | object | `{}` |  |
| primary.service.sessionAffinity | string | `"None"` |  |
| primary.service.sessionAffinityConfig | object | `{}` |  |
| primary.service.headless.annotations | object | `{}` |  |
| primary.pdb.create | bool | `false` |  |
| primary.pdb.minAvailable | int | `1` |  |
| primary.pdb.maxUnavailable | string | `""` |  |
| primary.podLabels | object | `{}` |  |
| secondary.name | string | `"secondary"` |  |
| secondary.replicaCount | int | `1` |  |
| secondary.hostAliases | list | `[]` |  |
| secondary.command | list | `[]` |  |
| secondary.args | list | `[]` |  |
| secondary.lifecycleHooks | object | `{}` |  |
| secondary.configuration | string | `"[mysqld]\ndefault_authentication_plugin=mysql_native_password\nskip-name-resolve\nexplicit_defaults_for_timestamp\nbasedir=/opt/bitnami/mysql\nplugin_dir=/opt/bitnami/mysql/lib/plugin\nport=3306\nsocket=/opt/bitnami/mysql/tmp/mysql.sock\ndatadir=/bitnami/mysql/data\ntmpdir=/opt/bitnami/mysql/tmp\nmax_allowed_packet=16M\nbind-address=*\npid-file=/opt/bitnami/mysql/tmp/mysqld.pid\nlog-error=/opt/bitnami/mysql/logs/mysqld.log\ncharacter-set-server=UTF8\ncollation-server=utf8_general_ci\nslow_query_log=0\nslow_query_log_file=/opt/bitnami/mysql/logs/mysqld.log\nlong_query_time=10.0\n\n[client]\nport=3306\nsocket=/opt/bitnami/mysql/tmp/mysql.sock\ndefault-character-set=UTF8\nplugin_dir=/opt/bitnami/mysql/lib/plugin\n\n[manager]\nport=3306\nsocket=/opt/bitnami/mysql/tmp/mysql.sock\npid-file=/opt/bitnami/mysql/tmp/mysqld.pid"` |  |
| secondary.existingConfigmap | string | `""` |  |
| secondary.updateStrategy.type | string | `"RollingUpdate"` |  |
| secondary.podAnnotations | object | `{}` |  |
| secondary.podAffinityPreset | string | `""` |  |
| secondary.podAntiAffinityPreset | string | `"soft"` |  |
| secondary.nodeAffinityPreset.type | string | `""` |  |
| secondary.nodeAffinityPreset.key | string | `""` |  |
| secondary.nodeAffinityPreset.values | list | `[]` |  |
| secondary.affinity | object | `{}` |  |
| secondary.nodeSelector | object | `{}` |  |
| secondary.tolerations | list | `[]` |  |
| secondary.priorityClassName | string | `""` |  |
| secondary.runtimeClassName | string | `""` |  |
| secondary.schedulerName | string | `""` |  |
| secondary.terminationGracePeriodSeconds | string | `""` |  |
| secondary.topologySpreadConstraints | list | `[]` |  |
| secondary.podManagementPolicy | string | `""` |  |
| secondary.podSecurityContext.enabled | bool | `true` |  |
| secondary.podSecurityContext.fsGroup | int | `1001` |  |
| secondary.containerSecurityContext.enabled | bool | `true` |  |
| secondary.containerSecurityContext.runAsUser | int | `1001` |  |
| secondary.containerSecurityContext.runAsNonRoot | bool | `true` |  |
| secondary.resources.limits | object | `{}` |  |
| secondary.resources.requests | object | `{}` |  |
| secondary.livenessProbe.enabled | bool | `true` |  |
| secondary.livenessProbe.initialDelaySeconds | int | `5` |  |
| secondary.livenessProbe.periodSeconds | int | `10` |  |
| secondary.livenessProbe.timeoutSeconds | int | `1` |  |
| secondary.livenessProbe.failureThreshold | int | `3` |  |
| secondary.livenessProbe.successThreshold | int | `1` |  |
| secondary.readinessProbe.enabled | bool | `true` |  |
| secondary.readinessProbe.initialDelaySeconds | int | `5` |  |
| secondary.readinessProbe.periodSeconds | int | `10` |  |
| secondary.readinessProbe.timeoutSeconds | int | `1` |  |
| secondary.readinessProbe.failureThreshold | int | `3` |  |
| secondary.readinessProbe.successThreshold | int | `1` |  |
| secondary.startupProbe.enabled | bool | `true` |  |
| secondary.startupProbe.initialDelaySeconds | int | `15` |  |
| secondary.startupProbe.periodSeconds | int | `10` |  |
| secondary.startupProbe.timeoutSeconds | int | `1` |  |
| secondary.startupProbe.failureThreshold | int | `15` |  |
| secondary.startupProbe.successThreshold | int | `1` |  |
| secondary.customLivenessProbe | object | `{}` |  |
| secondary.customReadinessProbe | object | `{}` |  |
| secondary.customStartupProbe | object | `{}` |  |
| secondary.extraFlags | string | `""` |  |
| secondary.extraEnvVars | list | `[]` |  |
| secondary.extraEnvVarsCM | string | `""` |  |
| secondary.extraEnvVarsSecret | string | `""` |  |
| secondary.persistence.enabled | bool | `true` |  |
| secondary.persistence.existingClaim | string | `""` |  |
| secondary.persistence.subPath | string | `""` |  |
| secondary.persistence.storageClass | string | `""` |  |
| secondary.persistence.annotations | object | `{}` |  |
| secondary.persistence.accessModes[0] | string | `"ReadWriteOnce"` |  |
| secondary.persistence.size | string | `"8Gi"` |  |
| secondary.persistence.selector | object | `{}` |  |
| secondary.extraVolumes | list | `[]` |  |
| secondary.extraVolumeMounts | list | `[]` |  |
| secondary.initContainers | list | `[]` |  |
| secondary.sidecars | list | `[]` |  |
| secondary.service.type | string | `"ClusterIP"` |  |
| secondary.service.ports.mysql | int | `3306` |  |
| secondary.service.nodePorts.mysql | string | `""` |  |
| secondary.service.clusterIP | string | `""` |  |
| secondary.service.loadBalancerIP | string | `""` |  |
| secondary.service.externalTrafficPolicy | string | `"Cluster"` |  |
| secondary.service.loadBalancerSourceRanges | list | `[]` |  |
| secondary.service.extraPorts | list | `[]` |  |
| secondary.service.annotations | object | `{}` |  |
| secondary.service.sessionAffinity | string | `"None"` |  |
| secondary.service.sessionAffinityConfig | object | `{}` |  |
| secondary.service.headless.annotations | object | `{}` |  |
| secondary.pdb.create | bool | `false` |  |
| secondary.pdb.minAvailable | int | `1` |  |
| secondary.pdb.maxUnavailable | string | `""` |  |
| secondary.podLabels | object | `{}` |  |
| serviceAccount.create | bool | `true` |  |
| serviceAccount.name | string | `""` |  |
| serviceAccount.annotations | object | `{}` |  |
| serviceAccount.automountServiceAccountToken | bool | `true` |  |
| rbac.create | bool | `false` |  |
| rbac.rules | list | `[]` |  |
| networkPolicy.enabled | bool | `false` |  |
| networkPolicy.allowExternal | bool | `true` |  |
| networkPolicy.explicitNamespacesSelector | object | `{}` |  |
| volumePermissions.enabled | bool | `false` |  |
| volumePermissions.image.registry | string | `"docker.io"` |  |
| volumePermissions.image.repository | string | `"bitnami/bitnami-shell"` |  |
| volumePermissions.image.tag | string | `"11-debian-11-r75"` |  |
| volumePermissions.image.digest | string | `""` |  |
| volumePermissions.image.pullPolicy | string | `"IfNotPresent"` |  |
| volumePermissions.image.pullSecrets | list | `[]` |  |
| volumePermissions.resources | object | `{}` |  |
| metrics.enabled | bool | `false` |  |
| metrics.image.registry | string | `"docker.io"` |  |
| metrics.image.repository | string | `"bitnami/mysqld-exporter"` |  |
| metrics.image.tag | string | `"0.14.0-debian-11-r81"` |  |
| metrics.image.digest | string | `""` |  |
| metrics.image.pullPolicy | string | `"IfNotPresent"` |  |
| metrics.image.pullSecrets | list | `[]` |  |
| metrics.service.type | string | `"ClusterIP"` |  |
| metrics.service.port | int | `9104` |  |
| metrics.service.annotations."prometheus.io/scrape" | string | `"true"` |  |
| metrics.service.annotations."prometheus.io/port" | string | `"{{ .Values.metrics.service.port }}"` |  |
| metrics.extraArgs.primary | list | `[]` |  |
| metrics.extraArgs.secondary | list | `[]` |  |
| metrics.resources.limits | object | `{}` |  |
| metrics.resources.requests | object | `{}` |  |
| metrics.livenessProbe.enabled | bool | `true` |  |
| metrics.livenessProbe.initialDelaySeconds | int | `120` |  |
| metrics.livenessProbe.periodSeconds | int | `10` |  |
| metrics.livenessProbe.timeoutSeconds | int | `1` |  |
| metrics.livenessProbe.successThreshold | int | `1` |  |
| metrics.livenessProbe.failureThreshold | int | `3` |  |
| metrics.readinessProbe.enabled | bool | `true` |  |
| metrics.readinessProbe.initialDelaySeconds | int | `30` |  |
| metrics.readinessProbe.periodSeconds | int | `10` |  |
| metrics.readinessProbe.timeoutSeconds | int | `1` |  |
| metrics.readinessProbe.successThreshold | int | `1` |  |
| metrics.readinessProbe.failureThreshold | int | `3` |  |
| metrics.serviceMonitor.enabled | bool | `false` |  |
| metrics.serviceMonitor.namespace | string | `""` |  |
| metrics.serviceMonitor.jobLabel | string | `""` |  |
| metrics.serviceMonitor.interval | string | `"30s"` |  |
| metrics.serviceMonitor.scrapeTimeout | string | `""` |  |
| metrics.serviceMonitor.relabelings | list | `[]` |  |
| metrics.serviceMonitor.metricRelabelings | list | `[]` |  |
| metrics.serviceMonitor.selector | object | `{}` |  |
| metrics.serviceMonitor.honorLabels | bool | `false` |  |
| metrics.serviceMonitor.labels | object | `{}` |  |
| metrics.serviceMonitor.annotations | object | `{}` |  |
| metrics.prometheusRule.enabled | bool | `false` |  |
| metrics.prometheusRule.namespace | string | `""` |  |
| metrics.prometheusRule.additionalLabels | object | `{}` |  |
| metrics.prometheusRule.rules | list | `[]` |  |

----------------------------------------------
Autogenerated from chart metadata using [helm-docs v1.11.3](https://github.com/norwoodj/helm-docs/releases/v1.11.3)

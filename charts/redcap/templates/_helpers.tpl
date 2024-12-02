{{/*
Expand the name of the chart.
*/}}
{{- define "redcap.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "redcap.adminJob.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}-admin-job
{{- end }}

{{- define "redcap.initJob.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}-init-job
{{- end }}

{{- define "redcap.backupJob.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}-backup-job
{{- end }}

{{- define "redcap.restoreJob.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}-restore-job
{{- end }}


{{- define "httpd.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}-httpd
{{- end }}

{{- define "audit.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}-db-audit
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "redcap.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{- define "redcap.initJob.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}-init-job
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}-init-job
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}-init-job
{{- end }}
{{- end }}
{{- end }}

{{- define "redcap.adminJob.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}-admin-job
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}-admin-job
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}-admin-job
{{- end }}
{{- end }}
{{- end }}

{{- define "redcap.backupJob.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}-backup-job
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}-backup-job
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}-backup-job
{{- end }}
{{- end }}
{{- end }}

{{- define "redcap.restoreJob.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}-restore-job
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}-restore-job
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}-restore-job
{{- end }}
{{- end }}
{{- end }}

{{- define "httpd.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}-httpd
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}-httpd
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}-httpd
{{- end }}
{{- end }}
{{- end }}

{{- define "audit.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}-db-audit
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}-httpd
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}-httpd
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "redcap.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "redcap.labels" -}}
helm.sh/chart: {{ include "redcap.chart" . }}
{{ include "redcap.selectorLabels" . }}
{{ include "redcap.networkPolicy.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "redcap.initJob.labels" -}}
helm.sh/chart: {{ include "redcap.chart" . }}
{{ include "redcap.initJob.selectorLabels" . }}
{{ include "redcap.initJob.networkPolicy.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "redcap.adminJob.labels" -}}
helm.sh/chart: {{ include "redcap.chart" . }}
{{ include "redcap.adminJob.selectorLabels" . }}
{{ include "redcap.adminJob.networkPolicy.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "redcap.backupJob.labels" -}}
helm.sh/chart: {{ include "redcap.chart" . }}
{{ include "redcap.backupJob.selectorLabels" . }}
{{ include "redcap.backupJob.networkPolicy.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "redcap.restoreJob.labels" -}}
helm.sh/chart: {{ include "redcap.chart" . }}
{{ include "redcap.restoreJob.selectorLabels" . }}
{{ include "redcap.restoreJob.networkPolicy.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "httpd.labels" -}}
helm.sh/chart: {{ include "redcap.chart" . }}
{{ include "httpd.selectorLabels" . }}
{{ include "httpd.networkPolicy.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{- define "audit.labels" -}}
helm.sh/chart: {{ include "redcap.chart" . }}
{{ include "audit.selectorLabels" . }}
{{ include "audit.networkPolicy.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}


{{/*
Selector labels
*/}}
{{- define "redcap.selectorLabels" -}}
app.kubernetes.io/name: {{ include "redcap.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "redcap.initJob.selectorLabels" -}}
app.kubernetes.io/name: {{ include "redcap.initJob.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "redcap.adminJob.selectorLabels" -}}
app.kubernetes.io/name: {{ include "redcap.adminJob.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "redcap.backupJob.selectorLabels" -}}
app.kubernetes.io/name: {{ include "redcap.backupJob.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "redcap.restoreJob.selectorLabels" -}}
app.kubernetes.io/name: {{ include "redcap.restoreJob.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "httpd.selectorLabels" -}}
app.kubernetes.io/name: {{ include "httpd.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{- define "audit.selectorLabels" -}}
app.kubernetes.io/name: {{ include "audit.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Networkpolicies selector labels
*/}}
{{- define "redcap.networkPolicy.selectorLabels" -}}
app.kubernetes.io/role: redcap-app
{{- end }}

{{- define "redcap.initJob.networkPolicy.selectorLabels" -}}
app.kubernetes.io/role: redcap-init-job
{{- end }}

{{- define "redcap.adminJob.networkPolicy.selectorLabels" -}}
app.kubernetes.io/role: redcap-admin-job
{{- end }}

{{- define "redcap.backupJob.networkPolicy.selectorLabels" -}}
app.kubernetes.io/role: redcap-backup-job
{{- end }}

{{- define "redcap.restoreJob.networkPolicy.selectorLabels" -}}
app.kubernetes.io/role: redcap-restore-job
{{- end }}

{{- define "httpd.networkPolicy.selectorLabels" -}}
app.kubernetes.io/role: redcap-httpd
{{- end }}

{{- define "audit.networkPolicy.selectorLabels" -}}
app.kubernetes.io/role: redcap-db-audit
{{- end }}

{{/*
Secrets names
*/}}
{{- define "redcap.secrets.msmtprc.conf.name" -}}
{{ .Release.Name }}-msmtprc-conf
{{- end }}

{{- define "redcap.secrets.database.creds.name" -}}
{{ .Release.Name }}-database-credentials
{{- end }}

{{- define "redcap.secrets.community.creds.name" -}}
{{ .Release.Name }}-community-credentials
{{- end }}

{{- define "redcap.secrets.init.rclone.conf.name" -}}
{{ .Release.Name }}-init-rclone-conf
{{- end }}

{{- define "redcap.secrets.backup.rclone.conf.name" -}}
{{ .Release.Name }}-backup-rclone-conf
{{- end }}

{{- define "redcap.secrets.restore.rclone.conf.name" -}}
{{ .Release.Name }}-restore-rclone-conf
{{- end }}

{{- define "redcap.secrets.db-audit.creds.name" -}}
{{ .Release.Name }}-db-audit-credentials
{{- end }}

{{/*
Persistence volumes names
*/}}
{{- define "redcap.persistence.code.pvc.name" -}}
{{ .Release.Name }}-code-pvc
{{- end }}

{{- define "redcap.persistence.edocs.pvc.name" -}}
{{ .Release.Name }}-edocs-pvc
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "redcap.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "redcap.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Create the name of the service to use
*/}}
{{- define "redcap.serviceName" -}}
{{ include "redcap.fullname" . }}-svc
{{- end }}

{{/*
Create the name of the service to use
*/}}
{{- define "httpd.serviceName" -}}
{{ include "httpd.fullname" . }}-svc
{{- end }}

{{- define "dex.postgresHost" -}}
{{- if .Values.externalPostgresql.enabled -}}
{{ .Values.externalPostgresql.endpoint }}
{{- else -}}
{{- include "postgres.endpoint" . -}}
{{- end -}}
{{- end -}}

{{- define "dex.postgresPort" -}}
{{- if .Values.externalPostgresql.enabled -}}
{{ .Values.opensecurity.custom.externalPostgresql.port }}
{{- else -}}
{{- include "postgres.port" . -}}
{{- end -}}
{{- end -}}

{{/*
Update the config file to replcae all occurances of DOMAIN_NAME_PLACEHOLDER_DO_NOT_CHANGE with .Values.global.domain
*/}}
{{- define "dex.config" -}}
{{- $config := .Values.dex.config | toYaml | replace "DOMAIN_NAME_PLACEHOLDER_DO_NOT_CHANGE" .Values.global.domain }}
{{- default $config "" }}
{{- end }}


{{/*
Create chart name and version as used by the chart label.
THIS IS THE MISSING ONE YOU NEED
*/}}
{{- define "opensecurity.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}



{{/*
Common labels
*/}}
{{- define "opensecurity.labels" -}}
helm.sh/chart: {{ include "opensecurity.chart" . }}
{{ include "opensecurity.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Selector labels
*/}}
{{- define "opensecurity.selectorLabels" -}}
app.kubernetes.io/name: {{ include "opensecurity.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "opensecurity.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
{{- default (include "opensecurity.fullname" .) .Values.serviceAccount.name -}}
{{- else -}}
{{- default "default" .Values.serviceAccount.name -}}
{{- end -}}
{{- end -}}
{{/* vim: set filetype=mustache: */}}
{{/*
Expand the name of the chart.
*/}}
{{- define "opensecurity.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "opensecurity.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

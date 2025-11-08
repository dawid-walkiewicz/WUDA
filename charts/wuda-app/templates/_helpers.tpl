{{/*
Expand the name of the chart.
*/}}
{{ define "wuda-app.name" -}}
{{ default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "wuda-app.fullname" -}}
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

{{- define "wuda-app.fullnameBackend" -}}
  {{- $nameLength := int (sub 63 8) -}}
  {{- if .Values.fullnameOverride }}
    {{- .Values.fullnameOverride | trunc $nameLength | trimSuffix "-" | printf "%s-backend" -}}
  {{- else if .Values.nameOverride }}
    {{- .Values.nameOverride | trunc $nameLength | trimSuffix "-" | printf "%s-backend" -}}
   {{- else }}
    {{- .Release.Name | trunc $nameLength | trimSuffix "-" | printf "%s-backend" -}}
  {{- end }}
{{- end }}

{{- define "wuda-app.fullnameFrontend" -}}
  {{- $nameLength := int (sub 63 8) -}}
  {{- if .Values.fullnameOverride }}
    {{- .Values.fullnameOverride | trunc $nameLength | trimSuffix "-" | printf "%s-frontend" -}}
  {{- else if .Values.nameOverride }}
    {{- .Values.nameOverride | trunc $nameLength | trimSuffix "-" | printf "%s-frontend" -}}
   {{- else }}
    {{- .Release.Name | trunc $nameLength | trimSuffix "-" | printf "%s-frontend" -}}
  {{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{ define "wuda-app.chart" -}}
{{ printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{ define "wuda-app.labels" -}}
helm.sh/chart: {{ include "wuda-app.chart" . }}
{{ include "wuda-app.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{ define "wuda-app.labelsBackend" -}}
helm.sh/chart: {{ include "wuda-app.chart" . }}
{{ include "wuda-app.selectorLabelsBackend" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{ define "wuda-app.labelsFrontend" -}}
helm.sh/chart: {{ include "wuda-app.chart" . }}
{{ include "wuda-app.selectorLabelsFrontend" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{ define "wuda-app.selectorLabels" -}}
app.kubernetes.io/name: {{ include "wuda-app.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{ define "wuda-app.selectorLabelsBackend" -}}
app.kubernetes.io/name: {{ include "wuda-app.name" . }}-backend
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{ define "wuda-app.selectorLabelsFrontend" -}}
app.kubernetes.io/name: {{ include "wuda-app.name" . }}-frontend
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{ define "wuda-app.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{ default (include "wuda-app.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{ default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Expand the name of the chart.
*/}}
{{- define "mlflow.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "mlflow.fullname" -}}
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

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "mlflow.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "mlflow.labels" -}}
helm.sh/chart: {{ include "mlflow.chart" . }}
{{ include "mlflow.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "mlflow.selectorLabels" -}}
app.kubernetes.io/name: {{ include "mlflow.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "mlflow.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "mlflow.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}


{{/*
The SQLAlchemy backend connection string depends on whether the postgres subchart is enabled or not
*/}}
{{- define "mlflow.db.connection" -}}
{{- if .Values.postgresql.enabled }}
{{- printf "postgresql://%s:%s@%s:%d/%s" .Values.postgresql.auth.username .Values.postgresql.auth.password (printf "%s-%s" .Release.Name "postgresql") 5432 .Values.postgresql.auth.database }}
{{- else }}
{{ required "If not postgresql.enabled, backendStore.backendStoreUri is required" .Values.backendStore.backendStoreUri }}
{{- end }}
{{- end }}

{{/*
The S3 endpoint to use (if minio enabled, use that, otherwise use whatever specified in values)
*/}}
{{- define "mlflow.s3.endpoint" -}}
{{- if .Values.minio.enabled }}
{{- printf "http://%s-minio:%d" .Release.Name 9000 }}
{{- else }}
{{- default "" .Values.artifactStore.s3EndpointUrl }}
{{- end }}
{{- end }}

{{/*
The S3 bucket to use (if minio enabled, use that, otherwise use whatever specified in values)
*/}}
{{- define "mlflow.artifact.root" -}}
{{- if .Values.minio.enabled }}
{{- printf "s3://%s" .Values.minio.defaultBuckets }}
{{- else }}
{{- default "" .Values.artifactStore.defaultArtifactRoot }}
{{- end }}
{{- end }}

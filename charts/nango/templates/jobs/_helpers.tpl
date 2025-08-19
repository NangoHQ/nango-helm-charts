{{/*
Expand the name of the chart.
*/}}
{{- define "jobs.names.name" -}}
{{- default (printf "%s-%s" (include "common.names.name" .) .Values.jobs.name) .Values.jobs.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "jobs.names.fullname" -}}
{{- default (printf "%s-%s" (include "common.names.fullname" .) .Values.jobs.name) .Values.jobs.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "jobs.names.component" -}}
{{- default "jobs" .Values.jobs.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "jobs.names.service" -}}
{{- printf "%s-svc" (include "jobs.names.fullname" .)  -}}
{{- end -}}

{{/*
Component URL helpers
*/}}
{{- define "nango.jobs.url" -}}
http://{{ include "jobs.names.name" . }}.{{ .Release.Namespace }}
{{- end }}

{{/*
Allow the release namespace to be overridden for multi-namespace deployments in combined charts.
*/}}
{{- define "jobs.names.namespace" -}}
{{- default (include "common.names.namespace" .) .Values.jobs.namespaceOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "jobs.names.serviceAccountName" -}}
{{- if .Values.jobs.serviceAccount.create -}}
    {{ default (include "jobs.names.fullname" .) .Values.jobs.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.jobs.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Return the proper jobs image name
*/}}
{{- define "jobs.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.jobs.image "global" .Values.global.image) }}
{{- end -}}

{{- define "jobs.images.pullPolicy" -}}
{{ include "common.images.pullPolicy" (dict "imageRoot" .Values.jobs.image "global" .Values.global.image)}}
{{- end -}}
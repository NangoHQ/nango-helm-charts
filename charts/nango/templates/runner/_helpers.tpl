{{/*
Expand the name of the chart.
*/}}
{{- define "runner.names.name" -}}
{{- default (printf "%s-%s" (include "common.names.name" .) .Values.runner.name) .Values.runner.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "runner.names.fullname" -}}
{{- default (printf "%s-%s" (include "common.names.fullname" .) .Values.runner.name) .Values.runner.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "runner.names.component" -}}
{{- default "runner" .Values.runner.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Component URL helpers
*/}}
{{- define "nango.runner.url" -}}
http://{{ include "runner.names.name" . }}.{{ .Release.Namespace }}
{{- end }}

{{/*
Allow the release namespace to be overridden for multi-namespace deployments in combined charts.
*/}}
{{- define "runner.names.namespace" -}}
{{- default (include "common.names.namespace" .) .Values.runner.namespaceOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "runner.names.serviceAccountName" -}}
{{- if .Values.runner.serviceAccount.create -}}
    {{ default (include "runner.names.fullname" .) .Values.runner.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.runner.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Return the proper runner image name
*/}}
{{- define "runner.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.runner.image "global" .Values.global.image) }}
{{- end -}}

{{- define "runner.images.pullPolicy" -}}
{{ include "common.images.pullPolicy" (dict "imageRoot" .Values.runner.image "global" .Values.global.image)}}
{{- end -}}
{{/*
Expand the name of the chart.
*/}}
{{- define "metering.names.name" -}}
{{- default (printf "%s-%s" (include "common.names.name" .) .Values.metering.name) .Values.metering.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "metering.names.fullname" -}}
{{- default (printf "%s-%s" (include "common.names.fullname" .) .Values.metering.name) .Values.metering.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "metering.names.component" -}}
{{- default "metering" .Values.metering.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "metering.names.service" -}}
{{- printf "%s-svc" (include "metering.names.fullname" .)  -}}
{{- end -}}

{{/*
Component URL helpers
*/}}
{{- define "nango.metering.url" -}}
http://{{ include "metering.names.name" . }}.{{ .Release.Namespace }}
{{- end }}

{{/*
Allow the release namespace to be overridden for multi-namespace deployments in combined charts.
*/}}
{{- define "metering.names.namespace" -}}
{{- default (include "common.names.namespace" .) .Values.metering.namespaceOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "metering.names.serviceAccountName" -}}
{{- if .Values.metering.serviceAccount.create -}}
    {{ default (include "metering.names.fullname" .) .Values.metering.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.metering.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Return the proper metering image name
*/}}
{{- define "metering.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.metering.image "global" .Values.global.image) }}
{{- end -}}

{{- define "metering.images.pullPolicy" -}}
{{ include "common.images.pullPolicy" (dict "imageRoot" .Values.metering.image "global" .Values.global.image)}}
{{- end -}}
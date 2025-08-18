{{/*
Expand the name of the chart.
*/}}
{{- define "persist.names.name" -}}
{{- default (printf "%s-%s" (include "common.names.name" .) .Values.persist.name) .Values.persist.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "persist.names.fullname" -}}
{{- default (printf "%s-%s" (include "common.names.fullname" .) .Values.persist.name) .Values.persist.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "persist.names.component" -}}
{{- default "persist" .Values.persist.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Component URL helpers
*/}}
{{- define "nango.persist.url" -}}
http://{{ include "persist.names.name" . }}.{{ .Release.Namespace }}
{{- end }}

{{/*
Allow the release namespace to be overridden for multi-namespace deployments in combined charts.
*/}}
{{- define "persist.names.namespace" -}}
{{- default (include "common.names.namespace" .) .Values.persist.namespaceOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "persist.names.serviceAccountName" -}}
{{- if .Values.persist.serviceAccount.create -}}
    {{ default (include "common.names.fullname" .) .Values.persist.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.persist.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Return the proper persist image name
*/}}
{{- define "persist.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.persist.image "global" .Values.global.image) }}
{{- end -}}

{{- define "persist.images.pullPolicy" -}}
{{ include "common.images.pullPolicy" (dict "imageRoot" .Values.persist.image "global" .Values.global.image)}}
{{- end -}}
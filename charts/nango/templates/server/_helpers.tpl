{{/*
Expand the name of the chart.
*/}}
{{- define "server.names.name" -}}
{{- default (printf "%s-%s" (include "common.names.name" .) .Values.server.name) .Values.server.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "server.names.fullname" -}}
{{- default (printf "%s-%s" (include "common.names.fullname" .) .Values.server.name) .Values.server.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "server.names.component" -}}
{{- default "server" .Values.server.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "server.names.service" -}}
{{- printf "%s-svc" (include "server.names.fullname" .)  -}}
{{- end -}}

{{/*
Component URL helpers
*/}}
{{- define "nango.server.url" -}}
http://{{ include "server.names.name" . }}.{{ .Release.Namespace }}
{{- end }}

{{/*
Allow the release namespace to be overridden for multi-namespace deployments in combined charts.
*/}}
{{- define "server.names.namespace" -}}
{{- default (include "common.names.namespace" .) .Values.server.namespaceOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "server.names.serviceAccountName" -}}
{{- if .Values.server.serviceAccount.create -}}
    {{ default (include "server.names.fullname" .) .Values.server.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.server.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Return the proper server image name
*/}}
{{- define "server.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.server.image "global" .Values.global.image) }}
{{- end -}}

{{- define "server.images.pullPolicy" -}}
{{ include "common.images.pullPolicy" (dict "imageRoot" .Values.server.image "global" .Values.global.image)}}
{{- end -}}
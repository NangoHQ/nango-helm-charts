{{/*
Expand the name of the chart.
*/}}
{{- define "selfHosting.names.name" -}}
{{- default (printf "%s-%s" (include "common.names.name" .) .Values.selfHosting.name) .Values.selfHosting.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "selfHosting.names.fullname" -}}
{{- default (printf "%s-%s" (include "common.names.fullname" .) .Values.selfHosting.name) .Values.selfHosting.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "selfHosting.names.component" -}}
{{- default "self-hosting" .Values.selfHosting.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "selfHosting.names.service" -}}
{{- printf "%s-svc" (include "selfHosting.names.fullname" .)  -}}
{{- end -}}

{{/*
Component URL helpers
*/}}
{{- define "nango.selfHosting.url" -}}
http://{{ include "selfHosting.names.name" . }}.{{ .Release.Namespace }}
{{- end }}

{{/*
Allow the release namespace to be overridden for multi-namespace deployments in combined charts.
*/}}
{{- define "selfHosting.names.namespace" -}}
{{- default (include "common.names.namespace" .) .Values.selfHosting.namespaceOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "selfHosting.names.serviceAccountName" -}}
{{- if .Values.selfHosting.serviceAccount.create -}}
    {{ default (include "selfHosting.names.fullname" .) .Values.selfHosting.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.selfHosting.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Return the proper self-hosting image name
*/}}
{{- define "selfHosting.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.selfHosting.image "global" .Values.global.image) }}
{{- end -}}

{{- define "selfHosting.images.pullPolicy" -}}
{{ include "common.images.pullPolicy" (dict "imageRoot" .Values.selfHosting.image "global" .Values.global.image)}}
{{- end -}}
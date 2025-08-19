{{/*
Expand the name of the chart.
*/}}
{{- define "orchestrator.names.name" -}}
{{- default (printf "%s-%s" (include "common.names.name" .) .Values.orchestrator.name) .Values.orchestrator.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "orchestrator.names.fullname" -}}
{{- default (printf "%s-%s" (include "common.names.fullname" .) .Values.orchestrator.name) .Values.orchestrator.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "orchestrator.names.component" -}}
{{- default "orchestrator" .Values.orchestrator.name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "orchestrator.names.service" -}}
{{- printf "%s-svc" (include "orchestrator.names.fullname" .)  -}}
{{- end -}}

{{/*
Component URL helpers
*/}}
{{- define "nango.orchestrator.url" -}}
http://{{ include "orchestrator.names.name" . }}.{{ .Release.Namespace }}
{{- end }}

{{/*
Allow the release namespace to be overridden for multi-namespace deployments in combined charts.
*/}}
{{- define "orchestrator.names.namespace" -}}
{{- default (include "common.names.namespace" .) .Values.orchestrator.namespaceOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create the name of the service account to use
*/}}
{{- define "orchestrator.names.serviceAccountName" -}}
{{- if .Values.orchestrator.serviceAccount.create -}}
    {{ default (include "orchestrator.names.fullname" .) .Values.orchestrator.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.orchestrator.serviceAccount.name }}
{{- end -}}
{{- end -}}

{{/*
Return the proper orchestrator image name
*/}}
{{- define "orchestrator.image" -}}
{{ include "common.images.image" (dict "imageRoot" .Values.orchestrator.image "global" .Values.global.image) }}
{{- end -}}

{{- define "orchestrator.images.pullPolicy" -}}
{{ include "common.images.pullPolicy" (dict "imageRoot" .Values.orchestrator.image "global" .Values.global.image)}}
{{- end -}}
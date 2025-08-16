{{/*
Component name helpers
*/}}
{{- define "nango.orchestrator.name" -}}
{{- .Values.orchestrator.name | default "nango-orchestrator-default" -}}
{{- end }}

{{- define "nango.persist.name" -}}
{{- .Values.persist.name | default "nango-persist-default" -}}
{{- end }}

{{- define "nango.runner.name" -}}
{{- .Values.runner.name | default "nango-runner-default" -}}
{{- end }}

{{- define "nango.jobs.name" -}}
{{- .Values.jobs.name | default "nango-jobs-default" -}}
{{- end }}

{{/*
Component URL helpers
*/}}
{{- define "nango.server.url" -}}
http://{{ include "server.names.component" . }}.{{ .Release.Namespace }}
{{- end }}

{{- define "nango.orchestrator.url" -}}
http://{{ include "nango.orchestrator.name" . }}.{{ .Release.Namespace }}
{{- end }}

{{- define "nango.persist.url" -}}
http://{{ include "nango.persist.name" . }}.{{ .Release.Namespace }}
{{- end }}

{{- define "nango.runner.url" -}}
http://{{ include "nango.runner.name" . }}.{{ .Release.Namespace }}
{{- end }}

{{- define "nango.jobs.url" -}}
http://{{ include "nango.jobs.name" . }}.{{ .Release.Namespace }}
{{- end }}

{{/*
Component service account names
*/}}
{{- define "nango.jobs.serviceAccountName" -}}
{{- include "nango.jobs.name" . }}-sa
{{- end }}

{{/*
Component cluster role names
*/}}
{{- define "nango.jobs.clusterRoleName" -}}
{{- include "nango.jobs.name" . }}-clusterrole
{{- end }}

{{- define "nango.jobs.clusterRoleBindingName" -}}
{{- include "nango.jobs.name" . }}-clusterrolebinding
{{- end }} 


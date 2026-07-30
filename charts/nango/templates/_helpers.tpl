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
Component URL helpers.

Built from `<component>.names.service` and the Service port, so they resolve to the Services this
chart actually creates. The component name has no DNS record of its own.
*/}}
{{- define "nango.server.url" -}}
http://{{ include "server.names.service" . }}.{{ include "server.names.namespace" . }}:{{ .Values.server.service.ports.http }}
{{- end }}

{{- define "nango.orchestrator.url" -}}
http://{{ include "orchestrator.names.service" . }}.{{ include "orchestrator.names.namespace" . }}:{{ .Values.orchestrator.service.ports.http }}
{{- end }}

{{- define "nango.persist.url" -}}
http://{{ include "persist.names.service" . }}.{{ include "persist.names.namespace" . }}:{{ .Values.persist.service.ports.http }}
{{- end }}

{{- define "nango.runner.url" -}}
http://{{ include "runner.names.service" . }}.{{ include "runner.names.namespace" . }}:{{ .Values.runner.service.ports.http }}
{{- end }}

{{- define "nango.jobs.url" -}}
http://{{ include "jobs.names.service" . }}.{{ include "jobs.names.namespace" . }}:{{ .Values.jobs.service.ports.http }}
{{- end }}

{{- define "nango.metering.url" -}}
http://{{ include "metering.names.service" . }}.{{ include "metering.names.namespace" . }}:{{ .Values.metering.service.ports.http }}
{{- end }}

{{/*
In-cluster URLs for the Nango services, as environment variables.

Nango defaults these to localhost, which only holds when every service shares a host. In this chart
each is a separate Deployment, so without them the runner cannot reach persist (localhost:3007) or
jobs (localhost:3005). Emitted before `extraEnvVars` so operators can still override any of them.
*/}}
{{- define "nango.serviceUrlEnv" -}}
- name: ORCHESTRATOR_SERVICE_URL
  value: {{ include "nango.orchestrator.url" . | quote }}
- name: PERSIST_SERVICE_URL
  value: {{ include "nango.persist.url" . | quote }}
- name: JOBS_SERVICE_URL
  value: {{ include "nango.jobs.url" . | quote }}
{{- if .Values.runner.enabled }}
- name: RUNNER_SERVICE_URL
  value: {{ include "nango.runner.url" . | quote }}
{{- end }}
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


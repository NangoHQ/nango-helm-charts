{{/*
Return the proper image name.
*/}}
{{- define "common.images.image" -}}
{{- $registryName := default ((.global).registry) .imageRoot.registry  -}}
{{- $repositoryName := default ((.global).repository) .imageRoot.repository  -}}
{{- $separator := ":" -}}
{{- $termination := default ((.global).tag) .imageRoot.tag | toString -}}

{{- if not (default ((.global).tag).imageRoot.tag) }}
  {{- if .chart }}
    {{- $termination = .chart.AppVersion | toString -}}
  {{- end -}}
{{- end -}}
{{- if default ((.global).digest) .imageRoot.digest }}
    {{- $separator = "@" -}}
    {{- $termination = .imageRoot.digest | toString -}}
{{- end -}}
{{- if $registryName }}
    {{- printf "%s/%s%s%s" $registryName $repositoryName $separator $termination -}}
{{- else -}}
    {{- printf "%s%s%s"  $repositoryName $separator $termination -}}
{{- end -}}
{{- end -}}

{{- define "common.images.pullPolicy" -}}
{{- default ((.global).pullPolicy .imageRoot.pullPolicy) -}}
{{- end -}}
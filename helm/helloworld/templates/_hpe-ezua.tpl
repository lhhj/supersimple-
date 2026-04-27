{{/*
HPE EZUA labels — required by PCAI to identify the app, enable monitoring,
scheduling and GPU metering. Apply to all Deployment/StatefulSet/Pod resources.
*/}}
{{- define "hpe-ezua.labels" -}}
hpe-ezua/app: {{ .Release.Name }}
hpe-ezua/type: vendor-service
{{- end }}

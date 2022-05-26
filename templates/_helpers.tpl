{{/*
Expand the name of the chart.
*/}}
{{- define "bold-reports.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "bold-reports.ingress.name" -}}
{{- if .Values.ingress.nameOverride }}
{{- .Values.ingress.nameOverride }}
{{- else }}
{{- include "bold-reports.fullname" . }}-ingress
{{- end }}
{{- end }}

{{/*
Returns the name of the storage class.
*/}}
{{- define "bold-reports.persistence.storageClass.name" -}}
{{- if .Values.persistence.storageClass.name -}}
{{- .Values.persistence.storageClass.name -}}
{{- else -}}
{{- include "bold-reports.fullname" . -}}-efs
{{- end -}}
{{- end }}
{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "bold-reports.fullname" -}}
{{- include "common.names.fullname" . -}}
{{- end }}

{{/*
Return true if a configmap object should be created for keycloak-config-cli
*/}}
{{- define "bold-reports.createConfigmap" -}}
{{- if and .Values.configMap.enabled .Values.configMap.configuration (not .Values.configMap.existingConfigmap) -}}
    {{- true -}}
{{- end -}}
{{- end -}}

{{/*
Return the proper Docker Image Registry Secret Names
*/}}
{{- define "bold-reports.imagePullSecrets" -}}
{{- include "common.images.renderPullSecrets" (dict "images" (list .Values.imagePullSecrets) "context" $) -}}
{{- end -}}
{{/*
Returns the readinessProbe for Jobs.
*/}}
{{- define "bold-reports.jobs.readinessProbe" -}}
readinessProbe: {{- .Values.jobs.readinessProbe | toYaml | trim | nindent 2 -}}
{{- end -}}
{{/*
Returns the readinessProbe for Designer.
*/}}
{{- define "bold-reports.designer.readinessProbe" -}}
readinessProbe: {{- .Values.designer.readinessProbe | toYaml | trim | nindent 2 -}}
{{- end -}}
{{/*
Returns the readinessProbe for Reports Web.
*/}}
{{- define "bold-reports.reportsWeb.readinessProbe" -}}
readinessProbe: {{- .Values.reportsWeb.readinessProbe | toYaml | trim | nindent 2 -}}
{{- end -}}
{{/*
Returns the readinessProbe for Reports Api.
*/}}
{{- define "bold-reports.reportsApi.readinessProbe" -}}
readinessProbe: {{- .Values.reportsApi.readinessProbe | toYaml | trim | nindent 2 -}}
{{- end -}}
{{/*
Returns the readinessProbe for Id Web.
*/}}
{{- define "bold-reports.idWeb.readinessProbe" -}}
readinessProbe: {{- .Values.idWeb.readinessProbe | toYaml | trim | nindent 2 -}}
{{- end -}}
{{/*
Returns the readinessProbe for Id Api.
*/}}
{{- define "bold-reports.idApi.readinessProbe" -}}
readinessProbe: {{- .Values.idApi.readinessProbe | toYaml | trim | nindent 2 -}}
{{- end -}}

{{/*
Returns the readinessProbe for UMS.
*/}}
{{- define "bold-reports.ums.readinessProbe" -}}
readinessProbe: {{- .Values.ums.readinessProbe | toYaml | trim | nindent 2 -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "bold-reports.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}
{{/*
Common labels
*/}}
{{- define "bold-reports.labels" -}}
helm.sh/chart: {{ include "bold-reports.chart" . }}
{{ include "bold-reports.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}
{{/*
Selector labels
*/}}
{{- define "bold-reports.selectorLabels" -}}
app.kubernetes.io/name: {{ include "bold-reports.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
{{/*
 Create the name of the service account to use
 */}}
{{- define "bold-reports.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
    {{ default (include "common.names.fullname" .) .Values.serviceAccount.name }}
{{- else -}}
    {{ default "default" .Values.serviceAccount.name }}
{{- end -}}
{{- end -}}
{{/*
    matchLabels for ID UMS
*/}}
{{- define "bold-reports.ums.matchLabels" -}}
{{ include "common.labels.matchLabels" . }}
app.kubernetes.io/component: ums
{{- end -}}
{{/*
    matchLabels for Jobs
*/}}
{{- define "bold-reports.jobs.matchLabels" -}}
{{ include "common.labels.matchLabels" . }}
app.kubernetes.io/component: report-jobs
{{- end -}}
{{/*
    matchLabels for reports-web
*/}}
{{- define "bold-reports.reportsWeb.matchLabels" -}}
{{ include "common.labels.matchLabels" . }}
app.kubernetes.io/component: reports-web
{{- end -}}
{{/*
    matchLabels for designer
*/}}
{{- define "bold-reports.designer.matchLabels" -}}
{{ include "common.labels.matchLabels" . }}
app.kubernetes.io/component: designer
{{- end -}}
{{/*
    matchLabels for reports api
*/}}
{{- define "bold-reports.reportsApi.matchLabels" -}}
{{ include "common.labels.matchLabels" . }}
app.kubernetes.io/component: reports-api
{{- end -}}
{{/*
    matchLabels for id-web
*/}}
{{- define "bold-reports.idWeb.matchLabels" -}}
{{ include "common.labels.matchLabels" . }}
app.kubernetes.io/component: id-web
{{- end -}}
{{/*
    matchLabels for id-api
*/}}
{{- define "bold-reports.idApi.matchLabels" -}}
{{ include "common.labels.matchLabels" . }}
app.kubernetes.io/component: id-api
{{- end -}}
{{/*
Return the Volume Name secrets name
*/}}
{{/*
Return the File Server Claim Name secrets name
*/}}
{{- define "bold-reports.fileServerName" -}}
{{- include "common.names.fullname" . -}}
{{- end }}
{{/*
Return the Log4Net Claim Name secrets name
*/}}
{{- define "bold-reports.log4netName" -}}
{{- include "common.names.fullname" . -}}-log4net
{{- end }}
{{/*
Return the name of the reports web resource name.
*/}}
{{- define "bold-reports.reportsWeb.name" -}}
{{- include "common.names.fullname" . -}}-reports-web
{{- end }}
{{/*
Return the name of the reports web api resource name.
*/}}
{{- define "bold-reports.reportsApi.name" -}}
{{- include "common.names.fullname" . -}}-reports-api
{{- end }}
{{/*
Return the name of the Jobs resource name.
*/}}
{{- define "bold-reports.jobs.name" -}}
{{- include "common.names.fullname" . -}}-jobs
{{- end }}
{{/*
{{/*
Return the name of the Designer resource name.
*/}}
{{- define "bold-reports.designer.name" -}}
{{- include "common.names.fullname" . -}}-designer
{{- end }}
{{/*
Return the name of the api resource name.
*/}}
{{- define "bold-reports.idApi.name" -}}
{{- include "common.names.fullname" . -}}-id-api
{{- end }}
{{/*
Return the name of the api resource name.
*/}}
{{- define "bold-reports.idWeb.name" -}}
{{- include "common.names.fullname" . -}}-id-web
{{- end }}
{{/*
Return the name of the api resource name.
*/}}
{{- define "bold-reports.idWeb.service" -}}
id-web-service
{{- end }}
{{/*
Returns Ums full name
*/}}
{{- define "bold-reports.ums.name" -}}
{{- include "common.names.fullname" . -}}-ums
{{- end }}
{{/*
Returns Id Api environment variables
*/}}
{{- define "bold-reports.ums.env" -}}
{{- include "common.env" (dict "env" .Values.ums.env "global" .Values.global "context" $) -}}
{{- end -}}
{{/*
Returns Id Api environment variables
*/}}
{{- define "bold-reports.idApi.env" -}}
{{- include "common.env" (dict "env" .Values.idApi.env "global" .Values.global "context" $) -}}
{{- end -}}
{{/*
Returns Designer environment variables
*/}}
{{- define "bold-reports.designer.env" -}}
{{- include "common.env" (dict "env" .Values.designer.env "global" .Values.global "context" $) -}}
{{- end -}}
{{/*
Returns Id Api environment variables
*/}}
{{- define "bold-reports.jobs.env" -}}
{{- include "common.env" (dict "env" .Values.jobs.env "global" .Values.global "context" $) -}}
{{- end -}}
{{/*
Returns Reports Web environment variables
*/}}
{{- define "bold-reports.reportsWeb.env" -}}
{{- include "common.env" (dict "env" .Values.reportsWeb.env "global" .Values.global "context" $) -}}
{{- end -}}
{{/*
Returns Reports Api environment variables
*/}}
{{- define "bold-reports.reportsApi.env" -}}
{{- include "common.env" (dict "env" .Values.reportsApi.env "global" .Values.global "context" $) -}}
{{- end -}}
{{/*
Returns global or application environment variables
*/}}
{{- define "bold-reports.idWeb.env" -}}
{{- include "common.env" (dict "env" .Values.idWeb.env "global" .Values.global "context" $) -}}
{{- end -}}

{{- define "bold-reports.postgres.serviceName" -}}
{{- if .Values.postgres.service.name -}}
{{- .Values.postgres.service.name -}}
{{- else -}}
{{- include "bold-reports.fullname" . -}}-postgres
{{- end -}}
{{- end -}}

{{/*
Allow the .Release.Namespace to be overridden for multi-namespace deployments in combined charts.
Values (in-order) can come from:
 .Values.global.namespaceOverride - overrides the namespace all parent/child Charts
 .Values.namespace - namespace for this Chart
 .Release.Namespace - the Release's Namespace specified during helm install
*/}}
{{- define "bold-reports.namespace" -}}
    {{- if .Values.global -}}
        {{- if .Values.global.namespaceOverride }}
            {{- .Values.global.namespaceOverride -}}
        {{- else if .Values.namespace -}}
            {{- .Values.namespace -}}
        {{- else -}}
            {{- .Release.Namespace -}}
        {{- end -}}
    {{- else if .Values.namespace -}}
        {{- .Values.namespace -}}
    {{- else -}}
        {{- .Release.Namespace -}}
    {{- end }}
{{- end -}}

{{- define "bold-reports.persistence.storageClass" -}}
{{- include "common.storage.class" . -}}
{{- end -}}
{{- define "elastic.envs"}}
- name: ELASTICSEARCH_ISOPENSEARCH
  value: "true"
- name: ELASTICSEARCH_ADDRESS
  value: "https://opensearch-cluster-master.{{ .Release.Namespace }}.svc.cluster.local:9200"
- name: ELASTICSEARCH_USERNAME
  value: "admin"
- name: ELASTICSEARCH_PASSWORD
  value: "myStrongPassword@123!"
- name: ELASTICSEARCH_INGESTION_ENDPOINT
  value: ""
- name: ELASTICSEARCH_ISONAKS
  value: "true"
{{- end }}
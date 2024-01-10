Nango Helm Charts
==================

# Overview
* In order to run Nango in a kubernetes cluster some components must be in place
for the application to run as expected
* Syncs and actions in nango have a dependency on [temporal](https://temporal.io/)
and expect `TEMPORAL_ADDRESS` and `TEMPORAL_NAMESPACE` env variables to be set
along with a `$TEMPORAL_NAMESPACE.key` and `$TEMPORAL_NAMESPACE.crt` files
to be set as secrets in kubernetes. Setting the files as secrets can be done by
populating the temporal-secrets.yaml with the base64 encoded values to the file 
within the jobs template

# Usage
* Install helm, [docs](https://helm.sh/docs)
* Add this repo
```
helm repo add nangohq https://nangohq.github.io/nango-helm-charts
```
* If you had already added this repo earlier, run `helm repo update nangohq` to retrieve
the latest versions of the packages.  You can then run `helm search repo
nangohq` to see the charts.
* Set your values.yaml file, you can use the configuration section below to formulate
the file
* To install the necessary nango charts
```
helm install nango nangohq/nango
```
* To uninstall the chart
```
helm delete nango
```

# Configuration

| Component                | Key                            | Value        |
|--------------------------|--------------------------------|--------------|
| postgresql               | enabled                        | true         |
|                          | fullnameOverride               | nango-postgresql |
|                          | primary.persistence.enabled     | false        |
|                          | primary.resources.limits.cpu    | "1000m"      |
|                          | primary.resources.limits.memory | "2048Mi"     |
|                          | primary.resources.requests.cpu  | "250m"       |
|                          | primary.resources.requests.memory | "1024Mi"    |
|                          | auth.postgresPassword           | nango        |
|                          | auth.database                   | nango        |
| temporal                 | enabled                        | true         |
|                          | global.serviceAccountName       | default      |
|                          | global.secretName               | nango-secret |
| server                   | name                           | server       |
|                          | replicas                       | 1            |
| jobs                     | name                           | jobs         |
|                          | replicas                       | 1            |
|                          | volume.name                    | flows-volume |
|                          | volume.claimName               | flow-claim   |
|                          | volume.aws                     | false        |
|                          | volume.gcp                     | false        |
| runner                   | name                           | runner       |
|                          | replicas                       | 1            |
| shared                   | namespace                      | default      |
|                          | ENV                            | production   |
|                          | DB_HOST                        | nango-postgresql |
|                          | DB_USER                        | postgres     |
|                          | DB_PORT                        | "5432"       |
|                          | DB_NAME                        | nango        |
|                          | DB_SSL                         | false        |
|                          | ENCRYPTION_KEY                 | ""           |
|                          | CALLBACK_URL                   | ""           |
|                          | flows_path                     | /flows       |
|                          | useVolumeForFlows              | true         |
| temporalio               | volumeName                     | temporal-secrets |
|                          | TEMPORAL_ADDRESS               | nango-sync.abc |
|                          | TEMPORAL_NAMESPACE             | nango-sync.def |
|                          | TEMPORAL_KEY                   | BASE_64_VALUE |
|                          | TEMPORAL_CRT                   | BASE_64_VALUE |

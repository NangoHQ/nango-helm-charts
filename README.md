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
* The values you need to obtain from a Nango developer are
```
TEMPORAL_ADDRESS
TEMPORAL_NAMESPACE
TEMPORAL_KEY
TEMPORAL_CERT
MAILGUN_API_KEY
```

## Volume
* In order to run syncs and actions a volume is used across services to allow 
the different components to coordinate the execution of a sync. Therefore within
the jobs template there is a `jobs-pvc.yaml` and a `jobs-${aws|gcp}-storage-class.yaml`
that attempts to create a volume that is used across the `jobs` and `server`
components
* That volume should attach to each pod, but if you see issues with this please
reach out!

## Exposing the Server
* In order to do the OAuth handshake the server component needs to publicly 
accessible to catch the OAuth callback. Therefore by default if using AWS
the server service automatically uses a LoadBalancer to expose it publicly.
You can set `useLoadBalancer` to false if you want to expose the server in a
different way.
* If you're using [Porter](https://www.porter.run/) there is an issue that the 
load balancer that is created is internal only and the server isn't exposed 
correctly. Please reach out and we can work with Porter and you to diagnose this
known issue.

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

| Component                | Key                            | Default Value|
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
| temporal                 | enabled                        | false         |
|                          | global.serviceAccountName       | default      |
|                          | global.secretName               | nango-secret |
| server                   | name                           | server       |
|                          | useLoadBalancer                | true         |
|                          | MAILGUN_API_KEY                | ""           |
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
|                          | APP_URL                        | https://your-hosted-instance.com |
|                          | CALLBACK_URL                   | https://your-hosted-instance.com/oauth/callback |
|                          | flows_path                     | /flows       |
|                          | useVolumeForFlows              | true         |
| temporalio               | volumeName                     | temporal-secrets |
|                          | TEMPORAL_ADDRESS               | nango-sync.abc |
|                          | TEMPORAL_NAMESPACE             | nango-sync.def |
|                          | TEMPORAL_KEY                   | BASE_64_VALUE |
|                          | TEMPORAL_CRT                   | BASE_64_VALUE |

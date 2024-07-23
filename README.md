# Overview

Nango requires specific components and configurations to operate correctly within a Kubernetes cluster. Key dependencies include:

- **[Elasticsearch](https://www.elastic.co/)**: Nango relies on Elasticsearch for logging.
Nango can operate without running Elasticsearch and the environment variable `NANGO_LOGS_ENABLED`
determines if logs are ingested and displayed in the Nango UI. If you are running Ela
need to set:
```
NANGO_LOGS_ENABLED
NANGO_LOGS_ES_PWD
NANGO_LOGS_ES_URL
NANGO_LOGS_ES_USER
```
- **Required Values**: Obtain the following values from a Nango developer:

```
MAILGUN_API_KEY
```

# Setting Up Secrets

Nango expects the following secrets:

## `nango-secrets`

This secret should contain:

- `postgres-password`: Required if `postgresql.enabled` is set to `false` (i.e., using an external database).
- `encryption-key`: Required if `shared.encryptionEnabled` is set to `true`.
- `mailgun-api-key`.

Example command to create `nango-secrets`:

```bash
kubectl create secret generic nango-secrets \
  --from-literal=postgres-password=secure-pw \
  --from-literal=encryption-key=base64-encoded-256-bit-key \
  --from-literal=mailgun-api-key=key-from-nango-dev
  ```

Then to create the secrets:

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: nango-secrets
type: Opaque
data:
  postgres-password: [base64-encoded-password]
  encryption-key: [base64-encoded-encryption-key-which-means-you-need-to-base64-encode-the-base64-256-bit-key]
  mailgun-api-key: [base64-encoded-api-key]
```

# Persistent Volume Configuration

To facilitate syncs and actions, Nango utilizes a persistent volume across services.
The jobs-pvc.yaml and jobs-${aws|gcp}-storage-class.yaml in the jobs template
are responsible for creating this volume, used by the jobs and server components.
Reach out for assistance if you encounter issues with the volume attachment.

# Exposing the Server

The server component, crucial for OAuth handshake, needs to be publicly accessible.
By default, on AWS, a LoadBalancer exposes the server. Set useLoadBalancer
to false to use an alternate exposure method.

Note for Porter Users: There's a known issue where the server might not be
correctly exposed due to an internal-only load balancer. Please contact us for support.

# Usage

1. Install helm: Follow the [official Helm documentation](https://helm.sh/docs)

2. Add the Nango Repository

```bash
helm repo add nangohq https://nangohq.github.io/nango-helm-charts
```

3. Update the Repository (if previously added):

```bash
helm repo update nangohq
helm search repo nangohq
```

4. Configure values.yaml: Refer to the configuration section below.
5. Install Nango charts

```bash
helm install nango nangohq/nango
```

- To uninstall the chart

```sh
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
| elasticsearch            | enabled                        | false         |
|                          | fullnameOverride               | nango-elasticsearch |
|                          | clusterName                    | elastic      |
|                          | security.enabled               | true         |
|                          | security.elasticPassword       | nango        |
| server                   | name                           | server       |
|                          | tag                            | enterprise   |
|                          | useLoadBalancer                | true         |
|                          | replicas                       | 1            |
| jobs                     | name                           | jobs         |
|                          | tag                            | enterprise   |
|                          | replicas                       | 1            |
|                          | volume.name                    | flows-volume |
|                          | volume.claimName               | flow-claim   |
|                          | volume.aws                     | false        |
|                          | volume.gcp                     | false        |
| runner                   | name                           | runner       |
|                          | tag                            | enterprise   |
|                          | replicas                       | 1            |
| persist                  | name                           | persist      |
|                          | tag                            |    |
|                          | replicas                       | 1            |
|                          | url                            | `http://nango-persist` |
| shared                   | namespace                      | default      |
|                          | ENV                            | production   |
|                          | DB_HOST                        | nango-postgresql |
|                          | DB_USER                        | postgres     |
|                          | DB_PORT                        | "5432"       |
|                          | DB_NAME                        | nango        |
|                          | DB_SSL                         | false        |
|                          | APP_URL                        | `https://your-hosted-instance.com` |
|                          | CALLBACK_URL                   | `https://your-hosted-instance.com/oauth/callback` |
|                          | flows_path                     | /flows       |
|                          | useVolumeForFlows              | true         |

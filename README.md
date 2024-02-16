# Overview

Nango requires specific components and configurations to operate correctly within a Kubernetes cluster. Key dependencies include:

- **[Temporal](https://temporal.io/)**: Nango relies on Temporal for syncs and actions. 
The environment variables `TEMPORAL_ADDRESS` and `TEMPORAL_NAMESPACE` must be set which
you can receive from a Nango developer. Additionally, `TEMPORAL_NAMESPACE.key` 
and `TEMPORAL_NAMESPACE.crt` files need to be configured as Kubernetes secrets.
- **Required Values**: Obtain the following values from a Nango developer:
```
TEMPORAL_ADDRESS
TEMPORAL_NAMESPACE
TEMPORAL_KEY
TEMPORAL_CERT
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

## `nango-temporal-secrets`

Contains two files received from a Nango developer: `TEMPORAL_KEY` and `TEMPORAL_CERT`.
The secret's name depends on `TEMPORAL_NAMESPACE`. Then create the secret:
```bash
kubectl create secret generic nango-temporal-secrets \
    --from-file=name-of-your-temporal-namespace.key \
    --from-file=name-of-your-temporal-namespace.crt
```

Alternatively use a YAML file for all secret creation (ensure all values are
base64 encoded). To encode the temporal key and cert:
```bash
TEMPORAL_KEY_BASE64=$(cat path/to/temporal.key | base64 | tr -d '\n')
TEMPORAL_CRT_BASE64=$(cat path/to/temporal.crt | base64 | tr -d '\n')
```
Then to create the secrets:
```yaml
apiVersion: v1
kind: Secret
metadata:
  name: nango-temporal-secrets
type: Opaque
data:
  name-of-your-temporal-namespace.key: [base64-encoded-key]
  name-of-your-temporal-namespace.crt: [base64-encoded-crt]

---

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
|                          | tag                            | enterprise   |
|                          | replicas                       | 1            |
|                          | url                            | http://nango-persist |
| shared                   | namespace                      | default      |
|                          | ENV                            | production   |
|                          | DB_HOST                        | nango-postgresql |
|                          | DB_USER                        | postgres     |
|                          | DB_PORT                        | "5432"       |
|                          | DB_NAME                        | nango        |
|                          | DB_SSL                         | false        |
|                          | APP_URL                        | https://your-hosted-instance.com |
|                          | CALLBACK_URL                   | https://your-hosted-instance.com/oauth/callback |
|                          | flows_path                     | /flows       |
|                          | useVolumeForFlows              | true         |
| temporalio               | volumeName                     | temporal-secrets |
|                          | TEMPORAL_ADDRESS               | nango-sync.abc |
|                          | TEMPORAL_NAMESPACE             | nango-sync.def |

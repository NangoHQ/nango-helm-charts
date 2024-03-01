# Environment Variables
* Mandatory
```
NANGO_DB_HOST (server, jobs, persist)
NANGO_DB_NAME (server, jobs, persist)
NANGO_DB_USER (server, jobs, persist)
NANGO_DB_PASSWORD (server, jobs, persist)
NANGO_DB_PORT (server, jobs, persist)
NANGO_DB_SSL (server, jobs, persist)
NANGO_SERVER_URL (server, jobs, persist)
NANGO_CALLBACK_URL (server, jobs, persist)
TEMPORAL_ADDRESS (server, jobs, persist)
TEMPORAL_NAMESPACE (server, jobs, persist)
NODE_ENV (server, jobs, persist)
NANGO_ENTERPRISE # set to true (server, jobs, persist, runner)
MAILGUN_API_KEY # provided by Nango (server, jobs, persist)
PERSIST_SERVICE_URL (runner, jobs)
JOBS_SERVICE_URL (jobs)
RUNNER_SERVICE_URL (jobs)
NANGO_ENTERPRISE (server, jobs, persist, runner)
```

# Optional
```
NANGO_DATABASE_URL
SERVER_PORT
AWS_ACCESS_KEY_ID
AWS_BUCKET_NAME
AWS_REGION
AWS_SECRET_ACCESS_KEY
DD_API_KEY
DD_APP_KEY
DD_ENV
DD_PROFILING_ENABLED
DD_SITE
DD_TRACE_AGENT_URL
```

## Recommended
```
NANGO_ENCRYPTION_KEY
```

# Required Files
* Two files required by Temporal are expected to be mounted at `/etc/secrets/${TEMPORAL_NAMESPACE}`:
```
/etc/secrets/${TEMPORAL_NAMESPACE}.crt
/etc/secrets/${TEMPORAL_NAMESPACE}.key
```

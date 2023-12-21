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

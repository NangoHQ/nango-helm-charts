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
* If you had already added this repo earlier, run `helm repo update` to retrieve
the latest versions of the packages.  You can then run `helm search repo
nango` to see the charts.
* To install the the nango chart
```
helm install my-nango nangohq/nango
```
* To uninstall the chart
```
helm delete my-nango
```

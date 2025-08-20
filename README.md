# Nango Helm Charts

This repository contains Helm charts for deploying [Nango](https://nango.dev) on Kubernetes.

## What is Nango?

Nango is a single API for all your integrations. It provides OAuth handling, webhook management, and unified API access to hundreds of third-party services.

## Available Charts

| Chart | Description | Version |
|-------|-------------|---------|
| [nango](./charts/nango) | Complete Nango deployment with all components | ![Version](https://img.shields.io/badge/version-2.0.0-blue.svg?style=flat-square) |

## Quick Start

### Prerequisites

- Kubernetes 1.19+
- Helm 3.0+
- PV provisioner support in the underlying infrastructure

### Add the Helm Repository

```bash
helm repo add nangohq https://nangohq.github.io/nango-helm-charts
helm repo update
```

### Install Nango

```bash
helm install nango nangohq/nango
```

### Uninstall Nango

```bash
helm uninstall nango
```

## Documentation

- [Nango Chart Documentation](./charts/nango/README.md) - Detailed configuration and usage
- [Nango Official Documentation](https://docs.nango.dev) - Application documentation
- [Helm Documentation](https://helm.sh/docs) - Helm usage guide

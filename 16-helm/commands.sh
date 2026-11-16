# Install Helm
curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
helm version

# Create a new chart scaffold
helm create mychart

# Install a chart
helm install my-release ./mychart -n dev --create-namespace

# Install with custom values
helm install my-release ./mychart -n dev -f values-prod.yaml

# Upgrade
helm upgrade my-release ./mychart -n dev

# Upgrade or install (idempotent, great for CI/CD)
helm upgrade --install my-release ./mychart -n dev

# Rollback
helm rollback my-release 1 -n dev

# List releases / history / uninstall
helm list -n dev
helm history my-release -n dev
helm uninstall my-release -n dev

# Add a public repo (example: bitnami)
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
helm search repo bitnami/nginx
helm install nginx bitnami/nginx -n dev

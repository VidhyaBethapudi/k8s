# Install kube-prometheus-stack via Helm (Prometheus + Grafana + Alertmanager + exporters)
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo add grafana https://grafana.github.io/helm-charts
helm repo update

helm install kube-prometheus-stack prometheus-community/kube-prometheus-stack \
  -n monitoring --create-namespace \
  -f values-prometheus.yaml

kubectl get pods -n monitoring
kubectl get svc -n monitoring

# Access Grafana locally
kubectl port-forward svc/kube-prometheus-stack-grafana -n monitoring 3000:80
# default user: admin, get password:
kubectl get secret kube-prometheus-stack-grafana -n monitoring -o jsonpath="{.data.admin-password}" | base64 -d

# Access Prometheus locally
kubectl port-forward svc/kube-prometheus-stack-prometheus -n monitoring 9090:9090

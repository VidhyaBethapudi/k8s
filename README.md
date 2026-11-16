# EKS / Kubernetes Reference Kit

Practical YAML manifests + CLI command references for every topic requested.
Each numbered folder is self-contained: manifest file(s) + a `commands.sh` showing
how to apply/use them.

| Folder | Topic | Notes |
|---|---|---|
| 01-eks-install | EKS Installation (CLI) | eksctl + awscli setup, `eks-cluster-config.yaml` |
| 02-namespace | Namespace | `namespace.yaml` |
| 03-pod | Pod | single-container + multi-container (sidecar) |
| 04-deployment | Deployment | rolling update strategy, probes |
| 05-replicaset | ReplicaSet | rarely used directly, shown for completeness |
| 06-service | Service | ClusterIP, NodePort, LoadBalancer, Headless |
| 07-configmap | ConfigMap | env injection + volume mount |
| 08-secret | Secret | base64 `data`, `stringData`, pod usage |
| 09-volumes | Volumes | emptyDir, hostPath, EBS (static) |
| 10-pv-pvc | PV & PVC | StorageClass (dynamic EBS provisioning) |
| 11-ingress | Ingress | ALB (AWS LB Controller) + ingress-nginx |
| 12-hpa | HPA | CPU/memory autoscaling, needs metrics-server |
| 13-daemonset | DaemonSet | per-node agent example (fluentd) |
| 14-statefulset | StatefulSet | MySQL example w/ volumeClaimTemplates |
| 15-jobs-cronjobs | Jobs & CronJobs | one-off + scheduled batch jobs |
| 16-helm | Helm | full sample chart (Chart.yaml/values/templates) + commands |
| 17-prometheus-grafana | Prometheus & Grafana | kube-prometheus-stack Helm values, ServiceMonitor |
| 18-argocd | Argo CD | Application, Application (Helm source), AppProject |
| 19-cicd | Jenkins/GitHub Actions | Jenkinsfile + GitHub Actions workflow to build/push/deploy |
| 20-eks-troubleshooting | EKS Troubleshooting | cheat sheet of debugging commands by layer |

## Quick start order (typical learning path)
1. `01-eks-install` — stand up a cluster
2. `02` → `08` — core building blocks (namespace, pod, deployment, service, config/secrets)
3. `09` → `10` — storage
4. `11` → `12` — networking + scaling
5. `13` → `15` — specialized workloads
6. `16` — package everything as a Helm chart
7. `17` — add observability
8. `18` → `19` — GitOps + CI/CD automation
9. `20` — keep as a reference when things break

## Prerequisites assumed
- AWS account with an EKS cluster (see `01-eks-install`)
- `kubectl`, `eksctl`, `aws` CLI, and `helm` installed and configured
- Replace placeholder values (account IDs, ARNs, domains, image names) with your own
# k8s-yaml-files

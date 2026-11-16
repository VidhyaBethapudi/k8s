# Install metrics-server (required for HPA to read CPU/memory metrics)
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml

kubectl apply -f hpa.yaml
kubectl get hpa -n dev
kubectl describe hpa nginx-hpa -n dev

# Quick imperative alternative
kubectl autoscale deployment nginx-deployment --cpu-percent=70 --min=2 --max=10 -n dev

# Load test to trigger scaling
kubectl run load-generator --image=busybox -n dev -it --rm -- /bin/sh -c "while true; do wget -q -O- http://nginx-clusterip; done"

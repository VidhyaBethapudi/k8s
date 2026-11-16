kubectl apply -f namespace.yaml
kubectl get namespaces
kubectl describe namespace dev
kubectl delete namespace dev

# Set default namespace for current context
kubectl config set-context --current --namespace=dev

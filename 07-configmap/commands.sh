kubectl apply -f configmap.yaml
kubectl get configmap -n dev
kubectl describe configmap app-config -n dev
# Create from literal / file
kubectl create configmap app-config --from-literal=LOG_LEVEL=debug -n dev
kubectl create configmap app-config --from-file=app.properties -n dev

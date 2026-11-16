kubectl apply -f service-clusterip.yaml
kubectl get svc -n dev
kubectl describe svc nginx-clusterip -n dev
kubectl get endpoints nginx-clusterip -n dev

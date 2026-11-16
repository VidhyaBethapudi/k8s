kubectl apply -f replicaset.yaml
kubectl get rs -n dev
kubectl describe rs nginx-replicaset -n dev
kubectl delete rs nginx-replicaset -n dev

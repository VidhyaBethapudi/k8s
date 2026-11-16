kubectl apply -f storageclass.yaml
kubectl apply -f pvc.yaml
kubectl get pv
kubectl get pvc -n dev
kubectl describe pvc app-data-pvc -n dev

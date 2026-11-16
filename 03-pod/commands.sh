kubectl apply -f pod.yaml
kubectl get pods -n dev
kubectl describe pod nginx-pod -n dev
kubectl logs nginx-pod -n dev
kubectl exec -it nginx-pod -n dev -- /bin/bash
kubectl delete pod nginx-pod -n dev

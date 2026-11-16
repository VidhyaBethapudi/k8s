kubectl apply -f deployment.yaml
kubectl get deployments -n dev
kubectl rollout status deployment/nginx-deployment -n dev
kubectl set image deployment/nginx-deployment nginx=nginx:1.28 -n dev
kubectl rollout history deployment/nginx-deployment -n dev
kubectl rollout undo deployment/nginx-deployment -n dev
kubectl scale deployment/nginx-deployment --replicas=5 -n dev

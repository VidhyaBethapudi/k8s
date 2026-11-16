kubectl apply -f headless-service.yaml
kubectl apply -f statefulset.yaml
kubectl get statefulset -n dev
kubectl get pods -n dev -l app=mysql
# Pods are named mysql-0, mysql-1, mysql-2 with stable DNS: mysql-0.mysql-headless.dev.svc.cluster.local
kubectl scale statefulset mysql --replicas=5 -n dev

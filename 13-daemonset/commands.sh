kubectl apply -f daemonset.yaml
kubectl get daemonset -n kube-system
kubectl describe ds fluentd-agent -n kube-system
kubectl get pods -n kube-system -l app=fluentd -o wide

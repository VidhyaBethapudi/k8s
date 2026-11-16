kubectl apply -f emptydir-volume.yaml
kubectl exec -it emptydir-pod -n dev -- cat /data/msg.txt
kubectl describe pod emptydir-pod -n dev

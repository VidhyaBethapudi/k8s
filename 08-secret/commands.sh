kubectl apply -f secret.yaml
kubectl get secrets -n dev
kubectl describe secret app-secret -n dev
kubectl get secret app-secret -n dev -o jsonpath='{.data.DB_PASSWORD}' | base64 -d
kubectl create secret generic app-secret --from-literal=DB_USERNAME=admin --from-literal=DB_PASSWORD=pass123 -n dev
kubectl create secret docker-registry regcred --docker-server=<repo> --docker-username=<user> --docker-password=<pass> -n dev

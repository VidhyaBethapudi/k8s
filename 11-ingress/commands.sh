# Install AWS Load Balancer Controller (prereq for ALB ingress)
eksctl utils associate-iam-oidc-provider --cluster my-eks-cluster --approve
helm repo add eks https://aws.github.io/eks-charts
helm repo update
helm install aws-load-balancer-controller eks/aws-load-balancer-controller \
  -n kube-system \
  --set clusterName=my-eks-cluster \
  --set serviceAccount.create=true

kubectl apply -f ingress-alb.yaml
kubectl get ingress -n dev
kubectl describe ingress nginx-ingress -n dev

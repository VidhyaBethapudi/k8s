#!/bin/bash
# =========================================================
# EKS / Kubernetes Troubleshooting Cheat Sheet
# =========================================================

# ---------- CLUSTER / NODE LEVEL ----------
kubectl get nodes -o wide
kubectl describe node <node-name>              # check conditions, allocatable resources, taints
kubectl top nodes                                # requires metrics-server
eksctl get nodegroup --cluster my-eks-cluster
aws eks describe-cluster --name my-eks-cluster --query 'cluster.status'
aws eks describe-nodegroup --cluster-name my-eks-cluster --nodegroup-name standard-workers

# Node not joining cluster? Check:
#  - IAM role has AmazonEKSWorkerNodePolicy, AmazonEKS_CNI_Policy, AmazonEC2ContainerRegistryReadOnly
#  - aws-auth ConfigMap maps the node IAM role correctly
kubectl get configmap aws-auth -n kube-system -o yaml

# ---------- POD LEVEL ----------
kubectl get pods -n dev -o wide
kubectl describe pod <pod-name> -n dev           # events section shows scheduling/pull/probe failures
kubectl logs <pod-name> -n dev
kubectl logs <pod-name> -n dev --previous          # logs from crashed container
kubectl logs <pod-name> -c <container-name> -n dev # multi-container pod
kubectl exec -it <pod-name> -n dev -- /bin/sh

# Common Pod states & causes:
# CrashLoopBackOff -> app crashing on start; check logs/config/env vars
# ImagePullBackOff  -> wrong image name/tag, private registry auth missing (imagePullSecrets)
# Pending           -> insufficient CPU/mem, no matching node, PVC not bound
# ContainerCreating (stuck) -> volume mount issue, CNI/ENI IP exhaustion
# OOMKilled         -> container exceeded memory limit, check `kubectl describe pod` last state

kubectl get events -n dev --sort-by='.lastTimestamp'

# ---------- DEPLOYMENT / ROLLOUT ----------
kubectl rollout status deployment/<name> -n dev
kubectl rollout history deployment/<name> -n dev
kubectl describe deployment <name> -n dev

# ---------- SERVICE / NETWORKING ----------
kubectl get endpoints <service-name> -n dev       # empty = selector doesn't match any pod labels
kubectl describe svc <service-name> -n dev
kubectl run debug --rm -it --image=busybox -n dev -- sh
#   inside: wget -qO- http://<service-name>.dev.svc.cluster.local
kubectl get networkpolicy -n dev

# DNS issues
kubectl exec -it <pod> -n dev -- nslookup kubernetes.default
kubectl logs -n kube-system -l k8s-app=kube-dns

# ---------- INGRESS / LOAD BALANCER ----------
kubectl describe ingress <name> -n dev
kubectl logs -n kube-system -l app.kubernetes.io/name=aws-load-balancer-controller
aws elbv2 describe-load-balancers
aws elbv2 describe-target-health --target-group-arn <arn>

# ---------- STORAGE ----------
kubectl get pv,pvc -n dev
kubectl describe pvc <name> -n dev                # check "Events" for provisioning errors
kubectl get pods -n kube-system -l app=ebs-csi-controller

# ---------- IAM / IRSA ----------
kubectl describe sa <service-account> -n dev       # check eks.amazonaws.com/role-arn annotation
kubectl exec -it <pod> -n dev -- env | grep AWS

# ---------- RESOURCE / QUOTA ----------
kubectl describe resourcequota -n dev
kubectl top pods -n dev
kubectl get limitrange -n dev

# ---------- CONTROL PLANE LOGS (CloudWatch) ----------
aws eks update-cluster-config --name my-eks-cluster \
  --logging '{"clusterLogging":[{"types":["api","audit","authenticator","controllerManager","scheduler"],"enabled":true}]}'
# Then view in CloudWatch Logs group: /aws/eks/my-eks-cluster/cluster

# ---------- GENERAL DEBUGGING WORKFLOW ----------
# 1. kubectl get <resource> -n <ns>              -> is it there? what status?
# 2. kubectl describe <resource> <name> -n <ns>  -> check Events at the bottom
# 3. kubectl logs <pod> -n <ns>                  -> app-level errors
# 4. kubectl get events -n <ns> --sort-by=.lastTimestamp -> cluster-level events
# 5. Check IAM / SG / VPC networking if it's an AWS-specific failure

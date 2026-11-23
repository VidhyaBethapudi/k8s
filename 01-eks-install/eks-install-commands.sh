#!/bin/bash
# =========================================================
# EKS Installation via CLI (eksctl + awscli + kubectl)
# =========================================================

# 1. Install prerequisites (run on your local machine / bastion)
#    - awscli v2
#    - kubectl
#    - eksctl

# --- Install AWS CLI v2 (Linux) ---
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
aws --version

# --- Configure AWS credentials ---
aws configure
# AWS Access Key ID, Secret Access Key, Region, Output format

# --- Install kubectl ---
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
sudo mv kubectl /usr/local/bin/
kubectl version --client

# --- Install eksctl ---
curl --silent --location "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin
eksctl version

# =========================================================
# 2. Create an EKS Cluster (simple, managed node group)
# =========================================================
eksctl create cluster \
  --name my-eks-cluster \
  --region ap-south-1 \
  --version 1.30 \
  --nodegroup-name standard-workers \
  --node-type t3.medium \
  --nodes 2 \
  --nodes-min 1 \
  --nodes-max 4 \
  --managed

# This single command provisions:
# - VPC, subnets, route tables, NAT gateway
# - IAM roles
# - EKS control plane
# - Managed node group (EC2 worker nodes)
# Takes ~15-20 minutes.

# =========================================================
# 3. Create Cluster via config file (recommended for real use)
# =========================================================
# See eks-cluster-config.yaml in this folder, then run:
eksctl create cluster -f eks-cluster-config.yaml

# =========================================================
# 4. Update kubeconfig to talk to the new cluster
# =========================================================
aws eks update-kubeconfig --region ap-south-1 --name my-eks-cluster

# Verify
kubectl get nodes
kubectl get svc

# =========================================================
# 5. Useful cluster lifecycle commands
# =========================================================
eksctl get cluster --region ap-south-1
eksctl utils describe-stacks --region ap-south-1 --cluster my-eks-cluster
eksctl scale nodegroup --cluster my-eks-cluster --name standard-workers --nodes 3
eksctl delete cluster --name my-eks-cluster --region ap-south-1

1. aws eks list-clusters --region ap-south-1
aws eks list-nodegroups \
  --cluster-name my-eks-cluster \
  --region ap-south-1
  
2.aws eks delete-nodegroup \
  --cluster-name my-eks-cluster \
  --nodegroup-name my-nodegroup \
  --region ap-south-1
  
3.aws eks describe-nodegroup \
  --cluster-name my-eks-cluster \
  --nodegroup-name my-nodegroup \
  --region ap-south-1
  
4.aws eks delete-cluster \
  --name my-eks-cluster \
  --region ap-south-1
  
5.aws eks describe-cluster \
  --name my-eks-cluster \
  --region ap-south-1
  
6.aws eks list-clusters --region ap-south-1

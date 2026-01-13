#!/usr/bin/env bash
set -euo pipefail

minikube status >/dev/null 2>&1 || minikube start

# Enables ingress controller
minikube addons enable ingress

# Creates namespace (idempotent)
kubectl get ns k8s-3tier >/dev/null 2>&1 || kubectl create ns k8s-3tier

echo "Minikube ready."
kubectl get nodes
kubectl get pods -n ingress-nginx || true

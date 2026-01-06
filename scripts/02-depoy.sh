#!/usr/bin/env bash
set -euo pipefail

kubectl get ns k8s-3tier >/dev/null 2>&1 || kubectl create ns k8s-3tier

# Builds images inside Minikube's Docker daemon
eval "$(minikube docker-env)"

docker build -t k8s-3tier-frontend:1.0 ./frontend/app
docker build -t k8s-3tier-backend:1.0 ./backend/app

# Applies in dependency order
kubectl apply -f database/secret.yaml
kubectl apply -f database/pvc.yaml
kubectl apply -f database/service.yaml
kubectl apply -f database/statefulset.yaml

kubectl apply -f backend/configmap.yaml
kubectl apply -f backend/deployment.yaml
kubectl apply -f backend/service.yaml

kubectl apply -f frontend/deployment.yaml
kubectl apply -f frontend/service.yaml

kubectl apply -f ingress/ingress.yaml

# Waits for readiness
kubectl rollout status -n k8s-3tier statefulset/postgres
kubectl rollout status -n k8s-3tier deployment/backend
kubectl rollout status -n k8s-3tier deployment/frontend

echo
echo "Deployed. Try:"
echo "  http://$(minikube ip)/"
echo "  http://$(minikube ip)/api/health"

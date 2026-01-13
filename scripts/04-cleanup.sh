#!/usr/bin/env bash
set -euo pipefail

kubectl delete ns k8s-3tier --wait=true || true
echo "Cleaned up namespace k8s-3tier."

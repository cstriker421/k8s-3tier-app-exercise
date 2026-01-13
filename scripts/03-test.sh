#!/usr/bin/env bash
set -euo pipefail

IP="$(minikube ip)"

echo "Testing Ingress at http://$IP ..."
echo

echo "1) Frontend HTML:"
curl -fsS "http://$IP/" | head -n 5
echo

echo "2) Backend health:"
curl -fsS "http://$IP/api/health"
echo
echo

echo "3) Backend message (increments DB counter):"
curl -fsS "http://$IP/api/message"
echo
echo

echo "OK"

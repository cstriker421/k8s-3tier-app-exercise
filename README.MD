run docker build . -t tapp (app can be whatever name)

run minikube addons list
run minikube addons enable registry
run minikube cache add app:latest
run minikube cache list

REMEMBER TO AUTOMATE minikube start ET AL. WE'RE ARCHITECTS, NOT DEVS.

# K8s 3-Tier App Exercise

A simple 3-tier Kubernetes application deployed on a local Minikube cluster:

- **Frontend:** Nginx serving a static HTML/JS page
- **Backend:** Node.js/Express API
- **Database:** PostgreSQL (StatefulSet + PVC)

The frontend calls the backend at `/api/...`, and the backend reads/writes a counter in PostgreSQL.

## Architecture
Browser
|
| Ingress (nginx)
v
+-------------------+
| / -> frontend svc |
| /api -> backend |
+-------------------+
|
v
+-------------+
| backend pod |
+-------------+
|
v
+------------------+
| postgres stateful|
| + PVC storage |
+------------------+

## Prerequisites

- Docker
- Minikube
- kubectl

## How to run

### 1) Start cluster + enable ingress

``bash
./scripts/01-install.sh``

### 2) Build images + deploy manifests

``bash
./scripts/02-deploy.sh``

Open:
 - ``http://$(minikube ip)/``
 
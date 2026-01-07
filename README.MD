run docker build . -t tapp (app can be whatever name)

run minikube addons list
run minikube addons enable registry
run minikube cache add app:latest
run minikube cache list

REMEMBER TO AUTOMATE minikube start ET AL. WE'RE ARCHITECTS, NOT DEVS.

# Kubernetes 3-Tier Application Exercise

This repository contains a simple **3-tier application** deployed on a **local Kubernetes cluster using Minikube**.

The application demonstrates the core Kubernetes concepts covered in the module:
- Deployments and scaling
- Services
- ConfigMaps and Secrets
- Persistent storage (PVC)
- StatefulSets
- Ingress
- Automation scripts

---

## Application Description

The application consists of three layers:

1. Frontend  
   - Nginx serving a static HTML page  
   - Makes HTTP requests to the backend  

2. Backend  
   - Node.js + Express REST API  
   - Reads configuration from a ConfigMap  
   - Reads secrets from a Kubernetes Secret  
   - Connects to the database and updates a counter  

3. Database  
   - PostgreSQL  
   - Deployed as a StatefulSet  
   - Uses a PersistentVolumeClaim for data storage  

The frontend calls the backend via `/api/*`, and the backend stores request counts in PostgreSQL.

---

## Architecture Diagram

User Browser  
     |  
     v  
Ingress (nginx)  
     |  
     +--> Frontend Service --> Frontend Pods  
     |  
     +--> Backend Service --> Backend Pods --> PostgreSQL StatefulSet --> PVC  

---

## Prerequisites

- Docker
- Minikube
- kubectl
- Bash-compatible shell

---

## Repository Structure

k8s-3tier-app-exercise/
├── README.md
├── frontend/
│   ├── app/
│   │   ├── index.html
│   │   └── Dockerfile
│   ├── deployment.yaml
│   └── service.yaml
├── backend/
│   ├── app/
│   │   ├── app.js
│   │   ├── package.json
│   │   └── Dockerfile
│   ├── deployment.yaml
│   ├── service.yaml
│   └── configmap.yaml
├── database/
│   ├── pvc.yaml
│   ├── secret.yaml
│   ├── statefulset.yaml
│   └── service.yaml
├── ingress/
│   └── ingress.yaml
└── scripts/
    ├── 01-install.sh
    ├── 02-deploy.sh
    ├── 03-test.sh
    └── 04-cleanup.sh

---

## How to Install and Run

### 1. Start Minikube and enable Ingress

./scripts/01-install.sh

This script:
- Starts Minikube if not already running
- Enables the nginx ingress controller
- Creates the Kubernetes namespace

---

### 2. Build images and deploy the application

./scripts/02-deploy.sh

After deployment, access the application at:

http://$(minikube ip)/

---

### 3. Test the deployment

./scripts/03-test.sh

This script performs:
- Frontend HTML check
- Backend health endpoint check
- Backend API call that increments a database counter

---

### 4. Cleanup (optional)

./scripts/04-cleanup.sh

Deletes the application namespace and all associated resources.

---

## Kubernetes Objects Used

- Deployments (frontend, backend)
- StatefulSet (PostgreSQL)
- Services (ClusterIP)
- ConfigMap
- Secret
- PersistentVolumeClaim
- Ingress

---

## Notes

- The application is deployed entirely on a local Minikube cluster.
- Images are built directly into Minikube’s Docker daemon.
- This project is intended for educational purposes.
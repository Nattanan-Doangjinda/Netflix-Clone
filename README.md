# Project: Netflix Clone — CS365 DevSecOps Kubernetes

## Repository Structure
- Netflix-Clone/
- Application-Code/  ← Source code ของ Netflix Clone (TypeScript/React)
- Jenkins/           ← Jenkinsfile และ pipeline config
- Kubernetes/        ← deployment.yml และ service.yml
- Terraform/         ← Infrastructure as Code (AWS provisioning)
- assets/            ← รูปภาพและ assets อื่นๆ

## Infrastructure Overview
โปรเจกต์ใช้ 4 servers บน AWS EC2:

| Server | Instance Type | Role |  
|---|---|---|
| Jenkins Server | t2.small | CI/CD, SonarQube (Docker), Trivy, kubectl |
| Monitoring Server | t2.small | Prometheus :9090, Grafana :3000, Node Exporter :9100 |
| K8s-Master | t2.small | Kubernetes Master, Calico CNI, Node Exporter :9100 |
| K8s-Worker | t2.small | Kubernetes Worker, รัน Netflix Clone Pod :32000 |

## Tech Stack
- CI/CD: Jenkins
- Code Quality: SonarQube
- Security Scan: Trivy, OWASP Dependency-Check
- Container: Docker
- Orchestration: Kubernetes (kubeadm)
- Monitoring: Prometheus + Grafana
- Notifications: Email via Gmail SMTP
- API: TMDB API


## Kubernetes Setup Summary
- Version: v1.30
- CNI: Calico v3.25.0
- Runtime: Containerd
- Node Exporter: Port 9100 on all nodes
- Jenkins Secret: Kubeconfig stored as ID 'k8s'

## CI/CD Pipeline Stages
1. Workspace Cleaning
2. Checkout from Git
3. SonarQube Analysis
4. Quality Gate
5. Install Dependencies (npm install)
6. OWASP Dependency Check
7. Trivy Filesystem Scan
8. Docker Build & Tag (with API Key build-arg)
9. Trivy Docker Image Scan
10. Push to DockerHub
11. Deploy to Kubernetes

## Port & URL Reference (Internal/Service Ports)
- Jenkins UI: :8080
- SonarQube: :9000
- Prometheus: :9090
- Grafana: :3000
- Node Exporter: :9100
- Kubernetes API: :6443
- Netflix Clone App: :32000 (NodePort)

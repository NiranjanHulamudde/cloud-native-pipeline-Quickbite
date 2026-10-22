### QuickBite - Automated Cloud Deployment Pipeline

An automated CI/CD and Infrastructure as Code (IaC) pipeline for deploying the three-tier QuickBite Food Management System to AWS using Jenkins, Docker, and Terraform. 

### 🏗️ Architecture Component Overview

* **VPC Networking:** 2 Public Subnets (traffic routing layer) and 2 Private Subnets (insulated computing and storage layers).
* **Ingress Routing:** Public Application Load Balancer (ALB) managing intelligent, path-based routing rules.
* **Compute Infrastructure:** AWS ECS Fargate hosting serverless containers completely isolated inside private subnets.
* **Database Management:** Private, managed MongoDB database instance providing secure storage.
* **Automation Engine:** Jenkins server processing declarative workflows triggered via automated GitHub webhooks.

### 🛠️ Technology Stack

* **Application Core:** Vite + React (Frontend & Admin), Node.js + Express (Backend), MongoDB (Database)
* **Infrastructure:** Terraform, AWS (VPC, ALB, ECS Fargate, Security Groups)
* **Automation:** Jenkins, Docker, Docker Compose, Docker Hub Registry

### 📂 Project Repository Workspace

text

├── Admin/               # React dashboard source files & build instructions
├── Backend/             # Express API application logic & database connections
├── Frontend/            # React web user interface components
├── terraform/           # IaC layout scripts
│   ├── network.tf       # VPC network gateways, routes, and subnets
│   ├── security.tf      # Firewall rule access configuration definitions
│   ├── alb.tf           # Traffic load balancer routing configurations
│   ├── ecs.tf           # Serverless container definitions and compute service tasks
│   └── variables.tf     # Configurable infrastructure environment metrics
├── docker-compose.yml   # Multi-tier local sandboxed environment orchestration
└── Jenkinsfile          # End-to-end automated deployment pipeline instructions

Use code with caution.

### 🚀 Execution Instructions

### 1. Local Development Execution

Verify that all application layers interact correctly on your machine before committing structural updates: 

bash

docker compose up --build


* **User Application Interface:** http://localhost:3000
* **Administrative Dashboard:** http://localhost:3001
* **Backend Core API Health:** http://localhost:4000

### 2. Automated Pipeline Workflow

The workspace operates automatically on strict GitOps validation patterns: 

1. **Push:** Code changes are pushed directly to the main branch on GitHub.
2. **Trigger:** GitHub sends an instant notification webhook to activate the Jenkins workspace.
3. **Build:** Jenkins compiles and packages the code folders into isolated Docker layers using restricted memory profiles (max-old-space-size=512).
4. **Ship:** Versioned images tagged with both the unique short Git commit hash and :latest references are pushed to Docker Hub.
5. **Deploy:** Jenkins uses Terraform to execute blue-green infra checks and securely deploys the structural updates straight to AWS ECS Fargate.

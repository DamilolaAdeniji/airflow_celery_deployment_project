# Airflow Celery Deployment Project

## Overview

This repository contains everything you need to deploy an Apache Airflow environment using the **Celery executor** on AWS EC2 instances.  
The environment uses Docker containers for all Airflow services (webserver, scheduler, worker, triggerer, and initialization service) and uses Terraform to provision the required AWS infrastructure. Each Airflow component runs in its own Docker container and can be scaled horizontally across EC2 instances.

- **Base image:** `apache/airflow:2.10.5`  
- **Executor:** CeleryExecutor  
- **Backend services:** PostgreSQL (metadata DB), Redis (message broker), S3 (logs storage)  
- **Infra provisioning:** Terraform (EC2, VPC, RDS, IAM, SSM, S3)  

---

## Architecture

- **Terraform** provisions:
  - VPC with public & private subnets across 3 availability zones.
  - EC2 instances (Ubuntu 22.04) hosting Airflow components in Docker containers.
  - RDS PostgreSQL for Airflow metadata.
  - Elastic IPs and security groups.
  - S3 bucket for Airflow logs.
  - IAM roles with SSM Parameter Store access for secrets/configs.

- **Docker Compose** defines:
  - Airflow services: `webserver`, `scheduler`, `worker`, `triggerer`, `init`.
  - Backend services: `postgres`, `redis`.
  - Volumes for logs and DAGs.
  - Environment variables mapped from AWS SSM.

---

## Prerequisites

- Terraform >= 1.5  
- AWS CLI configured with sufficient privileges  
- Docker & Docker Compose installed on EC2 instances  
- Python >= 3.10 (if running locally for testing)

---

## Setup Instructions

### 1. Clone the Repository

```bash
git clone https://github.com/DamilolaAdeniji/airflow_celery_deployment_project.git
cd airflow_celery_deployment_project
```
### 2. Provision Infrastructure with Terraform
- This step provisions the VPC, EC2 instances, RDS PostgreSQL, Redis, IAM roles, and S3 buckets.
```bash
cd terraform
terraform init
terraform plan
terraform apply
```

### 3. Load Environment Variables
- Secrets and connection strings are stored in AWS SSM Parameter Store. Use the helper script to fetch and write them into an .env file:
```bash
bash load_env_variables.sh
```


## Repository Structure

.
├── airflow/                 # Airflow setup
│   ├── dags/                # DAGs (pipelines)
│   ├── docker-compose.yaml  # Airflow & backend services
│   ├── Dockerfile           # Custom Airflow image
│   └── load_env_variables.sh
├── terraform/               # Terraform IaC for AWS
│   ├── ec2.tf               # EC2 instances
│   ├── iam.tf               # IAM roles & policies
│   ├── rds.tf               # RDS PostgreSQL
│   ├── vpc.tf               # VPC & subnets
│   ├── ssm.tf               # SSM parameters
│   └── s3.tf                # S3 bucket for logs
└── README.md

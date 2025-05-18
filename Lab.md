# 1. Lab Overview

The lab involves creating a simple microservices-based application that needs to be:

* Containerized
* Deployed to AWS EKS using Terraform
* Managed using Kubernetes
* Enhanced with Helm charts

---

# 2. Objectives

* **Docker**: Build and containerize a sample application.
* **Terraform**: Create infrastructure for AWS EKS using Terraform scripts.
* **Kubernetes**: Deploy and manage the application in an EKS cluster.
* **AWS EKS**: Use AWS's managed Kubernetes service for deployment.
* **Helm Charts**: Package and deploy the application using Helm.

---

# 3. Lab Tasks

---

## Task 1: Containerize the Application

1. Provide a sample web application (Python / Node.js).
2. You are required to:

   * Write a Dockerfile to containerize the application.
   * Build and test the Docker image locally.
   * Push the image to a container registry (e.g., AWS Elastic Container Registry or Docker Hub).

**Deliverables:**

* A Dockerfile.
* A running container verified locally.
* Image pushed to a registry.

---

## Task 2: Create AWS EKS Infrastructure Using Terraform

1. A basic Terraform template with placeholders will be provided.
2. You are required to:

   * Write Terraform code to create an EKS cluster.
   * Configure the worker nodes and networking (VPC, Subnets, Security Groups).
   * Output the kubeconfig for cluster access.

**Deliverables:**

* Terraform configuration files.
* A working EKS cluster.

---

## Task 3: Deploy the Application to Kubernetes

1. Kubernetes manifests for the application may be provided.
2. You are required to:

   * Deploy the application to the EKS cluster using `kubectl`.
   * Expose the application using a Kubernetes Service.

**Deliverables:**

* Kubernetes deployment and service manifests.
* The application is accessible via a service endpoint.

---

## Task 4: Package and Deploy with Helm

1. You are required to:

   * Create a Helm chart for the application.
   * Add parameters for configurable values like the number of replicas, resource limits, and container image.
   * Deploy the application to the EKS cluster using the Helm chart.

**Deliverables:**

* Helm chart with templated YAML files.
* Application deployed via Helm.

---

## Bonus Task: Automate CI/CD

* Write a simple GitHub Actions workflow to:

  * Build and push the Docker image
  * Apply Terraform scripts
  * Deploy the Helm chart

**Deliverable:**

* A working GitHub Actions workflow file.

---
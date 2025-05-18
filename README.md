# Assignment
[![Publish Docker image](https://github.com/alankar23/karini-lab/actions/workflows/docker-publish.yml/badge.svg)](https://github.com/alankar23/karini-lab/actions/workflows/docker-publish.yml)
## Task 1: Containerize the Application

The `app/` directory contains the Flask application that returns random quotation from a collection of quotes, clone to linux fortune command.

A `Dockerfile` is included for building the container image.

Changes to the `app/` directory and pushes to the `main` branch trigger a GitHub Actions workflow that:

* Builds the Docker image
* Pushes it to Docker Hub at `alankar23/karini-lab:main`

### Running the Application Locally

**Option 1: Build locally**

```bash
docker build -t fortune-app .
docker run --rm -p 8000:8000 fortune-app
```

**Option 2: Pull from Docker Hub**

```bash
docker pull alankar23/karini-lab:main
docker run --rm -p 8000:8000 alankar23/karini-lab:main
```

**Test the endpoint**

```bash
curl localhost:8000/fortune
```

---

## Task 2: Provision AWS EKS Infrastructure with Terraform

The `terraform/` directory contains the infrastructure code to provision an EKS cluster, including:

* VPC
* Subnets
* Internet Gateway
* EKS cluster and node groups

### Terraform Steps

Initialize Terraform:

```bash
terraform init
```

Preview the execution plan:

```bash
terraform plan
```

Apply the changes to create infrastructure:

```bash
terraform apply
```

### Configure `kubectl` Access

```bash
aws eks update-kubeconfig --region ap-south-1 --name klustah
```

---

## Task 3: Deploy the Application Using Kubernetes Manifests

A combined manifest is available at `helm/manifest.yaml`.

Apply the manifest:

```bash
kubectl apply -f helm/manifest.yaml
```

---

## Task 4: Package and Deploy with Helm

The Helm chart allows customization via `values.yaml`, including:

* Number of replicas
* Resource requests and limits
* Container image

### Install the Helm Chart

```bash
helm upgrade --install app ./app
```

### Port Forwarding to Access the App

```bash
kubectl port-forward svc/app 8000:8000
curl localhost:8000/fortune
```

Output:
```
{
  "Fortune": "O give me a home, Where the buffalo roam, Where the deer and the antelope play, Where seldom is heard A discouraging word, 'Cause what can an antelope say?"
}
```

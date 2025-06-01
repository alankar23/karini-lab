provider "aws" {
  region  = var.provider_config["region"]
  profile = var.provider_config["profile"]

  default_tags {
    tags = {
      "Purpose" = "karni-lab"
    }
  }
}

data "aws_availability_zones" "available" {}

locals {
  cluster_name = "kubernets"
  cluster_version = "1.32"
  network_cidr = "10.0.0.0/16"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.8.1"

  name = "kubernets-vpc"

  cidr = local.network_cidr
  azs  = data.aws_availability_zones.available.names

  public_subnets  = ["10.0.1.0/24"]
  private_subnets = ["10.0.2.0/24", "10.0.3.0/24"]

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true

  public_subnet_tags = {
    "kubernetes.io/role/elb" = 1
  }

  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = 1
  }
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.8.5"

  cluster_name    = local.cluster_name
  cluster_version = local.cluster_version

  cluster_endpoint_public_access           = true
  enable_cluster_creator_admin_permissions = true

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  eks_managed_node_group_defaults = {
    ami_type = "AL2_x86_64"

  }

  cluster_addons = {
    coredns                = {}
    eks-pod-identity-agent = {}
    kube-proxy             = {}
    vpc-cni                = {}
  }
  eks_managed_node_groups = {
    default = {
      name = "node-group-1"

      instance_types = ["t2.micro"]

      min_size     = 1
      max_size     = 3
      desired_size = 2
    }
  }
  cluster_timeouts = {
  create = "10m"
  }
}

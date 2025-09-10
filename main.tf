terraform {
  required_version = ">= 1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0"
    }
  }
}

provider "aws" {
  region = var.region
}

module "vpc" {
  source         = "./modules/vpc"
  cluster_name   = var.cluster_name       # 🔹 yeh line add ki gayi
  vpc_cidr       = var.vpc_cidr
  public_subnets = var.public_subnets
  tags           = var.tags
}

module "iam" {
  source       = "./modules/iam"
  cluster_name = var.cluster_name
  tags         = var.tags
}

module "eks" {
  source           = "./modules/eks"
  cluster_name     = var.cluster_name
  subnet_ids       = module.vpc.public_subnet_ids
  cluster_role_arn = module.iam.eks_cluster_role_arn
  node_role_arn    = module.iam.eks_node_role_arn
  tags             = var.tags
}

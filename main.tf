terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = var.region
}

variable "region" {
  default = "us-west-2"
}

# Networking Module
module "networking" {
  source = "./modules/networking"
  vpc_cidr_block = "10.0.0.0/16"
  public_subnet_cidr = "10.0.1.0/24"
  private_subnet_1_cidr = "10.0.2.0/24"
  private_subnet_2_cidr = "10.0.3.0/24"
}

# EKS Module
module "eks" {
  source = "./modules/eks"
  vpc_id = module.networking.vpc_id
  private_subnet_ids = [
    module.networking.private_subnet_1_id,
    module.networking.private_subnet_2_id
  ]
}

# Bastion Host Module
module "bastion" {
  source = "./modules/bastion"
  vpc_id = module.networking.vpc_id
  subnet_id = module.networking.public_subnet_id
  security_group_id = module.eks.security_group_id
}

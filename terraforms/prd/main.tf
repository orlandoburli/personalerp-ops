terraform {
  required_version = "0.12.20"
  
  backend "s3" {
    region="sa-east-1"
    profile="personalerp"
    bucket="personalerp-aws-admin"
    key="personalerp-infra-state-prd"
  }
}

provider "aws" {
  region  = "sa-east-1"
  profile = "personalerp"
  version = "~> 2.52"
}

provider "tls" {
  version = "~> 2.1"
}

module "network" {
  source = "../modules/network"
  tags = {
    Env = basename(path.cwd)
  }
}

module "cluster" {
  source         = "../modules/cluster"
  vpc_id         = module.network.vpc_id
  eks_subnet_ids = module.network.eks_subnet_ids
  cluster_name   = module.network.cluster_name

  tags = {
    Env = basename(path.cwd)
  }
}

module "worknodes" {
  source         = "../modules/worknodes"
  eks_subnet_ids = module.network.eks_subnet_ids
  cluster_name   = module.network.cluster_name

  worknodes = 3
  worknode_desired_size = 4
  worknode_max_size = 4
  worknode_min_size = 2

  tags = {
    Env = basename(path.cwd)
  }
}
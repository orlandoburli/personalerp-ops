terraform {

  required_version = "0.12.20"
  
  backend "s3" {
    region="sa-east-1"
    profile="personalerp"
    bucket="personalerp-aws-storage"
    key="personalerp-infra-state-stg"
  }
}

provider "aws" {
  region  = "sa-east-1"
  profile = "personalerp"
  version = "~> 2.52"
}

module "general" {
  source = "../modules/general"

  personalerp_env = "stg"
}

module "security" {
  source = "../modules/security"
}
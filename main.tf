terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  region = var.region
}
module "vpc" {
  source = "./modules/vpc"
  region = var.region
}

module "ec2-instance" {
  source = "./modules/ec2-instance"
  vpc_id = module.vpc.vpc_id
  az     = module.vpc.az1
  subnet = module.vpc.subnet_pub1
}

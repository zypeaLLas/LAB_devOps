provider "aws" {
  region = var.region
}

module "vpc" {
  source = "./vpc.tf"
}

module "subnet" {
  source = "./subnet.tf"
  vpc_id = module.vpc.vpc_id
}

module "security_group" {
  source = "./security_groups.tf"
  vpc_id = module.vpc.vpc_id
}

module "instances" {
  source = "./instances.tf"
  public_subnet_id = module.subnet.public_subnet_id
  private_subnet_id = module.subnet.private_subnet_id
}

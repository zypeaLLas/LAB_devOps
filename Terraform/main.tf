provider "aws" {
  region = var.region
}

module "vpc" {
  source = "./modules/vpc.tf"
}

module "subnet" {
  source = "./modules/subnet.tf"
  vpc_id = module.vpc.vpc_id
}

module "security_group" {
  source = "./modules/security_groups.tf"
  vpc_id = module.vpc.vpc_id
}

module "instances" {
  source = "./modules/instances"
  public_subnet_id = module.subnet.public_subnet_id
  private_subnet_id = module.subnet.private_subnet_id
}

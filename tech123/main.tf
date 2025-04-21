module "vpc" {
  source = "./modules/vpc"

  project_name         = var.project_name
  netw_cidr            = var.netw_cidr
  availability_zones   = var.availability_zones
  public_subnets_cidr  = var.public_subnets_cidr
  private_subnets_cidr = var.private_subnets_cidr
  db_subnets_cidr      = var.db_subnets_cidr
}


# Call Security Group module
module "security_groups" {
  source       = "./modules/security_groups" # Path to the security group module
  project_name = var.project_name            # Pass the project name variable
  vpc_id       = module.vpc.vpc_id           # Use the vpc_id output from the VPC module
  my_ip        = var.my_ip                   # Pass the IP (or list of IPs) for bastion access
}










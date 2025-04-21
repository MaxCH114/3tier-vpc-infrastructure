variable "aws_region" {
  description = "AWS region to deploy resources in"
  type        = string
}

variable "project_name" {
  description = "Name of the project"
  type        = string
}

variable "netw_cidr" {
  description = "Main CIDR block for the VPC"
  type        = string
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
}

variable "public_subnets_cidr" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
}

variable "private_subnets_cidr" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)
}

variable "db_subnets_cidr" {
  description = "List of CIDR blocks for DB subnets"
  type        = list(string)
}

variable "my_ip" {
  description = "The CIDR block (usually your IP) allowed to access the bastion host"
  type        = list(string)
}









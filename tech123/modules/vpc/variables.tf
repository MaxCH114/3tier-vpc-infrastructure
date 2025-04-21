variable "project_name" {
  description = "Name of the project, used to tag resources"
  type        = string
}

variable "netw_cidr" {
  description = "Main CIDR block for the VPC"
  type        = string
}

variable "availability_zones" {
  description = "List of availability zones to use for subnets"
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
  description = "List of CIDR blocks for database subnets"
  type        = list(string)
}
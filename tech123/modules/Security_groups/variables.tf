variable "project_name" {
  description = "The name of the project to prefix resource names"
  type        = string
}

variable "vpc_id" {
  description = "The ID of the VPC where the security groups will be created"
  type        = string
}

variable "my_ip" {
  description = "List of CIDR blocks allowed to access the bastion host"
  type        = list(string)
}

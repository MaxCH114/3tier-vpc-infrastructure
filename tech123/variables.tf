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

variable "health_check_path" {
  description = "Health check path for the ALB target group"
  type        = string
  
}

variable "target_port" {
  description = "Port for the target group"
  type        = number
  default     = 80
}

variable "target_protocol" {
  description = "Protocol for the target group"
  type        = string
  default     = "HTTP"
}

variable "ec2_instance_type" {
  default = "t3.micro"
  type    = string
}


variable "environment" {
  type = string
}


variable "listener_port" {
  description = "Port for the ALB listener"
  type        = number
  default     = 80  # or whatever you intend
}






variable "project_name" {
  description = "The name of the project"
  type        = string
}

variable "environment" {
  description = "The deployment environment (e.g., dev, prod)"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type for ASG instances"
  type        = string
}

variable "instance_profile" {
  description = "IAM instance profile name for EC2"
  type        = string
}

variable "security_group_ids" {
  description = "List of security group IDs to attach"
  type        = list(string)
}

variable "private_subnet_ids" {
  description = "List of private subnet IDs for ASG instances"
  type        = list(string)
}

variable "target_group_arn" {
  description = "ARN of the target group to register instances with"
  type        = string
}

variable "desired_capacity" {
  description = "Desired number of instances"
  type        = number
  default     = 3
}

variable "min_size" {
  description = "Minimum number of instances"
  type        = number
  default     = 3
}

variable "max_size" {
  description = "Maximum number of instances"
  type        = number
  default     = 6
}
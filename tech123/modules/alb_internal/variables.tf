variable "project_name" {
  type = string
}
variable "environment" {
  type = string
}
variable "vpc_id" {
  type = string
}
variable "private_subnet_ids" {
  description = "List of private subnet IDs for the internal ALB"
  type        = list(string)
}
variable "security_group_ids" {
  description = "SGs to attach to the internal ALB"
  type        = list(string)
}
variable "listener_port" {
  description = "Port the ALB listener listens on"
  type        = number
  default     = 80
}
variable "listener_protocol" {
  description = "Protocol for the ALB listener"
  type        = string
  default     = "HTTP"
}
variable "target_port" {
  description = "Port the target group forwards to"
  type        = number
  default     = 80
}
variable "target_protocol" {
  description = "Protocol for the target group"
  type        = string
  default     = "HTTP"
}
variable "health_check_path" {
  description = "Path for health checks"
  type        = string
  default     = "/"
}
variable "healthy_threshold" {
  description = "Healthy threshold count"
  type        = number
  default     = 3
}
variable "unhealthy_threshold" {
  description = "Unhealthy threshold count"
  type        = number
  default     = 3
}
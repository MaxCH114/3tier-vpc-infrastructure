output "internal_alb_sg_id" {
  description = "Security group ID attached to the internal ALB"
  value       = var.security_group_ids[0]
}

output "internal_alb_arn" {
  description = "ARN of the internal ALB"
  value       = aws_lb.internal.arn
}

output "internal_alb_dns_name" {
  description = "DNS name of the internal ALB"
  value       = aws_lb.internal.dns_name
}

output "internal_tg_arn" {
  description = "ARN of the internal target group"
  value       = aws_lb_target_group.internal_tg.arn
}
output "face_client_sg_id" {
  description = "The ID of the face client security group"
  value       = aws_security_group.face_client_sg.id
}

output "web_server_sg_id" {
  description = "The ID of the web server security group"
  value       = aws_security_group.web_server_sg.id
}

output "backend_lb_sg_id" {
  description = "The ID of the backend load balancer security group"
  value       = aws_security_group.backend_lb_sg.id
}

output "app_server_sg_id" {
  description = "The ID of the application server security group"
  value       = aws_security_group.app_server_sg.id
}

output "db_server_sg_id" {
  description = "The ID of the database server security group"
  value       = aws_security_group.db_server_sg.id
}



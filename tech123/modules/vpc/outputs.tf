output "vpc_id" {
  description = "The ID of the created VPC"
  value       = aws_vpc.tech123_vpc.id
}

output "public_subnet_ids" {
  description = "List of public subnet IDs"
  value       = [for subnet in aws_subnet.public_subnets : subnet.id]
}

output "private_subnet_ids" {
  description = "List of private subnet IDs"
  value       = [for subnet in aws_subnet.private_subnets : subnet.id]
}

output "db_subnet_ids" {
  description = "List of database subnet IDs"
  value       = [for subnet in aws_subnet.db_subnets : subnet.id]
}

output "public_route_table_id" {
  description = "ID of the public route table"
  value       = aws_route_table.public_route_table.id
}

output "private_route_table_id" {
  description = "ID of the private route table"
  value       = aws_route_table.private_route_table.id
}

output "db_route_table_id" {
  description = "ID of the database route table"
  value       = aws_route_table.db_route_table.id
}

output "nat_gateway_id" {
  description = "ID of the NAT Gateway"
  value       = aws_nat_gateway.nat.id
}

output "internet_gateway_id" {
  description = "ID of the Internet Gateway"
  value       = aws_internet_gateway.tech123_igw.id
}

output "vpc_cidr" {
  description = "CIDR block of the VPC"
  value       = aws_vpc.tech123_vpc.cidr_block
}



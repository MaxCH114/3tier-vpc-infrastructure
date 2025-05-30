aws_region   = "us-east-1"   # AWS region to deploy into
project_name = "tech123"     # Project identifier used in resource naming
netw_cidr    = "10.0.0.0/16" # Base VPC CIDR block

# Availability Zones to spread across
availability_zones = ["us-east-1a", "us-east-1b", "us-east-1c"]

# Subnet CIDR blocks
public_subnets_cidr  = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
private_subnets_cidr = ["10.0.11.0/24", "10.0.12.0/24", "10.0.13.0/24"]
db_subnets_cidr      = ["10.0.21.0/24", "10.0.22.0/24", "10.0.23.0/24"]



# EC2 Instance conf
ec2_instance_type = "t3.micro"
environment       = "prod" # 
health_check_path = "/health" # Health check path for the ALB target group
listener_port     = 80 # Port for the ALB listener
target_port       = 80 # Port for the target group
target_protocol   = "HTTP" # Protocol for the target group


my_ip = [ "0.0.0.0/0" ] # Replace with your IP or CIDR block for security group rules


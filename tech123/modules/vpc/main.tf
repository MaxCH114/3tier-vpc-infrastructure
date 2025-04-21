# VPC
resource "aws_vpc" "tech123_vpc" {
  cidr_block           = var.netw_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "${var.project_name} vpc"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "tech123_igw" {
  vpc_id = aws_vpc.tech123_vpc.id

  tags = {
    Name = "${var.project_name} igw"
  }
}

# Elastic IP for NAT Gateway
resource "aws_eip" "nat_eip" {
  domain = "vpc"
}

# NAT Gateway (using first public subnet)
resource "aws_nat_gateway" "nat" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnets[0].id

  tags = {
    Name = "${var.project_name} nat gateway"
  }

  depends_on = [aws_internet_gateway.tech123_igw]
}

# Public Subnets
resource "aws_subnet" "public_subnets" {
  for_each                = { for idx, cidr in var.public_subnets_cidr : idx => cidr }
  vpc_id                  = aws_vpc.tech123_vpc.id
  cidr_block              = each.value
  availability_zone       = var.availability_zones[each.key]
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.project_name} public subnet ${each.key + 1}"
  }
}

# Private Subnets
resource "aws_subnet" "private_subnets" {
  for_each          = { for idx, cidr in var.private_subnets_cidr : idx => cidr }
  vpc_id            = aws_vpc.tech123_vpc.id
  cidr_block        = each.value
  availability_zone = var.availability_zones[each.key]

  tags = {
    Name = "${var.project_name} private subnet ${each.key + 1}"
  }
}

# DB Subnets
resource "aws_subnet" "db_subnets" {
  for_each          = { for idx, cidr in var.db_subnets_cidr : idx => cidr }
  vpc_id            = aws_vpc.tech123_vpc.id
  cidr_block        = each.value
  availability_zone = var.availability_zones[each.key]

  tags = {
    Name = "${var.project_name} db subnet ${each.key + 1}"
  }
}

# Route Table - Public
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.tech123_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tech123_igw.id
  }

  tags = {
    Name = "${var.project_name} public route table"
  }
}

# Route Table - Private
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.tech123_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat.id
  }

  tags = {
    Name = "${var.project_name} private route table"
  }
}

# Route Table - DB (local only)
resource "aws_route_table" "db_route_table" {
  vpc_id = aws_vpc.tech123_vpc.id

  route {
    cidr_block = var.netw_cidr
    gateway_id = "local"
  }

  tags = {
    Name = "${var.project_name} db route table"
  }
}

# Associations
resource "aws_route_table_association" "public_subnet_association" {
  for_each           = aws_subnet.public_subnets
  subnet_id          = each.value.id
  route_table_id     = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "private_subnet_association" {
  for_each          = aws_subnet.private_subnets
  subnet_id         = each.value.id
  route_table_id    = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "db_subnet_association" {
  for_each          = aws_subnet.db_subnets
  subnet_id         = each.value.id
  route_table_id    = aws_route_table.db_route_table.id
}
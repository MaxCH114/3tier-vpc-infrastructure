resource "aws_security_group" "face_client_sg" {
  depends_on = [var.vpc_id]
  vpc_id      = var.vpc_id
  name        = "${var.project_name}-face-client-sg"
  description = "Allow inbound traffic to ports 80 and 443 from public internet"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow HTTP traffic"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow HTTPS traffic"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "Allow all outbound traffic"
  }

  tags = {
    Name = "${var.project_name}-face-client-sg"
  }
}

resource "aws_security_group" "web_server_sg" {
  depends_on = [var.vpc_id , aws_security_group.face_client_sg]
  vpc_id      = var.vpc_id
  name        = "${var.project_name}-web-server-sg"
  description = "Allow HTTP/HTTPS from face client SG"

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.face_client_sg.id]
    description     = "Allow HTTP from face client SG"
  }

  ingress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.face_client_sg.id]
    description     = "Allow HTTPS from face client SG"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-web-server-sg"
  }
}

resource "aws_security_group" "backend_lb_sg" {
  depends_on = [var.vpc_id , aws_security_group.web_server_sg]
  vpc_id      = var.vpc_id
  name        = "${var.project_name}-backend-lb-sg"
  description = "Allow HTTP/HTTPS from web server SG"

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.web_server_sg.id]
    description     = "Allow HTTP from web server SG"
  }

  ingress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.web_server_sg.id]
    description     = "Allow HTTPS from web server SG"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-backend-lb-sg"
  }
}

resource "aws_security_group" "app_server_sg" {
  depends_on = [var.vpc_id , aws_security_group.backend_lb_sg]
  vpc_id      = var.vpc_id
  name        = "${var.project_name}-app-server-sg"
  description = "Allow HTTP from backend LB SG"

  ingress {
    from_port       = 4000
    to_port         = 4000
    protocol        = "tcp"
    security_groups = [aws_security_group.backend_lb_sg.id]
    description     = "Allow HTTP from backend LB SG"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-app-server-sg"
  }
}

resource "aws_security_group" "db_server_sg" {
  depends_on = [var.vpc_id , aws_security_group.app_server_sg]
  vpc_id      = var.vpc_id
  name        = "${var.project_name}-db-server-sg"
  description = "Allow MySQL from app server SG"

  ingress {
    from_port       = 3306
    to_port         = 3306
    protocol        = "tcp"
    security_groups = [aws_security_group.app_server_sg.id]
    description     = "Allow MySQL from app server SG"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-db-server-sg"
  }
}

resource "aws_security_group" "bastion_sg" {
  depends_on = [var.vpc_id]
  vpc_id      = var.vpc_id
  name        = "${var.project_name}-bastion-sg"
  description = "Allow SSH from admin IP"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.my_ip
    description = "Allow SSH from admin IP"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-bastion-sg"
  }
}
module "vpc" {
  source = "./modules/vpc"

  project_name         = var.project_name
  netw_cidr            = var.netw_cidr
  availability_zones   = var.availability_zones
  public_subnets_cidr  = var.public_subnets_cidr
  private_subnets_cidr = var.private_subnets_cidr
  db_subnets_cidr      = var.db_subnets_cidr
}

# calling security groups module
module "Security_groups" {
  source = "./modules/security_groups"
  vpc_id = module.vpc.vpc_id

  project_name       = var.project_name
  my_ip              = var.my_ip

}

# calling alb module 
module "alb_internal" {
  source             = "./modules/alb_internal"
  project_name       = var.project_name
  environment        = var.environment
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
  security_group_ids = [module.security_groups.backend_lb_sg_id ]
  target_port        = 80
  target_protocol    = "HTTP"
  health_check_path  = var.health_check_path
  listener_port      = 80
  listener_protocol  = "HTTP"
}

module "asg" {
  source             = "./modules/asg"
  project_name       = var.project_name
  environment        = var.environment
  instance_type      = "t3.micro"
  instance_profile   = aws_iam_instance_profile.ssm_instance_profile.name
  security_group_ids = [module.security_groups.app_server_sg_id]
  private_subnet_ids = module.vpc.private_subnet_ids
  target_group_arn   = module.alb_internal.internal_tg_arn
  desired_capacity   = 3
  min_size           = 3
  max_size           = 6
}


resource "aws_iam_role" "ssm_role" {
  name               = "${var.project_name}-ssm-role"
  assume_role_policy = data.aws_iam_policy_document.ssm_assume_role_policy.json
}

resource "aws_iam_instance_profile" "ssm_instance_profile" {
  name = "${var.project_name}-ssm-profile"
  role = aws_iam_role.ssm_role.name
}

data "aws_iam_policy_document" "ssm_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}







data "aws_ami" "amazon_linux_2023" {
  most_recent = true

  owners = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

locals {
  userdata_script = templatefile("${path.module}/scripts/asg_user_data.sh.tpl", {
    project_name = var.project_name
    environment  = var.environment
  })
}
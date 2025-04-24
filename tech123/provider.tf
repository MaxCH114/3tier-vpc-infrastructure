
# This file is used to configure the provider and backend for the terraform code.
# The provider is the plugin that terraform uses to interact with the cloud provider.

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = ">= 1.0.0"
}

terraform {
  //use s3 as the backend to store the state file
  backend "s3" {
    bucket = "my-terraform-backen-abc-tech123"
    key    = "Prod/terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = var.aws_region
} 
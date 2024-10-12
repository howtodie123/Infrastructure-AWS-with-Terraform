terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.70.0"
    }
  }
}

provider "aws" {
  region = "us-east-1" 
  access_key = local.access_key
  secret_key = local.secret_key
}

module "VPC" {
  source                  = "./modules/VPC"
  vpc_cidr                = var.vpc_cidr #"10.0.0.0/16"
  public_subnet_cidr      = var.public_subnet_cidr #"10.0.1.0/24"
  private_subnet_cidr     = var.private_subnet_cidr #"10.0.2.0/24"
  availability_zone       = var.availability_zone #"us-east-1a"
}

# module "NAT" {
#   source                  = "./modules/NAT"
#   public_subnet_id        = module.VPC.public_subnet_id

# }

# module "Route_Table" {
#   source                  = "./modules/Route_Table"
#   vpc_id                  = module.VPC.vpc_id
#   gateway_id              = module.VPC.internet_gateway_id
#   public_subnet_id        = module.VPC.public_subnet_id
#   nat_gateway_id          = module.NAT.nat_gateway_id
#   private_subnet_id       = module.VPC.private_subnet_id  
# }

# module "security_group" {
#   source                  = "./modules/Security_Group"
#   vpc_id                  = module.VPC.vpc_id
#   allowed_ip              = "0.0.0.0/0" 
# }


# module "ec2" {
#   source                  = "./modules/EC2"
#   ami                     = "ami-005fc0f236362e99f"
#   instance_type           = "t2.micro"
#   public_subnet_id        = module.VPC.public_subnet_id
#   private_subnet_id       = module.VPC.private_subnet_id
#   public_security_group   = module.security_group.public_security_group_id
#   private_security_group  = module.security_group.private_security_group_id
# }

# main.tf

# variable "repository_name" {
#   type = string
#   validation {
#     condition = length(var.repository_name) <= 100
#     error_message = "The repository name must be less than or equal to 100 characters."
#   }
# }

# variable "kms_key_id" {
#   type = string
#   default = ""
# }

# resource "aws_codecommit_repository" "test" {
#   repository_name = format("repo-%s", var.repository_name)
#   description = "Test repository."
#   kms_key_id = var.kms_key_id != "" ? var.kms_key_id : null
# }
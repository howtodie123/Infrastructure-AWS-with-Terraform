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
  vpc_cidr                = var.vpc_cidr 
  public_subnet_cidr      = var.public_subnet_cidr 
  private_subnet_cidr     = var.private_subnet_cidr 
  availability_zone       = var.availability_zone 
}

module "NAT" {
  source                  = "./modules/NAT"
  public_subnet_id        = module.VPC.public_subnet_id
}

module "Route_Table" {
  source                  = "./modules/Route_Table"
  vpc_id                  = module.VPC.vpc_id
  gateway_id              = module.VPC.internet_gateway_id
  public_subnet_id        = module.VPC.public_subnet_id
  nat_gateway_id          = module.NAT.nat_gateway_id
  private_subnet_id       = module.VPC.private_subnet_id  
}

module "ec2" {
  source                  = "./modules/EC2"
  ami                     = var.ami_id
  instance_type           = var.instance_type
  key_name                = var.key_name
  public_subnet_id        = module.VPC.public_subnet_id
  private_subnet_id       = module.VPC.private_subnet_id
  public_security_group   = module.security_group.public_security_group_id
  private_security_group  = module.security_group.private_security_group_id
}

module "security_group" {
  source                  = "./modules/Security_Group"
  vpc_id                  = module.VPC.vpc_id
  allowed_ip              = var.allowed_ip # specify your ip address
  public_subnet_id        = module.VPC.public_subnet_id
  private_subnet_id       = module.VPC.private_subnet_id
}

terraform {
  backend "s3" {
    bucket = "Group7-terraform-states"       # Tên S3 bucket để lưu trạng thái
    key    = "dev/terraform.tfstate"     # Đường dẫn bên trong S3 để lưu file tfstate
    region = "us-east-1"                 # Khu vực của S3 bucket
    encrypt = true                        # Mã hóa file trạng thái trong S3
  }
}

resource "aws_s3_bucket" "example" {
  bucket     = "Group7-bucket-terraform"
  tags = {
    Name        = "Group7 bucket"
    Environment = "Dev"
  }
   lifecycle {
    prevent_destroy = false  
  }
}

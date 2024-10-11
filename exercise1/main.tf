terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.71.0"
    }
  }
}

provider "aws" {
  region = "us-east-1" # this region is the UIT provided region , can change to any region
  access_key = ""
  secret_key = ""
}

# resource "aws_instance" "Group6" {
#   ami = "ami-005fc0f236362e99f" # this is the ami id for the ubuntu 20.04
#   instance_type = "t2.micro" # this is the instance type
# }

module "VPC" {
  source                  = "./modules/VPC"
  vpc_cidr                = "10.0.0.0/16"
  public_subnet_cidr      = "10.0.1.0/24"
  private_subnet_cidr     = "10.0.2.0/24"
  availability_zone       = "us-east-1a"
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

module "security_group" {
  source                  = "./modules/Security_Group"
  vpc_id                  = module.vpc.vpc_id
  allowed_ip              = "0.0.0.0/0" 
}


module "ec2" {
  source                  = "./modules/EC2"
  ami                     = module.ec2.ami
  instance_type           = module.ec2.instance_type
  public_subnet_id        = module.vpc.public_subnet_id
  private_subnet_id       = module.vpc.private_subnet_id
  public_security_group   = module.security_groups.public_security_group_id
  private_security_group  = module.security_groups.private_security_group_id
}

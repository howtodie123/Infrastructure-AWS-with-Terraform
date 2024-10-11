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

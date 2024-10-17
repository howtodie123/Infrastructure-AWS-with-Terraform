resource "aws_vpc" "main_vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_support = true
  enable_dns_hostnames = true
  instance_tenancy     = "default"
  
  
  tags = {
    Name = "VPC group 7"
    Environment = "test"
  }
  #checkov:skip=CKV_AWS_11:don't need VPC Flow Log enabled
  #checkov:skip=CKV_AWS_12:have restricts all traffic in security group default
}

resource "aws_internet_gateway" "internet_gateway" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "IGW group 7"
    Environment = "test"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id = aws_vpc.main_vpc.id
  cidr_block = var.public_subnet_cidr
  map_public_ip_on_launch = true # assign public IP to instance
  availability_zone = var.availability_zone

  tags = {
    Name = "Public Subnet group 7"
    Environment = "test"
  }
  #checkov:skip=CKV_AWS_130:Allow automatic public IP assignment
}

resource "aws_subnet" "private_subnet" {
  vpc_id = aws_vpc.main_vpc.id
  cidr_block = var.private_subnet_cidr
  availability_zone = var.availability_zone

  tags = {
    Name = "Private Subnet group 7"
    Environment = "test"
  }
}
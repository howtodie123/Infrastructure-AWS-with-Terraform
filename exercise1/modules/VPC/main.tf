resource "aws_vpc" "main_vpc" {
  cidr_block = var.vpc_cidr
  enable_dns_support = true
  enable_dns_hostnames = true
  instance_tenancy     = "default"
  
  
  tags = {
    Name = "VPC group 7"
    Environment = "test"
  }
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
  map_public_ip_on_launch = false # do not assign public IP to instance
  availability_zone = var.availability_zone

  tags = {
    Name = "Public Subnet group 7"
    Environment = "test"
  }
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

# This is code (below) for checkov requirement 

# resource "aws_default_security_group" "default_security_group" {
#   vpc_id = aws_vpc.main_vpc.id
# }

resource "aws_flow_log" "vpc_flow_log" {
  vpc_id = aws_vpc.main_vpc.id
  log_destination = aws_cloudwatch_log_group.vpc_log_group.arn
  traffic_type = "ALL"

  tags = {
    Name = "VPC Flow Log"
  }
}

resource "aws_kms_key" "cloudwatch_kms_key" {
  description = "KMS key for CloudWatch Log Group encryption"
  enable_key_rotation = true
  
   policy      = <<POLICY
  {
    "Version": "2024-10-17",
    "Id": "default",
    "Statement": [
      {
        "Sid": "DefaultAllow",
        "Effect": "Allow",
        "Principal": {
          "AWS": "arn:aws:iam::654654380717:root"
        },
        "Action": "kms:*",
        "Resource": "*"
      }
    ]
  }
POLICY

  tags = {
    Name = "CloudWatch KMS Key"
  }
}

resource "aws_cloudwatch_log_group" "vpc_log_group" {
  name = "vpc-flow-logs"
  retention_in_days = 365
  kms_key_id        = aws_kms_key.cloudwatch_kms_key.arn 
  tags = {
    Name = "VPC Flow Logs Group"
  }
}



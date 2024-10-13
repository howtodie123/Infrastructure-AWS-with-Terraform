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

resource "aws_default_security_group" "default_security_group" {
  vpc_id = aws_vpc.main_vpc.id

  ingress {
    protocol  = "-1"
    self      = true
    from_port = 0
    to_port   = 0
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_iam_role" "vpc_flow_logs_role" {
  name = "vpc-flow-logs-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "vpc-flow-logs.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      },
    ]
  })
}

# resource "aws_iam_policy_attachment" "vpc_flow_logs_attachment" {
#   name       = "vpc-flow-logs-attachment"
#   policy_arn = "arn:aws:iam::aws:policy/service-role/AWS_VPC_FlowLogs"
#   roles      = [aws_iam_role.vpc_flow_logs_role.name]
# }

# resource "aws_cloudwatch_log_group" "vpc_flow_logs" {
#   name              = "vpc-flow-logs"
#   retention_in_days = 365  # at least 365
# }

# resource "aws_flow_log" "vpc_flow_log" {
#   log_destination = aws_cloudwatch_log_group.vpc_flow_logs.arn
#   vpc_id         = aws_vpc.main_vpc.id
#   traffic_type   = "ALL"  # Có thể là "ACCEPT", "REJECT", hoặc "ALL"
#   iam_role_arn   = aws_iam_role.vpc_flow_logs_role.arn
# }

resource "aws_flow_log" "vpc_flow_log" {
  vpc_id = aws_vpc.main_vpc.id
  log_destination = aws_cloudwatch_log_group.vpc_log_group.arn
  traffic_type = "ALL"

  tags = {
    Name = "VPC Flow Log"
  }
}

resource "aws_cloudwatch_log_group" "vpc_log_group" {
  name = "vpc-flow-logs"
  retention_in_days = 366

  tags = {
    Name = "VPC Flow Logs Group"
  }
}

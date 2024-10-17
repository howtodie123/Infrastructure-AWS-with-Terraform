resource "aws_default_security_group" "default_security_group_7" {
  vpc_id = var.vpc_id
  tags = {
    Name = "Group 7: Default Security Group VPC"
  }
}

resource "aws_security_group" "public" {
  vpc_id = var.vpc_id
  description = "Allow SSH access from a specific IP"
  name = "Group 7: Public Security Group "

  # Allow SSH from a specific IP 
  ingress {
    description = "Allow SSH from a specific IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.allowed_ip]
  }
  # Allow all outbound traffic (outbound)
  egress {
    description = "Allow all outbound traffic (outbound)"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Group 7: Public Security Group " 
  }
  #checkov:skip=CKV_AWS_24:SG will be used for the EC2 instances
  #checkov:skip=CKV_AWS_5:SG will be used for the EC2 instances
}

resource "aws_security_group" "private" {
  vpc_id = var.vpc_id
  description = "Allow connections from Private EC2 instance"
  name = "Group 7: Private Security Group EC2"

  ingress {
    description = "Allow SSH from a specific IP"
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.public.id] # Only allow connections from Public Security Group EC2
  }
  
  ingress {
    description = "Allow all port from a specific IP"
    from_port       = 0
    to_port         = 65535
    protocol        = "tcp"
    security_groups = [aws_security_group.public.id] # Only allow connections from Public Security Group EC2
    
    }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
 
  tags = {
    Name = "Group 7: Private Security Group EC2"
  }
  #checkov:skip=CKV_AWS_5:SG will be used for the EC2 instances
}

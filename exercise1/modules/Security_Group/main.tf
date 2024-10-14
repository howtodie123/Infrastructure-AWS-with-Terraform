resource "aws_default_security_group" "default_security_group_7" {
  vpc_id = var.vpc_id
  name = "Group 7: Private Security Group EC2"
  
  tags = {
    Name = "Group 7: Default Security Group EC2"
  }
}

resource "aws_security_group" "public" {
  vpc_id = var.vpc_id
  description = "Allow SSH access from a specific IP"
  name = "Group 7: Public Security Group EC2"

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
    Name = "Group 7: Public Security Group EC2" 
  }
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
}

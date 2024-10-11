resource "aws_security_group" "public" {
  vpc_id = var.vpc_id
  description = "Allow SSH access from a specific IP"

  # Allow SSH from a specific IP 
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.allowed_ip]
  }
  # Allow all outbound traffic (outbound)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Group 6: Public Security Group EC2" 
  }
}

resource "aws_security_group" "private" {
  vpc_id = var.vpc_id
  description = "Allow connections from Public EC2 instance"
  
  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.public.id] # Only allow connections from Public Security Group EC2
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Group 6: Private Security Group EC2"
  }
}
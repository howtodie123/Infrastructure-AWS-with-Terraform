resource "aws_security_group" "public" {
  vpc_id = var.vpc_id
  description = "Allow SSH access from a specific IP"
  
  # Không cho phép lưu lượng truy cập vào hoặc ra
  #revoke_rules_on_delete = true  # Tự động xóa các quy tắc khi nhóm bảo mật bị xóa

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
  description = "Allow connections from Public EC2 instance"

  # Không cho phép lưu lượng truy cập vào hoặc ra
  #revoke_rules_on_delete = true  # Tự động xóa các quy tắc khi nhóm bảo mật bị xóa

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

# # Make sure that the default security group in the VPC restricts all inbound and outbound traffic.
# # By default, AWS allows all inbound and outbound traffic in the VPC's default security group,
# # which violates the best practice of limiting nonessential traffic
# resource "aws_security_group" "restricted_sg" {
#   vpc_id = var.vpc_id

#   ingress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = []
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = "restricted-security-group"
#   }
# }

# resource "aws_default_security_group" "default" {
#   vpc_id = var.vpc_id

#   ingress {
#     protocol   = "-1"
#     from_port  = 0
#     to_port    = 0
#     cidr_blocks = []
#   }

#   egress {
#     protocol   = "-1"
#     from_port  = 0
#     to_port    = 0
#     cidr_blocks = []
#   }

#   lifecycle {
#     ignore_changes = [ingress, egress]
#   }
# }
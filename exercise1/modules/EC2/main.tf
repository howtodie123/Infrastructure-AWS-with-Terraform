resource "aws_instance" "public" {
  ami = var.ami
  instance_type = var.instance_type
  subnet_id = var.public_subnet_id
  #security_groups = [var.public_security_group]

  tags = {
    Name = "Public Instance Group 6"
  }
}

resource "aws_instance" "private" {
  ami = var.ami
  instance_type = var.instance_type
  subnet_id = var.private_subnet_id
  #security_groups = [var.private_security_group]

  tags = {
    Name = "Private Instance Groub 6"
  }
}



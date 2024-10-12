  resource "aws_key_pair" "my_key" {
  key_name   = "my_key_pair"  # Name key pair
  public_key = file("keySSH/example.pub")  # Path file public key
}
  resource "aws_instance" "public" {
    ami = var.ami
    instance_type = var.instance_type
    subnet_id = var.public_subnet_id
    security_groups = [var.public_security_group]

    tags = {
      Name = "Public Instance Group 7"
    }
    depends_on = [ var.public_security_group ]
  }

  resource "aws_instance" "private" {
    ami = var.ami
    instance_type = var.instance_type
    subnet_id = var.private_subnet_id
    security_groups = [var.private_security_group]
    
    tags = {
      Name = "Private Instance Group 7"
    }
    depends_on = [ var.private_subnet_id]
  }



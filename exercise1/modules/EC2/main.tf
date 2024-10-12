resource "tls_private_key" "example" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = var.key_name
  public_key = tls_private_key.example.public_key_openssh
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

    key_name = aws_key_pair.generated_key.key_name

    tags = {
      Name = "Private Instance Group 7"
    }
    depends_on = [ var.private_subnet_id]
  }

resource "local_file" "tf_key" {
  content  = tls_private_key.example.private_key_pem
  filename = "group7_key.pem"
}

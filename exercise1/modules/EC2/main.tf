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
    
     user_data = <<-EOF
    #!/bin/bash
    # create directory for ssh key
    mkdir -p /home/ec2-user/.ssh

    # save public key to authorized_keys
    echo "${tls_private_key.example.private_key_pem}" > /home/ec2-user/.ssh/id_rsa

    # set permission for ssh key
    chmod 400 /home/ec2-user/.ssh/id_rsa

    # save public key to authorized_keys
    echo "Private key has been saved to /home/ec2-user/.ssh/id_rsa" >> /var/log/myapp.log
  EOF
    associate_public_ip_address = true # ip address public
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

    associate_public_ip_address = false # no ip address public
    depends_on = [ var.private_subnet_id]
  }

resource "local_file" "tf_key" {
  content  = tls_private_key.example.private_key_pem
  filename = "group7_key.pem"
}

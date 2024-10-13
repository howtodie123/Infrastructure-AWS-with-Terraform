resource "tls_private_key" "example" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = var.key_name
  public_key = tls_private_key.example.public_key_openssh
}

resource "aws_instance" "public" {
  ami               = var.ami
  instance_type     = var.instance_type
  subnet_id         = var.public_subnet_id
  security_groups   = [var.public_security_group]
  # associate_public_ip_address = true
  depends_on        = [var.public_security_group]
  # iam instance profile
  iam_instance_profile = var.role_name
  
  # optimize Elastic Block Store (EBS) performance
  ebs_optimized = true 

  monitoring = true

  # Disable IMDSv1 and force use of IMDSv2
  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"  # Forces IMDSv2 usage
    http_put_response_hop_limit = 1
    instance_metadata_tags      = "enabled"
  }

  tags = {
    Name = "Public Instance Group 7"
  }
  root_block_device {
  encrypted    = true
 }

  user_data = <<-EOF
    #!/bin/bash
    mkdir -p /home/ec2-user/.ssh
    echo "${tls_private_key.example.private_key_pem}" > /home/ec2-user/.ssh/id_rsa
    chmod 400 /home/ec2-user/.ssh/id_rsa
    echo "Private key has been saved to /home/ec2-user/.ssh/id_rsa" >> /var/log/myapp.log
  EOF
}


  resource "aws_instance" "private" {
    ami = var.ami
    instance_type = var.instance_type
    subnet_id = var.private_subnet_id
    security_groups = [var.private_security_group]

    # ssh key pair
    key_name = aws_key_pair.generated_key.key_name
    
    ebs_optimized = true 
    monitoring = true
    # iam instance profile
    iam_instance_profile = var.role_name

  # Disable IMDSv1 and force use of IMDSv2
  metadata_options {
    http_endpoint               = "enabled"
    http_tokens                 = "required"  # Forces IMDSv2 usage
    http_put_response_hop_limit = 1
    instance_metadata_tags      = "enabled"
  }
  
  root_block_device {
  encrypted    = true
 } 

    tags = {
      Name = "Private Instance Group 7"
    }

    # associate_public_ip_address = false # no ip address public
    depends_on = [ var.private_subnet_id]
    
  }

resource "local_file" "tf_key" {
  content  = tls_private_key.example.private_key_pem
  filename = "group7_key.pem"
}


# this file is used to store the variables that are used in the main.tf file
# variable will use this file first to get the values of the variables
# default values in variable.tf file will be used if the values are not provided in the terraform.tfvars file
# CIDR block for the VPC
vpc_cidr = "10.0.0.0/16"

# CIDR block for the public subnet
public_subnet_cidr = "10.0.1.0/24"

# CIDR block for the private subnet
private_subnet_cidr = "10.0.2.0/24"

# Availability zone for the resources
availability_zone = "us-east-1a"

# Instance type for the EC2 instance
instance_type = "t2.micro"

# Name of the SSH key pair to access the EC2 instance
key_name = "mykey1"

# AMI ID for the EC2 instance
ami_id = "ami-0866a3c8686eaeeba"

# IP range allowed to access the resources
allowed_ip = "112.197.32.245/32" #  the IP address of the user



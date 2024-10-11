variable "ami" {
    type        = string
    description = "The ID of the AMI to use for the instance"
    default     = "ami-005fc0f236362e99f"
}

variable "instance_type" {
    type        = string
    description = "The type of instance to start"
    default     = "t2.micro"
}

variable "public_subnet_id" {
    type        = string
    description = "The ID of the public subnet"
}

variable "private_subnet_id" {
    type        = string
    description = "The ID of the private subnet"
}

variable "public_security_group" {
    type        = string
    description = "The ID of the public security group"
}

variable "private_security_group" {
    type        = string
    description = "The ID of the private security group"
}
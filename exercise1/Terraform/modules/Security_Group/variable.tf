variable "allowed_ip" {
    description = "The IP address that is allowed to access the security group."
    type        = string
    #default = "0.0.0.0/0"
}

variable "vpc_id" {
    description = "The ID of the VPC where the security group will be created."
    type        = string
}

variable "public_subnet_id" {
  description = "value of public subnet"
  type = string
}
variable "private_subnet_id" {
  description = "value of private subnet"
  type = string
}
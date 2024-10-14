variable "vpc_id" {
    description = "The ID of the VPC"
    type        = string
}

variable "gateway_id" {
    description = "The ID of the Internet Gateway"
    type        = string
}

variable "public_subnet_id" {
    description = "The ID of the public subnet"
    type        = string
}

variable "nat_gateway_id" {
    description = "The ID of the NAT Gateway"
    type        = string
}

variable "private_subnet_id" {
    description = "The ID of the private subnet"
    type        = string
}
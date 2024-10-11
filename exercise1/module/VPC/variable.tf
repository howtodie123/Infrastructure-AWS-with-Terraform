variable "vpc_cidr" {
    description = "The CIDR block for the VPC"
    type        = string
    default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
    description = "List of CIDR blocks for public subnets"
    type        = string
    default     = ""
}

variable "private_subnet_cidr" {
    description = "List of CIDR blocks for private subnets"
    type        = string
    default     = ""
}

variable "availability_zone" {
    description = "List of availability zones"
    type        = string
    default     = ""
}

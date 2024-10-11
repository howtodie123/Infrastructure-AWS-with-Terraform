variable "allowed_ip" {
    description = "The IP address that is allowed to access the security group."
    type        = string
    default = "0.0.0.0/0"
}

variable "vpc_id" {
    description = "The ID of the VPC where the security group will be created."
    type        = string
}
output "vpc_id" {
    description = "The ID of the main VPC"
    value       = aws_vpc.main_vpc.id
}

output "public_subnet_id" {
    description = "The ID of the public subnet"
    value       = aws_subnet.public_subnet.id
}

output "private_subnet_id" {
    description = "The ID of the private subnet"
    value       = aws_subnet.private_subnet.id
}

output "internet_gateway_id" {
    description = "The ID of the internet gateway"
    value       = aws_internet_gateway.internet_gateway.id
}
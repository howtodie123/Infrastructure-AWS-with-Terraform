output "nat_gateway_id" {
    value       = aws_nat_gateway.nat_gateway.id
    description = "The ID of the NAT Gateway"
}
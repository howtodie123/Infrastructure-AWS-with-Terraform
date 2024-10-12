output "route_table_route_public" {
    description = "The routes in the Public Route Table"
    value       = aws_route_table.public_route_table.route
}

output "route_table_route_private" {
    description = "The routes in the Private Route Table"
    value       = aws_route_table.private_route_table.route
}

# output "aws_route_public" {
#     description = "The public route"
#     value       = aws_route.public_internet_access.id
# }

# output "aws_route_private" {
#     description = "The private route"
#     value       = aws_route.private_nat_gateway.id
# }

output "route_table_association_public" {
    description = "The association of the Public Route Table"
    value       = aws_route_table_association.public_association.id
}

output "route_table_association_private" {
    description = "The association of the Private Route Table"
    value       = aws_route_table_association.private_association.id
}
output "public_security_group_id" {
    value       = aws_security_group.public.id
    description = "The ID of the public security group"
}

output "private_security_group_id" {
    value       = aws_security_group.private.id
    description = "The ID of the private security group"
}
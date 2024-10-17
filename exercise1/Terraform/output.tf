output "VPC" {
  description = "VPC information"
  value       = module.VPC
}

output "EC2" {
  description = "EC2 information"
  value       = module.ec2
}

output "NAT" {
  description = "NAT information"
  value       = module.NAT
}

output "Route_Table" {
  description = "Route Table information"
  value       = module.Route_Table
}

output "security_group" {
  description = "Security Group information"
  value       = module.security_group
}
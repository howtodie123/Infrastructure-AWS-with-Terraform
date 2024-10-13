output "role_name" {
  description = "The ID of the IAM role"
  value       = aws_iam_role.ec2_role.name
  
}
output "role_policy_name" {
  description = "The ID of the IAM role policy"
  value       = aws_iam_role_policy.ec2_role_policy.name
}

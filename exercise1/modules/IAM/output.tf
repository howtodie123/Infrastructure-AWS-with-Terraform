output "role_name" {
  description = "The ID of the IAM role"
  value       = aws_iam_instance_profile.ec2_profile.name
  
}

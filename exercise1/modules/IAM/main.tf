#Create a policy
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy
resource "aws_iam_policy" "ec2_policy" {
  name        = "ec2-policy"
  path        = "/"
  description = "Policy to provide permission to EC2"
  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow",
        Action = [
         "ec2:Describe*",
        ],
        Resource =  [
          "arn:aws:ec2:us-east-1:654654380717:instance/*" # Chỉ định tất cả các phiên bản EC2 trong tài khoản này
        ]
      },
    #    {
    #     Effect    = "Allow",
    #     Action    = [
    #       "iam:GetUser",            # Cho phép lấy thông tin người dùng
    #       "iam:ListGroupsForUser"   # Cho phép liệt kê các nhóm mà người dùng này thuộc về
    #     ],
    #     Resource  = [
    #       var.arn_user  # Chỉ định rõ ràng ARN của người dùng IAM
    #     ]
    #   },
    ]
  })
}

#Create a role
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role
resource "aws_iam_role" "ec2_role" {
  name = "ec2-role"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
  tags = {
    tag-key = "Group7-role"
  }
}

#Attach role to policy
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment
resource "aws_iam_role_policy_attachment" "custom" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.ec2_policy.arn
}

#Attach role to an instance profile
#https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_instance_profile
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "app1-ec2-profile"
  role = aws_iam_role.ec2_role.name
}
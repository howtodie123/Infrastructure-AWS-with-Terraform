# Provider AWS
provider "aws" {
  region = "us-west-2"  # Chỉnh sửa theo khu vực của bạn
  access_key = ""
  secret_key = ""
}

# Chạy phần setup
run setup {
  command = apply

  variables {
    
  }

  # Kết nối với module setup để triển khai hạ tầng
  module {
    source              = "./tests/setup"
  }
}

# Chạy các bài kiểm tra
run "unit_test" {
  command = apply
  
  variables {
     vpc_cidr                = "10.0.0.0/16"
     public_subnet_cidr      = "10.0.1.0/24"
     private_subnet_cidr     = "10.0.2.0/24"
     availability_zone       = "us-east-1a"
  }

  # Kiểm tra VPC được tạo
  assert {
    condition = module.VPC.vpc_id != ""
    error_message = "The VPC ID should not be empty."
  }
  
}
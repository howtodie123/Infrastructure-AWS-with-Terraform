Provider AWS
provider "aws" {
  region = "us-west-2"  # Chỉnh sửa theo khu vực của bạn
  access_key = local.access_key
  secret_key = local.secret_key
}

# Chạy phần setup
# run setup {
#   command = apply

#   variables {
    
#   }

#   # Kết nối với module setup để triển khai hạ tầng
#   module {
#     source              = "./tests/setup"
#   }
# }

# Chạy các bài kiểm tra
run "unit_test" {
  command = apply
  
  variables {
    # cưỡng ép gán giá trị vào các biến trong tests

    #  vpc_cidr                = "10.0.0.0/16"
    #  public_subnet_cidr      = "10.0.1.0/24"
    #  private_subnet_cidr     = "10.0.2.0/24"
    #  availability_zone       = "us-east-1a"
  }

  # Kiểm tra VPC được tạo
  assert {
    condition = module.VPC.vpc_id != ""
    error_message = "The VPC ID should not be empty."
  }
  assert {
    condition = module.VPC.public_subnet_id != ""
    error_message = "The public_subnet_id should not be empty."
  }
  assert {
    condition = module.VPC.private_subnet_id != ""
    error_message = "The pravate_subnet_id should not be empty."
  }
  assert { 
    condition = module.VPC.internet_gateway_id  != ""
    error_message = "The internet_gateway_id should not be empty."
  }
}

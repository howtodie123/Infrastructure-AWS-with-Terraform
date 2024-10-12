
provider "aws" {
  region = "us-west-2"  # Edit according to your region
  access_key = run.setup.access_key
  secret_key = run.setup.secret_key
}

run "setup" {
  module {
    source = "./tests/setup"
  }
}

# Run the tests
run "unit_test" {
  command = apply
  
  variables {
    # force assign values to variables in tests

    #  vpc_cidr                = "10.0.0.0/16"
    #  public_subnet_cidr      = "10.0.1.0/24"
    #  private_subnet_cidr     = "10.0.2.0/24"
    #  availability_zone       = "us-east-1a"
  }

  # Check outputs
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
    error_message = "The private_subnet_id should not be empty."
  }
  assert { 
    condition = module.VPC.internet_gateway_id  != ""
    error_message = "The internet_gateway_id should not be empty."
  }
}

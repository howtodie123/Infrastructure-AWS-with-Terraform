provider "aws" {
  region = "us-east-1"  
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
  }

  # Check outputs
  assert {
    condition     = module.ec2.public_instance_id!= ""
    error_message = "The public_instance_id should not be empty."
  }

  assert {
    condition     = module.ec2.private_instance_id != ""
    error_message = "The private_instance_id should not be empty."
  }

  assert {
    condition     = module.ec2.public_instance_public_ip != ""
    error_message = "The public_subnet_id should not be empty."
  }

  assert {
    condition     = module.ec2.private_instance_private_ip != ""
    error_message = "The private_instance_private_ip should not be empty."
  }
}

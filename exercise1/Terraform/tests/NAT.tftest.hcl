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
    condition = module.NAT.nat_gateway_id != ""
    error_message = "The nat_gateway_id should not be empty."
  }
}
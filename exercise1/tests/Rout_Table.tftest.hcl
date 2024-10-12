
# provider "aws" {
#   region = "us-east-1"  # Edit according to your region
#   access_key = run.setup.access_key
#   secret_key = run.setup.secret_key
# }

# run "setup" {
#   module {
#     source = "./tests/setup"
#   }
# }

# # Run the tests
# run "unit_test" {
#   command = apply
  
#   variables {
#     # force assign values to variables in tests
#   }

#   # Check outputs
#   assert {
#         condition     = length(module.Route_Table.route_table_route_public) > 0
#         error_message = "The public route table should have at least one route."
#     }

#   assert {
#         condition     = length(module.Route_Table.route_table_route_private) > 0
#         error_message = "The private route table should have at least one route."
#     }

# #   assert {
# #         condition     = output.aws_route_public != ""
# #         error_message = "The public route ID should not be empty."
# #     }

# #   assert {
# #         condition     = output.aws_route_private != ""
# #         error_message = "The private route ID should not be empty."
# #     }

#   assert {
#         condition     = module.Route_Table.route_table_association_public != ""
#         error_message = "The public route table association ID should not be empty."
#     }

#   assert {
#         condition     = module.Route_Table.route_table_association_private != ""
#         error_message = "The private route table association ID should not be empty."
#     }

# }
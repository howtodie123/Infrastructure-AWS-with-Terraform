# Public Route Table
resource "aws_route_table" "public_route_table" {
    vpc_id = var.vpc_id  # ID of the VPC

    tags = {
        Name = "Public Route Table Group 6"
    }
}

# Route for Internet Access in Public Route Table / this can add into aws_route_table resource
resource "aws_route" "public_internet_access" {
    route_table_id = aws_route_table.public_route_table.id  # ID of the public route table
    destination_cidr_block = "0.0.0.0/0"  # Destination CIDR block for internet access
    gateway_id = var.gateway_id  # ID of the internet gateway
}

# Associate Public Subnet with Public Route Table
resource "aws_route_table_association" "public_association" {
    subnet_id = var.public_subnet_id  # ID of the public subnet
    route_table_id = aws_route_table.public_route_table.id  # ID of the public route table
}

# Private Route Table
resource "aws_route_table" "private_route_table" {
    vpc_id = var.vpc_id  # ID of the VPC

    tags = {
        Name = "Private Route Table Group 6"
    }
}

# Route for NAT Gateway in Private Route Table / this can add into aws_route_table resource
resource "aws_route" "private_nat_gateway" {
    route_table_id = aws_route_table.private_route_table.id  # ID of the private route table
    destination_cidr_block = "0.0.0.0/0"  # Destination CIDR block for NAT gateway
    nat_gateway_id = var.nat_gateway_id  # ID of the NAT gateway
}

# Associate Private Subnet with Private Route Table
resource "aws_route_table_association" "private_association" {
    subnet_id = var.private_subnet_id  # ID of the private subnet
    route_table_id = aws_route_table.private_route_table.id  # ID of the private route table
}

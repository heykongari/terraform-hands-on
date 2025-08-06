# Create a virtual private network.
resource "aws_vpc" "main" {
    cidr_block = var.vpc_cidr
    enable_dns_support = true
    enable_dns_hostnames = true
    tags = { Name = "local-vpc" }
}

# Create a public subnet within VPC.
resource "aws_subnet" "public" {
    vpc_id = aws_vpc.main.id
    cidr_block = var.subnet_cidr
    availability_zone = var.az
    map_public_ip_on_launch = true
    tags = { value = "public-subnet" }
}

# Enables internet access for resources in the public subnet.
resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.main.id
    tags = { Name = "igw" }
}

# Defines routing rules for public subnet.
resource "aws_route_table" "public" {
    vpc_id = aws_vpc.main.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
    tags = { Name = "public-route" }
}

# Associates the public subnet with the public route table so traffic can flow through the Internet Gateway.
resource "aws_route_table_association" "public" {
    subnet_id = aws_subnet.public.id
    route_table_id = aws_route_table.public.id
}
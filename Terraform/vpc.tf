# Tạo VPC
resource "aws_vpc" "main_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "my_vpc"
  }
}

# Tạo Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "my_igw"
  }
}

# Tạo Public Subnet
resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = var.public_subnet_cidr
  availability_zone = "ap-southeast-2a"

  map_public_ip_on_launch = true

  tags = {
    Name = "public_subnet"
  }
}

# Tạo Private Subnet
resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = var.private_subnet_cidr
  availability_zone = "ap-southeast-2a"

  map_public_ip_on_launch = false

  tags = {
    Name = "private_subnet"
  }
}

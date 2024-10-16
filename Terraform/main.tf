provider "aws" {
  region = "ap-southeast-2"
}

/*
resource "aws_instance" "instance1" {
  ami           = "ami-0f71013b2c8bd2c29"
  instance_type = "t2.micro"

  tags = {
    name = "my-demo-instance"
  }
}

*/
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
  cidr_block        = "10.0.1.0/24"
  availability_zone = "ap-southeast-2a" # Chọn Availability Zone hợp lệ

  map_public_ip_on_launch = true # Đảm bảo cấp IP công cộng cho Public Subnet

  tags = {
    Name = "public_subnet"
  }
}

# Tạo Route Table cho Public Subnet
resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public_rt"
  }
}

# Gán Route Table cho Public Subnet
resource "aws_route_table_association" "public_association" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

# Tạo Elastic IP cho NAT Gateway
resource "aws_eip" "nat_eip" {
  vpc = true
}

# Tạo NAT Gateway cho Private Subnet (tạo trong Public Subnet)
resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_eip.id
  subnet_id     = aws_subnet.public_subnet.id

  tags = {
    Name = "nat_gateway"
  }
}

# Tạo Private Subnet
resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.main_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "ap-southeast-2a"

  map_public_ip_on_launch = false # Không cấp IP công cộng cho Private Subnet

  tags = {
    Name = "private_subnet"
  }
}

# Tạo Route Table cho Private Subnet (với NAT Gateway)
resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.main_vpc.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }

  tags = {
    Name = "private_rt"
  }
}

# Gán Route Table cho Private Subnet
resource "aws_route_table_association" "private_association" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_rt.id
}

# Tạo Security Group mặc định cho VPC
resource "aws_security_group" "default_sg" {
  vpc_id = aws_vpc.main_vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "default_sg"
  }
}

# Tạo Security Group cho Public EC2 instance
resource "aws_security_group" "public_ec2_sg" {
  vpc_id = aws_vpc.main_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["116.110.40.132/32"] # Thay bằng địa chỉ IP của bạn
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "public_ec2_sg"
  }
}

# Tạo Security Group cho Private EC2 instance
resource "aws_security_group" "private_ec2_sg" {
  vpc_id = aws_vpc.main_vpc.id

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.public_ec2_sg.id] # Chỉ cho phép kết nối từ Public EC2 instance
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "private_ec2_sg"
  }
}

# Tạo Public EC2 Instance
resource "aws_instance" "public_ec2" {
  ami             = "ami-0f71013b2c8bd2c29" # Thay bằng AMI hợp lệ
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.public_subnet.id
  security_groups = [aws_security_group.public_ec2_sg.id]

  tags = {
    Name = "public_ec2_instance"
  }
}

# Tạo Private EC2 Instance
resource "aws_instance" "private_ec2" {
  ami             = "ami-0f71013b2c8bd2c29" # Thay bằng AMI hợp lệ
  instance_type   = "t2.micro"
  subnet_id       = aws_subnet.private_subnet.id
  security_groups = [aws_security_group.private_ec2_sg.id]

  tags = {
    Name = "private_ec2_instance"
  }
}
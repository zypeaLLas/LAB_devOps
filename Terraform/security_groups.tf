# Tạo Security Group cho Public EC2 instance
resource "aws_security_group" "public_ec2_sg" {
  vpc_id = aws_vpc.main_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["192.168.137.1/32"] #Chỉ cho phép ip cụ thể truy cập vào máy public ec2
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
    cidr_blocks =[aws_instance.public_ec2.public_ip] #chỉ cho public ec2 truy cập vào 
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

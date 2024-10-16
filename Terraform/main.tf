provider "aws" {
  region = "ap-southeast-2"
}

resource "aws_instance" "instance1" {
  ami           = "ami-0f71013b2c8bd2c29"
  instance_type = "t2.micro"

  tags = {
    name = "my-demo-instance"
  }
}
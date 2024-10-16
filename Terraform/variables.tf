variable "aws_region" {
  default = "ap-southeast-2"
}

variable "public_subnet_cidr" {
  default = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  default = "10.0.2.0/24"
}

variable "ami_id" {
  default = "ami-0f71013b2c8bd2c29"
}

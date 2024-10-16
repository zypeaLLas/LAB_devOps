variable "region" {
  description = "The AWS region to deploy resources"
  default     = "ap-southeast-2"
}

variable "public_subnet_cidr" {
  description = "CIDR block for public subnet"
  default     = "10.0.1.0/24"
}

variable "private_subnet_cidr" {
  description = "CIDR block for private subnet"
  default     = "10.0.2.0/24"
}

variable "ami" {
  description = "AMI ID for EC2 instances"
  default     = "ami-0f71013b2c8bd2c29"
}

output "vpc_id" {
  value = aws_vpc.main_vpc.id
}

output "public_subnet_id" {
  value = aws_subnet.public_subnet.id
}

output "public_ec2_instance_id" {
  value = aws_instance.public_ec2.id
}

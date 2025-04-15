output "vpc_id" {
  value = aws_vpc.tf_vpc.id
}

output "public_subnet_01" {
  value = aws_subnet.tf_subnet_public_01.id
}

output "public_subnet_02" {
  value = aws_subnet.tf_subnet_public_02.id
}

output "private_subnet_01" {
  value = aws_subnet.tf_subnet_private_01.id
}

output "private_subnet_02" {
  value = aws_subnet.tf_subnet_private_02.id
}
output "private_subnet_03" {
  value = aws_subnet.tf_subnet_private_03.id
}

output "private_subnet_04" {
  value = aws_subnet.tf_subnet_private_04.id
}

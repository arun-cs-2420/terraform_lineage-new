output "rds_endpoint" {
  value = aws_db_instance.tf_db_instance.endpoint
}
output "rds_writer_endpoint" {
  value = aws_db_instance.tf_db_instance.endpoint
}
output "rds_username" {
  value = aws_db_instance.tf_db_instance.username
}
output "rds_password" {
  value = aws_db_instance.tf_db_instance.password
}

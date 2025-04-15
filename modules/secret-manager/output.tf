output "secret_manager_arn" {
  description = "ARN of the created secret"
  value       = aws_secretsmanager_secret.lineagedb_connection_string.arn
}
output "secret_name" {
  value       = aws_secretsmanager_secret.lineagedb_connection_string.name
  description = "Name of the created secret"
}
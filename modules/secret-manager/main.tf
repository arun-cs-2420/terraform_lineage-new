# Define local variables
locals {
  secret_name = "${var.project_name}-${var.project_region}-${var.project_environment}-lineagedb-connection"
}

# Create the secret with a unique name
resource "aws_secretsmanager_secret" "lineagedb_connection_string" {
  name_prefix         = "${local.secret_name}-"
  description         = "Secret for Lineage DB connection string"
  recovery_window_in_days = 0

  lifecycle {
    create_before_destroy = true
  }

}

# Create the secret version
resource "aws_secretsmanager_secret_version" "lineagedb_connection_string_value" {
  secret_id     = aws_secretsmanager_secret.lineagedb_connection_string.id
  secret_string = var.secret_string

  lifecycle {
    create_before_destroy = true
  }
}

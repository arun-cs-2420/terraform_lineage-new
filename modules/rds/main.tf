# Random string to use as master password unless one is specified
resource "random_password" "master_password_rds" {
  length  = 16
  special = false
}

data "aws_availability_zones" "tf_availability_zones" {
  state = "available"
}

locals {
  common_tags = var.tags
}

# RDS Security Group
resource "aws_security_group" "tf_security_group" {
  name   = "${var.project_name}-${var.project_region}-${var.project_environment}-rds-sg"
  vpc_id = var.vpc_id

  tags = merge(
    local.common_tags,
    tomap({
      "Name" = "${var.project_name}-${var.project_region}-${var.project_environment}-rds-sg"
    })
  )

  ingress {
    description = "VPN Security"
    from_port   = 5432 # Changed to PostgreSQL Port
    to_port     = 5432
    protocol    = "TCP"
    cidr_blocks = [var.network_cidr]
  }
}

# Fix: Add subnets from at least two AZs
resource "aws_db_subnet_group" "tf_db_subnet_group" {
  name       = "${var.project_name}-${var.project_region}-${var.project_environment}-rds-subnet-group"
  subnet_ids = [var.private_subnet_03, var.private_subnet_04] 

  tags = merge(
    local.common_tags,
    {
      Name = "${var.project_name}-${var.project_region}-${var.project_environment}-rds_subnet_group"
    }
  )
}


# --- KMS Key for Encryption ---
resource "aws_kms_key" "rds_key" {
  description             = "KMS key for encrypting RDS"
  deletion_window_in_days = 7
 
  tags = {
    Name = "rds-encryption-key"
  }
}

# RDS Instance
resource "aws_db_instance" "tf_db_instance" {
  identifier                = "${var.project_name}-${var.project_environment}-rds-instance"
  engine                    = var.rdsProperty["ENGINE"]
  engine_version            = var.rdsProperty["ENGINE_VERSION"]
  instance_class            = var.rdsProperty["INSTANCE_CLASS"]
  allocated_storage         = var.rdsProperty["ALLOCATED_STORAGE"]
  storage_type              = var.rdsProperty["STORAGE_TYPE"]
  max_allocated_storage     = var.rdsProperty["MAX_ALLOCATED_STORAGE"]
  backup_retention_period   = var.rdsProperty["BACKUP_RETENTION_PERIOD"]
  backup_window             = var.rdsProperty["BACKUP_WINDOW"]
  maintenance_window        = var.rdsProperty["MAINTENANCE_WINDOW"]
  auto_minor_version_upgrade = var.rdsProperty["AUTO_MINOR_VERSION_UPGRADE"]
  skip_final_snapshot       = var.rdsProperty["SKIP_FINAL_SNAPSHOT"]
  publicly_accessible       = false
  db_subnet_group_name      = aws_db_subnet_group.tf_db_subnet_group.name
  vpc_security_group_ids    = [aws_security_group.tf_security_group.id]
  deletion_protection       = var.rdsProperty["DELETION_PROTECTION"]
  apply_immediately         = true


  username  = var.rdsProperty["USERNAME"]
  password  = random_password.master_password_rds.result
  db_name   = var.rdsProperty["DATABASE_NAME"]

  parameter_group_name = aws_db_parameter_group.tf_db_parameter_group.name
# Enable Encryption at Rest
  storage_encrypted = true
  kms_key_id        = aws_kms_key.rds_key.arn
 
  tags = merge(
    local.common_tags,
    tomap({
      "Name" = "${var.project_name}-${var.project_environment}-db-instance"
    })
  )

  enabled_cloudwatch_logs_exports = ["postgresql", "upgrade"]
}

# Fix: Remove MySQL-specific parameters and use valid PostgreSQL parameters
resource "aws_db_parameter_group" "tf_db_parameter_group" {
  name        = "${var.project_name}-${var.project_environment}-rds-instance-pg"
  description = "${var.project_name}-${var.project_environment}-rds-instance-pg"
  family      = var.rdsProperty["parameterGroupFamily"]

  parameter {
    apply_method = "immediate"
    name         = "log_min_duration_statement"
    value        = 1000  # Logs queries longer than 1 second
  }

  parameter {
    apply_method = "immediate"
    name         = "log_statement"
    value        = "all"
  }

  parameter {
    apply_method = "immediate"
    name         = "log_connections"
    value        = "1"
  }

  tags = merge(
    local.common_tags, 
    {
      "Name" = "${var.project_name}-${var.project_environment}-postgres-Database-RDS"
    }
  )
}

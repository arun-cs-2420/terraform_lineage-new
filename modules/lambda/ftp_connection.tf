

resource "aws_security_group" "tf_security_group_ftp_connection_sg" {
  name   = "${var.project_name}-${var.project_region}-${var.project_environment}-ftp_connection_lambda_sg"
  vpc_id = var.vpc_id

  tags = merge(
    local.common_tags, {"Name"="${var.project_name}-${var.project_region}-${var.project_environment}_ftp_connection_lambda_sg"}
  )

  ingress {
    description = "TCP access"
    protocol = -1
    to_port  = 0
    from_port = 0
    cidr_blocks = ["10.0.0.0/20"]
  }   
  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  } 
}
resource "aws_lambda_function" "ftp_connection_lambda" {
  filename      = "${path.module}/code/ftp_connection_lambda.zip"
  function_name = "${var.project_name}-${var.project_region}-${var.project_environment}-file-connection-lambda_function"
  role          = aws_iam_role.tf_lambda_role_ftp_connection.arn  # Use the role we create
  handler       = "index.handler"
  runtime       = "nodejs18.x"
  timeout       = var.timeout_file_connection
  memory_size   = var.memory_file_connection

 
 environment {
    variables = {
     
      SnsTopicArn          = var.sns_topic_arn
      SqsQueueUrl          = var.lineage_sqs-url
      rds_endpoint         = var.rds_endpoint
    }
  }

 vpc_config {
    subnet_ids         = ["${var.private_subnet_01}", "${var.private_subnet_02}"]
    security_group_ids = [aws_security_group.tf_security_group_ftp_connection_sg.id]
  }

  tags = var.tags
}
resource "aws_cloudwatch_log_group" "Log_ftp_connection" {
  name              = "/aws/lambda/${var.project_name}-${var.project_region}-${var.project_environment}_ftp_connection"
  retention_in_days = var.retention_in_days_ftp_connection
}
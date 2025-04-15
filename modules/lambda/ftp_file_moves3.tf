resource "aws_security_group" "ftp_file_move_lambda_sg" {
  name   = "${var.project_name}-${var.project_region}-${var.project_environment}-ftp_file_move_lambda_sg"
  vpc_id = var.vpc_id

  ingress {
    description = "Allow all inbound traffic within the VPC CIDR"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.0.0.0/20"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.project_name}-${var.project_region}-${var.project_environment}-ftp_file_move_lambda_sg"
  }
}

resource "aws_lambda_function" "ftp_file_move_lambda" {
  function_name = "${var.project_name}-${var.project_region}-${var.project_environment}_file_connection_lambda"
lifecycle {
    create_before_destroy = true
  }
  description   = "Lambda function to move files from FTP server to S3 and send notifications"
  role          ="arn:aws:iam::${var.account_id}:role/${var.project_name}-${var.project_region}-${var.project_environment}-ftp-file-move-role"
  handler       = "ftpFileMoveS3::ftpFileMoveS3.Function::FunctionHandler"
  runtime       = "dotnet8"
  timeout       = var.timeout_ftp_file_move_s3_lambda
  memory_size   = var.memory_size_ftp_file_move_s3_lambda
  filename      = "${path.module}/code/ftpFileMoveS3.zip"

 environment {
    variables = {
      AWSAccessKeyId      = var.AWSAccessKeyId
      AWSSecretKey        = var.AWSSecretKey
      SnsTmsTopicArn       = var.sns_file
     //SnsWmsTopicArn       = var.sns_topic_arn
      SqsQueueUrl         = var.lineage_sqs-url
      bucket_name         = var.dms-s3Bucket_name
      rds_endpoint         = var.rds_endpoint
      s3DesinationFolder  = var.s3_destination_folder
      s3folder            = var.s3folder
    }
  }

  vpc_config {
    subnet_ids         = [var.private_subnet_01, var.private_subnet_02]
    security_group_ids = [aws_security_group.ftp_file_move_lambda_sg.id]
  }

  tags = var.tags
}

resource "aws_lambda_event_source_mapping" "event_source_mapping_ftp_file_move_s3" {
  event_source_arn = var.sqs_queue_arn_file
  enabled          = true
  function_name    = aws_lambda_function.ftp_file_move_lambda.arn
  batch_size       = var.batch_size_ftp_file_move_s3_lambda
}

resource "aws_cloudwatch_log_group" "log_ftp_file_move_s3" {
  name              = "/aws/lambda/${var.project_name}-${var.project_region}-${var.project_environment}_ftp_file_move_s3"
  retention_in_days = var.retention_in_days_ftp_file_move_s3
}
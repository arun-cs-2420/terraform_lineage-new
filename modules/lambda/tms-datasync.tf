resource "aws_security_group" "tf_security_group_tms-datasync" {
  name   = "${var.project_name}-${var.project_region}-${var.project_environment}_tms_datasync_lambda_sg"
  vpc_id = var.vpc_id

  tags = merge(
    local.common_tags, {"Name"="${var.project_name}-${var.project_region}-${var.project_environment}-tms_extraction_lambda_sg"}
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
resource "aws_s3_object" "lambda_tms_datasync_code" {
  bucket = var.dms-s3Bucket_name
  key    = "lambda/lin-aps-dev-tms-datasync.zip"
  source = "${path.module}/code/lin-aps-dev-tms-datasync.zip"
  etag   = filemd5("${path.module}/code/lin-aps-dev-tms-datasync.zip")
   lifecycle {
    create_before_destroy = true
  }
}



resource "aws_lambda_function" "tms_datasync" {
  function_name = "${var.project_name}-${var.project_region}-${var.project_environment}_tms_datasync"
  description   = var.lambda_description
  //filename      = "${path.module}/code/lin-aps-dev-tms-datasync.zip"
  role          = aws_iam_role.tf_lambda_role_tms_datasync.arn
  handler       = "Lineage.DMS.TMS.DataSync::Lineage.DMS.TMS.DataSync.Function::FunctionHandler"
  runtime       = "dotnet8"
  memory_size   = var.memory_size_tms_datasync
  timeout       = var.timeout_tms_datasync
 
  vpc_config {
    subnet_ids         = ["${var.private_subnet_01}", "${var.private_subnet_02}"]
    security_group_ids = [aws_security_group.tf_security_group_tms-datasync.id]
  }

  s3_bucket     = var.dms-s3Bucket_name
  s3_key        = "lambda/lin-aps-dev-tms-datasync.zip"  # Add the S3 key for your Lambda code
 
depends_on = [
    aws_s3_object.lambda_tms_datasync_code
  ]
  environment {
    variables = {
      TMSDataSyncFailureTopicArn = var.sns_email_topic_arn
    }
  }

  
  dead_letter_config {
    target_arn = "arn:aws:sqs:${var.aws_region}:${var.account_id}:lin-aps-dev-tms-datasync-dlq"
  }

  lifecycle {
    ignore_changes = [last_modified, source_code_hash]
  }

}

resource "aws_lambda_permission" "allow_s3_trigger" {
  statement_id  = "AllowExecutionFromS3"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.tms_datasync.function_name
  principal     = "s3.amazonaws.com"
  source_arn    = "arn:aws:s3:::${var.dms-s3Bucket_name}"

  
}
resource "aws_s3_bucket_notification" "trigger_lambda" {
  bucket = var.dms-s3Bucket_name

  lambda_function {
    lambda_function_arn = aws_lambda_function.tms_datasync.arn
    events              = ["s3:ObjectCreated:*"]
  }

  depends_on = [aws_lambda_permission.allow_s3_trigger]
 
 
}
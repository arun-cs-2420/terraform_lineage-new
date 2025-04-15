/*resource "aws_security_group" "tf_security_group_wms_datasync" {
  name   = "${var.project_name}-${var.project_region}-${var.project_environment}-wms_datasync_lambda_sg"
  vpc_id = var.vpc_id

  tags = merge(
    local.common_tags, {
      Name = "${var.project_name}-${var.project_region}-${var.project_environment}-wms_datasync_lambda_sg"
    }
  )

  ingress {
    description = "Allow all traffic from internal CIDR"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["10.1.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_s3_object" "lambda_wms_datasync_code" {
  bucket = var.dms-s3Bucket_name 
  key    = "lambda/lin-aps-dev-wms-datasync.zip"
  source = "${path.module}/code/lin-aps-dev-wms-datasync.zip"
  etag   = filemd5("${path.module}/code/lin-aps-dev-wms-datasync.zip")

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lambda_function" "wms_datasync" {
  function_name = "${var.project_name}-${var.project_region}-${var.project_environment}-wms-datasync-lambda"
  description   = var.lambda_description
  role          = aws_iam_role.tf_lambda_role_wms_datasync.arn
  handler       = "Lineage.DMS.WMS.DataSync::Lineage.DMS.WMS.DataSync.Function::FunctionHandler"
  runtime       = "dotnet8"
  memory_size   = var.memory_size_wms_datasync
  timeout       = var.timeout_wms_datasync

  vpc_config {
    subnet_ids         = [var.private_subnet_01, var.private_subnet_02]
    security_group_ids = [aws_security_group.tf_security_group_wms_datasync.id]
  }

  s3_bucket = var.dms-s3Bucket_name 
  s3_key    = "lambda/lin-aps-dev-wms-datasync.zip"

  environment {
    variables = {
      WMSDataSyncFailureTopicArn = var.WMSDataSyncFailureTopicArn_wms_datasync
    }
  }

  dead_letter_config {
    target_arn = var.tms_dlq_queue_arn
  }

  lifecycle {
    ignore_changes = [last_modified, source_code_hash]
  }

  depends_on = [aws_s3_object.lambda_wms_datasync_code]
}

resource "aws_s3_bucket_notification" "trigger_lambda_wms" {
  bucket = var.dms_s3Bucket_name

  lambda_function {
    lambda_function_arn = aws_lambda_function.wms_datasync.arn
    events              = ["s3:ObjectCreated:*"]
    filter_prefix       = "wms/"
    filter_suffix       = ".csv"
  }

  depends_on = [
    aws_lambda_permission.allow_s3_trigger_wms_datasync
  ]
} */
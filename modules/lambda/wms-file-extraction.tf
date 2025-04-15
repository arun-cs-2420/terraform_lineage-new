
resource "aws_security_group" "tf_security_group_wms_file_extraction_msg" {
  name   = "${var.project_name}-${var.project_region}-${var.project_environment}_wms_file_extraction_msg-sg"
  vpc_id = var.vpc_id

  tags = merge(
    local.common_tags, {"Name"="${var.project_name}-${var.project_region}-${var.project_environment}_wms_file_extraction_msg-sg"}
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

resource "aws_lambda_function" "tf_lambda_function_wms_file_extraction_msg" {
  function_name                  = "${var.project_name}-${var.project_region}-${var.project_environment}_wms_file_extraction_msg-lambda"
  filename                       = "${path.module}/code/lin-aps-dev-wms-file-extraction-msg-lambda.zip"
  handler                        = "LambdaSqsMsgReceiver::LambdaSqsMsgReceiver.Function::FunctionHandler"
  runtime                        = "dotnet8"
  role                           = aws_iam_role.tf_lambda_role_file_extraction_msg.arn
  depends_on                     = [aws_iam_role_policy_attachment.attach_iam_policy_to_iam_role_file-extraction-msg]

  vpc_config {
    subnet_ids         = ["${var.private_subnet_01}", "${var.private_subnet_02}"]
    security_group_ids = [aws_security_group.tf_security_group_wms_file_extraction_msg.id]
  }

  timeout = var.timeout_wms_file_extraction_msg_lambda
  memory_size = var.memory_size_wms_file_extraction_msg_lambda

  ephemeral_storage {
    size = var.size_wms_file_extraction_msg_lambda # Min 512 MB and the Max 10240 MB
  }

  environment {
    variables = {
      TMSDataExtractionFailureTopicArn = var.sns_email_topic_arn
      LineageDmsDataExtractionApiUrl   = var.LineageDmsDataExtractionApiUrl 
    }
  }

  dead_letter_config {
    target_arn = var.data_extract_fail_dlq_arn
  }
}

resource "aws_lambda_event_source_mapping" "event_source_mapping_wms_file_extraction_msg" {
  event_source_arn = var.sqs_queue_arn_file
  enabled          = true
  function_name    = "${aws_lambda_function.tf_lambda_function_wms_file_extraction_msg.arn}"
  batch_size       = var.batch_size_wms_file_extraction_msg_lambda
}

resource "aws_lambda_function_event_invoke_config" "wms_file_extraction_msg_lambda_dest" {
  function_name                      = aws_lambda_function.tf_lambda_function_wms_file_extraction_msg.function_name
  maximum_retry_attempts            = var.maximum_retry_attempts_wms_file_extraction_msg_lambda
  maximum_event_age_in_seconds      = var.maximum_event_age_in_seconds_wms_file_extraction_msg_lambda

  destination_config {
    on_failure {
      destination = var.data_extract_fail_dlq_arn
    }
  }
}

//resource "aws_cloudwatch_log_group" "Log_wms_file_extraction_msg" {
//name              = "/aws/lambda/${var.project_name}-${var.project_region}-${var.project_environment}-file-extraction-msg"
//retention_in_days = var.retention_in_days_wms_file_extraction_msg_lambda
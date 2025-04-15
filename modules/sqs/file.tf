
# SQS Queue
resource "aws_sqs_queue" "sqs_queue_file" {
  name                      =  "${var.project_name}-${var.project_region}-${var.project_environment}-file-sqs"
  visibility_timeout_seconds = var.visibility_timeout_file
  message_retention_seconds = var.message_retention_file
  max_message_size         = var.max_message_size_file
  delay_seconds          = var.delivery_delay_file
  //visibility_timeout_seconds = 900  # 15 minutes
  //message_retention_seconds = 345600  # 4 days
  //max_message_size          = 262144  # 256 KB
  //delay_seconds             = 0
  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.data_extract_fail_dlq.arn
    maxReceiveCount     = var.max_receive_count_file
  })
}

# SQS Queue Policy
resource "aws_sqs_queue_policy" "sqs_queue_policy" {
  queue_url = aws_sqs_queue.sqs_queue_file.id
  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "__default_policy_ID"
    Statement = [
      {
        Sid       = "Stmt1596186812579"
        Effect    = "Allow"
        Principal = {
          Service = "sns.amazonaws.com"
        }
        Action   = [
          "sqs:SendMessage",
          "sqs:SendMessageBatch"
        ]
        Resource = aws_sqs_queue.sqs_queue_file.arn
      }
    ]
  })
}
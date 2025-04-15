resource "aws_sqs_queue" "sqs_queue-datasync_dlq" {
  name                      = "${var.project_name}-${var.project_region}-${var.project_environment}-datasync_dlq"
  visibility_timeout_seconds= var.visibility_timeout-datasync_dlq
  message_retention_seconds = var.message_retention-datasync_dlq
  max_message_size          = var.max_message_size-datasync_dlq
  delay_seconds             = var.delivery_delay-datasync_dlq
  tags                      = var.tags
}

resource "aws_sqs_queue_policy" "sqs_policy-datasync_dlq" {
  queue_url = aws_sqs_queue.sqs_queue-datasync_dlq.id
  policy    = jsonencode({
    Version = "2012-10-17",
    Id      = "__default_policy_ID",
    Statement = [
      {
        Sid       = "__owner_statement",
        Effect    = "Allow",
        Principal = { AWS = "arn:aws:iam::597088035727:root" },
        Action    = "SQS:*",
        Resource  = aws_sqs_queue.sqs_queue-datasync_dlq.arn
      }
    ]
  })
}

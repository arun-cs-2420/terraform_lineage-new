
 resource "aws_sqs_queue" "lineage_sqs" {
  name                      = "${var.project_name}-${var.project_region}-${var.project_environment}-ftpdev.fifo"
  fifo_queue                = true
  visibility_timeout_seconds = var.visibility_timeout
  message_retention_seconds = var.message_retention
  max_message_size          = var.max_message_size
  delay_seconds             = var.delivery_delay

  
  tags = var.tags
}

resource "aws_sqs_queue_policy" "sqs_policy" {
  queue_url = aws_sqs_queue.lineage_sqs.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "Allow-SNS-to-send-messages"
        Effect    = "Allow"
        Principal = { Service = "sns.amazonaws.com" }
        Action    = "SQS:SendMessage"
        Resource  = aws_sqs_queue.lineage_sqs.arn
        Condition = {
          ArnEquals = {
            "aws:SourceArn" = var.sns_topic_arn
          }
        }
      }
    ]
  })
}

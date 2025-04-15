resource "aws_sqs_queue" "data_extract_fail_dlq" {
  name                       = "${var.project_name}-${var.project_region}-${var.project_environment}-tms-data-extract-fail-dlq-dev"
  visibility_timeout_seconds  = var.visibility_timeout_dlq
  message_retention_seconds   = var.message_retention_dlq
  max_message_size            = var.max_message_size_dlq
  delay_seconds               = var.delay_seconds_dlq
}

# SQS Queue Policy
resource "aws_sqs_queue_policy" "data_extract_fail_dlq_policy" {
  queue_url = aws_sqs_queue.data_extract_fail_dlq.id
  policy    = <<POLICY
{
  "Version": "2012-10-17",
  "Id": "__default_policy_ID",
  "Statement": [
    {
      "Sid": "__owner_statement",
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::597088035727:root"
      },
      "Action": "SQS:*",
      "Resource": "${aws_sqs_queue.data_extract_fail_dlq.arn}"
    }
  ]
}
POLICY
}

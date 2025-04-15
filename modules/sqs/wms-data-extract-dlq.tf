resource "aws_sqs_queue" "wms_data_extract_fail_dlq" {
  name                       = "${var.project_name}-${var.project_region}-${var.project_environment}-wms-data-extract-fail-dlq"
  visibility_timeout_seconds = var.visibility_timeout_wms_dlq
  message_retention_seconds  = var.message_retention_wms_dlq
  max_message_size           = var.max_message_size_wms_dlq
  delay_seconds              = var.delay_seconds_wms_dlq

}

  # SQS Queue Policy
resource "aws_sqs_queue_policy" "wms_data_extract_fail_dlq_policy" {
  queue_url = aws_sqs_queue.wms_data_extract_fail_dlq.id
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
      "Resource": "${aws_sqs_queue.wms_data_extract_fail_dlq.arn}"
    }
  ]
}
POLICY
}
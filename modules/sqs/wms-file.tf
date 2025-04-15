resource "aws_sqs_queue" "wms_file_queue" {
  name                       = "${var.project_name}-${var.project_region}-${var.project_environment}-wms-file-sqs"
  visibility_timeout_seconds = var.visibility_timeout_wms_file
  message_retention_seconds  = var.message_retention_wms_file
  max_message_size           = var.max_message_size_wms_file
  delay_seconds              = var.delay_seconds_wms_file

}

  # SQS Queue Policy
resource "aws_sqs_queue_policy" "wms_file_queue_policy" {
  queue_url = aws_sqs_queue.wms_file_queue.id
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
      "Resource": "${aws_sqs_queue.wms_file_queue.arn}"
    }
  ]
}
POLICY
}

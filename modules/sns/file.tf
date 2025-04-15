resource "aws_sns_topic" "sns_topic_file" {
  name                     = "${var.project_name}-${var.project_region}-${var.project_environment}-lin-aps-dev-file-in-bucket-topic"
}

resource "aws_sns_topic_policy" "sns_topic_policy_file" {
  arn = aws_sns_topic.sns_topic_file.arn
  policy = jsonencode({
    Version = "2012-10-17"
    Id      = "example-ID"
    Statement = [
      {
        Sid    = "S3PublishPermission"
        Effect = "Allow"
        Principal = {
          Service = "s3.amazonaws.com"
        }
        Action   = "SNS:Publish"
        Resource = aws_sns_topic.sns_topic_file.arn
        Condition = {
          StringEquals = {
            "aws:SourceAccount" = var.account_id
          }
          ArnLike = {
            "aws:SourceArn" = "arn:aws:s3:::${var.dms-s3Bucket_name}"
          }
        }
      }
    ]
  })
}

resource "aws_sns_topic_subscription" "sns_subscription_file" {
  topic_arn = aws_sns_topic.sns_topic_file.arn
  protocol  = "sqs"
  endpoint  = var.sqs_queue_arn_file
}


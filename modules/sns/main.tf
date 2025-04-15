

# Create SNS FIFO Topic
resource "aws_sns_topic" "fifo_sns_topic" {
  name                     = "${var.project_name}-${var.project_region}-${var.project_environment}-lin-aps-dev-ftp-file-topic.fifo"
  fifo_topic               = true
  content_based_deduplication = true
}

# SNS Topic Policy
resource "aws_sns_topic_policy" "sns_policy" {
  arn = aws_sns_topic.fifo_sns_topic.arn

  policy = jsonencode({
    Version = "2008-10-17"
    Id      = "__default_policy_ID"
    Statement = [
      {
        Sid       = "__default_statement_ID"
        Effect    = "Allow"
        Principal = { "AWS" = "*" }
        Action = [
          "SNS:Publish",
          "SNS:RemovePermission",
          "SNS:SetTopicAttributes",
          "SNS:DeleteTopic",
          "SNS:ListSubscriptionsByTopic",
          "SNS:GetTopicAttributes",
          "SNS:AddPermission",
          "SNS:Subscribe"
        ]
        Resource = aws_sns_topic.fifo_sns_topic.arn
        Condition = {
          StringEquals = {
            "AWS:SourceOwner" = "*****123"
          }
        }
      }
    ]
  })
}
# SQS Subscription
resource "aws_sns_topic_subscription" "sqs_subscription" {
 topic_arn = aws_sns_topic.fifo_sns_topic.arn
protocol  = "sqs"
 endpoint  = var.sqs_queue_arn
}
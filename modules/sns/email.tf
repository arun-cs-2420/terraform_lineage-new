resource "aws_sns_topic" "email_topic" {
    name       = "${var.project_name}-${var.project_region}-${var.project_environment}-lin-aps-dev-email-topic"
    fifo_topic = false
}

resource "aws_sns_topic_policy" "email_topic_policy" {
  arn        = aws_sns_topic.email_topic.arn
  policy     = jsonencode({
    Version  = "2008-10-17"
    Id       = "__default_policy_ID"
    Statement= [
      {
        Sid        = "__default_statement_ID"
        Effect     = "Allow"
        Principal  = {
               AWS = "*"
        }
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
        Resource       = aws_sns_topic.email_topic.arn
        Condition      = {
          StringEquals = {
            "AWS:SourceOwner" = "597088035727"
          }
        }
      }
    ]
  })
}

resource "aws_sns_topic_subscription" "email_subscription" {
  topic_arn = aws_sns_topic.email_topic.arn
  protocol  = "email"
  endpoint  = trimspace(var.email)
  
  lifecycle {
    ignore_changes = [
      confirmation_timeout_in_minutes,
      pending_confirmation,
      raw_message_delivery,
      filter_policy
    ]
    create_before_destroy = true
  }
}

resource "aws_sns_topic_subscription" "filtered_email_subscription" {
  count     = var.create_filtered_subscription ? 1 : 0
  topic_arn = aws_sns_topic.email_topic.arn
  protocol  = "email"
  endpoint  = trimspace(var.email)
  
  lifecycle {
    ignore_changes = [
      confirmation_timeout_in_minutes,
      pending_confirmation,
      raw_message_delivery
    ]
    prevent_destroy = true
  }

  filter_policy = jsonencode({
    EventType = [
      "WMSDataSyncFailEmail",
      "TMSDataSyncFailEmail",
      "TMSDataExtractionFailEmail",
      "WMSDataExtractionFailEmail"
    ]
  })
}



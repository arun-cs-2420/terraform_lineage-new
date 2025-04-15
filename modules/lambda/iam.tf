#main
resource "aws_iam_role" "tf_lambda_role_file_extraction_msg" {
name   = "${var.project_name}-${var.project_region}-${var.project_environment}-file-extraction-msg-role"
assume_role_policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Action": "sts:AssumeRole",
     "Principal": {
     "Service": "lambda.amazonaws.com"
    },
     "Effect": "Allow",
     "Sid": ""
   }
 ]
}
EOF
}
resource "aws_iam_policy" "iam_policy_for_file_extraction_msg" {
name         = "${var.project_name}-${var.project_region}-${var.project_environment}-file-extraction-msg-policy"
 path         = "/"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowLambdaBasicExecution"
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "*"
      },
      {
        Sid    = "AllowVPCAccess"
        Effect = "Allow"
        Action = [
          "ec2:CreateNetworkInterface",
          "ec2:DescribeNetworkInterfaces",
          "ec2:DeleteNetworkInterface",
          "ec2:AssignPrivateIpAddresses",
          "ec2:UnassignPrivateIpAddresses"
        ]
        Resource = "*"
      },
      {
        Sid    = "AllowSQSAccess"
        Effect = "Allow"
        Action = [
          "sqs:SendMessage",
          "sqs:GetQueueUrl",
          "sqs:GetQueueAttributes",
          "sqs:ReceiveMessage",
          "sqs:DeleteMessage",
          "sqs:ChangeMessageVisibility",
          "sqs:DeleteMessageBatch",
          "sqs:GetQueueAttributes",
          "sqs:ListQueues",
          "sqs:ListQueueTags"
        ]
        Resource = [
          "${var.sqs_queue_arn_file}",
          "${var.data_extract_fail_dlq_arn}"
        ]
      },
      {
        Sid    = "AllowS3Access"
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:ListBucket"
        ]
        Resource = [
          "arn:aws:s3:::${var.dms-s3Bucket_name}",
          "arn:aws:s3:::${var.dms-s3Bucket_name}/*"
        ]
      }
    ]
  })
}
resource "aws_iam_role_policy_attachment" "attach_iam_policy_to_iam_role_file-extraction-msg" {
 role        = aws_iam_role.tf_lambda_role_file_extraction_msg.name
 policy_arn  = aws_iam_policy.iam_policy_for_file_extraction_msg.arn

}

//wms-file-extract

resource "aws_iam_role" "tf_lambda_role_wms_extraction" {
name   = "${var.project_name}-${var.project_region}-${var.project_environment}-wms-extraction-role"
assume_role_policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Action": "sts:AssumeRole",
     "Principal": {
     "Service": "lambda.amazonaws.com"
    },
     "Effect": "Allow",
     "Sid": ""
   }
 ]
}
EOF
}
resource "aws_iam_policy" "iam_policy_for_wms_extraction" {
name         = "${var.project_name}-${var.project_region}-${var.project_environment}-wms-extraction-policy"
 path         = "/"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "AllowLambdaBasicExecution"
        Effect    = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "*"
      },
      {
        Sid       = "AllowS3EventInvoke"
        Effect    = "Allow"
        Action    = "lambda:InvokeFunction"
        Resource  = "arn:aws:lambda:${var.project_region}:${var.account_id}:function:${var.project_name}-${var.project_region}-${var.project_environment}-file-extraction-msg-lambda"
        Condition = {
          StringEquals = {
            "AWS:SourceAccount" = var.account_id
          }
          ArnLike = {
            "AWS:SourceArn" = "arn:aws:s3:::${var.dms-s3Bucket_name}"
          }
        }
      }
    ]
  })
}
resource "aws_iam_role_policy_attachment" "attach_iam_policy_to_iam_role_wms_file-extraction-msg" {
 role        = aws_iam_role.tf_lambda_role_file_extraction_msg.name
 policy_arn  = aws_iam_policy.iam_policy_for_file_extraction_msg.arn

}

//tms-datasync

resource "aws_iam_role" "tf_lambda_role_tms_datasync" {
name   = "${var.project_name}-${var.project_region}-${var.project_environment}_tms_datasync_role"
assume_role_policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Action": "sts:AssumeRole",
     "Principal": {
     "Service": "lambda.amazonaws.com"
    },
     "Effect": "Allow",
     "Sid": ""
   }
 ]
}
EOF
}
resource "aws_iam_policy" "iam_policy_for_tms_datasync" {
name         = "${var.project_name}-${var.project_region}-${var.project_environment}_tms_datasync_policy"
 path         = "/"
policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      
         {
        Sid    = "VPCAccessPolicy"
        Effect = "Allow"
        Action = [
          "ec2:CreateNetworkInterface",
          "ec2:DescribeNetworkInterfaces",
          "ec2:DeleteNetworkInterface",
          "ec2:AssignPrivateIpAddresses",
          "ec2:UnassignPrivateIpAddresses"
        ]
        Resource = "*"
      },
      {
        Sid    = "S3ReadAccess",
        Effect = "Allow",
        Action = ["s3:GetObject"],
        Resource = "arn:aws:s3:::${var.dms-s3Bucket_name}"
      },
      {
        Sid    = "RDSPostgresAccess",
        Effect = "Allow",
        Action = [
          "ec2:DescribeInstances",
          "ec2:DescribeSecurityGroups",
          "ec2:DescribeNetworkInterfaces"
        ],
        Resource = "*"
      },
      {
        Sid    = "SNSPublishPermission",
        Effect = "Allow",
        Action = ["sns:Publish"],
        Resource = var.sns_topic_arn
      },
      {
        Sid    = "CloudWatchLogs",
        Effect = "Allow",
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Resource = "arn:aws:logs:${var.aws_region}:${var.account_id}:log-group:/aws/lambda/${var.project_name}-${var.project_region}-${var.project_environment}_tms_datasync:*"
      },
      {
        Sid    = "SecretsManagerAccess",
        Effect = "Allow",
        Action = ["secretsmanager:GetSecretValue"],
        Resource = "arn:aws:secretsmanager:${var.aws_region}:${var.account_id}:secret:lineagedb-connection-string-MOhyM6"
      },
      {
        Sid    = "SQSAccess",
        Effect = "Allow",
        Action = ["sqs:SendMessage"],
        Resource = "arn:aws:sqs:${var.aws_region}:${var.account_id}:lin-aps-dev-tms-datasync-dlq"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "attach_iam_policy_to_iam_role_tms_datasync" {
 role        = aws_iam_role.tf_lambda_role_tms_datasync.name
 policy_arn  = aws_iam_policy.iam_policy_for_tms_datasync.arn

}

//wms-datasync

/*resource "aws_iam_role" "tf_lambda_role_wms_datasync" {
  name = "${var.project_name}-${var.project_region}-${var.project_environment}-wms-datasync-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy" "wms_datasync_policy" {
  name = "${var.project_name}-${var.project_region}-${var.project_environment}-wms-datasync-policy"
  path = "/"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid     = "S3ReadAccess"
        Effect  = "Allow"
        Action  = ["s3:GetObject"]
        Resource = "arn:aws:s3:::linagedms/*"
      },
      {
        Sid     = "RDSPostgresAccess"
        Effect  = "Allow"
        Action  = [
          "ec2:DescribeInstances",
          "ec2:DescribeSecurityGroups",
          "ec2:DescribeNetworkInterfaces"
        ]
        Resource = "*"
      },
      {
        Sid     = "SNSPublishPermission"
        Effect  = "Allow"
        Action  = ["sns:Publish"]
        Resource = "arn:aws:sns:ap-southeast-2:${var.account_id}:lin-aps-dev-email-tp"
      },
      {
        Sid     = "CloudWatchLogs"
        Effect  = "Allow"
        Action  = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "arn:aws:logs:ap-southeast-2:${var.account_id}:log-group:/aws/lambda/${var.project_name}-${var.project_region}-${var.project_environment}-wms-datasync:*"
      },
      {
        Sid     = "SecretsManagerAccess"
        Effect  = "Allow"
        Action  = ["secretsmanager:GetSecretValue"]
        Resource = "arn:aws:secretsmanager:ap-southeast-2:${var.account_id}:secret:lineagedb-connection-string-MOhyM6"
      },
      {
        Sid     = "SQSAccess"
        Effect  = "Allow"
        Action  = ["sqs:SendMessage"]
        Resource = "arn:aws:sqs:ap-southeast-2:${var.account_id}:lin-aps-dev-tms-datasync-dlq"  # Corrected the SQS ARN
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "wms_datasync_policy_attachment" {
  role       = aws_iam_role.tf_lambda_role_wms_datasync.name
  policy_arn = aws_iam_policy.wms_datasync_policy.arn
}

resource "aws_lambda_permission" "allow_s3_trigger_wms_datasync" {
  statement_id  = "AllowExecutionFromS3"
  action        = "lambda:InvokeFunction"
  function_name = "${var.project_name}-${var.project_region}-${var.project_environment}-wms-datasync-lambda"
  principal     = "s3.amazonaws.com"
  source_arn    = "arn:aws:s3:::${var.dms-s3Bucket_name}"

  depends_on = [aws_lambda_function.wms_datasync]
}*/

//ftp-connection

# Add IAM role for the FTP connection Lambda
resource "aws_iam_role" "tf_lambda_role_ftp_connection" {
  name = "${var.project_name}-${var.project_region}-${var.project_environment}-ftp-connection-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

# Add IAM policy for the FTP connection Lambda
resource "aws_iam_policy" "iam_policy_for_ftp_connection" {
  name = "${var.project_name}-${var.project_region}-${var.project_environment}-ftp-connection-policy"
  path = "/"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "LambdaBasicExecution"
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "arn:aws:logs:${var.aws_region}:${var.account_id}:log-group:/aws/lambda/${var.project_name}-${var.project_region}-${var.project_environment}_file_connection_lambda:*"
      },
      {
        Sid    = "S3Access"
        Effect = "Allow"
        Action = [
          "s3:PutObject",
          "s3:GetObject",
          "s3:ListBucket"
        ]
        Resource = [
          "arn:aws:s3:::${var.dms-s3Bucket_name}",
          "arn:aws:s3:::${var.dms-s3Bucket_name}/*"
        ]
      },
      {
        Sid    = "SNSPublish"
        Effect = "Allow"
        Action = ["sns:Publish"]
        Resource = var.sns_topic_arn
      },
      {
        Sid    = "VPCAccess"
        Effect = "Allow"
        Action = [
          "ec2:CreateNetworkInterface",
          "ec2:DescribeNetworkInterfaces",
          "ec2:DeleteNetworkInterface"
        ]
        Resource = "*"
      }
    ]
  })
}

# Attach the policy to the role
resource "aws_iam_role_policy_attachment" "ftp_connection_policy_attachment" {
  role       = aws_iam_role.tf_lambda_role_ftp_connection.name
  policy_arn = aws_iam_policy.iam_policy_for_ftp_connection.arn
}

//ftp-file-move-s3-lambda

resource "aws_iam_role" "tf_lambda_role_ftp_file_move_s3" {
name   = "${var.project_name}-${var.project_region}-${var.project_environment}_ftp_file_move_s3_role"
assume_role_policy = <<EOF
{
 "Version": "2012-10-17",
 "Statement": [
   {
     "Action": "sts:AssumeRole",
     "Principal": {
     "Service": "lambda.amazonaws.com"
    },
     "Effect": "Allow",
     "Sid": ""
   }
 ]
}
EOF
}

resource "aws_iam_role" "ftp_file_move_role" {
  name = "${var.project_name}-${var.project_region}-${var.project_environment}-ftp-file-move-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_policy" "ftp_file_move_policy" {
  name = "${var.project_name}-${var.project_region}-${var.project_environment}-ftp-file-move-policy"
  path = "/"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "arn:aws:logs:${var.aws_region}:${var.account_id}:log-group:/aws/lambda/${var.project_name}-${var.project_region}-${var.project_environment}-ftp-file-move:*"
      },
      {
        Effect = "Allow"
        Action = [
          "sqs:ReceiveMessage",
          "sqs:DeleteMessage",
          "sqs:GetQueueAttributes",
          "sqs:ChangeMessageVisibility"
        ]
        Resource = var.sqs_queue_arn_file
      },
      {
        Effect = "Allow"
        Action = [
          "ec2:CreateNetworkInterface",
          "ec2:DescribeNetworkInterfaces",
          "ec2:DeleteNetworkInterface"
        ]
        Resource = "*"
      }
    ]
  })
}

# Update the policy attachment to use the new policy
resource "aws_iam_role_policy_attachment" "ftp_file_move_policy_attachment" {
  role       = aws_iam_role.ftp_file_move_role.name
  policy_arn = aws_iam_policy.ftp_file_move_policy.arn
}
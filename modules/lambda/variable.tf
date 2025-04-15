variable "project_name" {
  description = "Name of the project"
}

variable "project_region" {
  description = "Region of the project"
}

variable "project_environment" {
  description = "Environment (e.g. dev, staging, prod)"
}

variable "aws_region"{

}
variable "account_id"{

}
variable "dms-s3Bucket_name"{

}
variable "private_subnet_01"{

}
variable "private_subnet_02"{

}
variable "timeout_file-extraction-msg-lambda"{

}
variable "memory_size_file-extraction-msg-lambda"{

}
variable "size_file-extraction-msg-lambda"{

}
variable "batch_size_file-extraction-msg-lambda"{
    
}
variable "maximum_retry_attempts_file_extraction_msg_lambda"{
    
}
variable "maximum_event_age_in_seconds_file_extraction_msg_lambda"{
    
}
variable "data_extract_fail_dlq_arn"{
    
}
variable "retention_in_days_file_extraction_msg_lambda"{

}

variable "vpc_id"{

}
variable "tags"{

}
variable "sns_email_topic_arn" {
  description = "SNS Topic ARN for TMS failure notifications"
 
}
variable "LineageDmsDataExtractionApiUrl" {
  description = "SNS Topic ARN for  failure notifications"
 
}

//wms-file-extraction



variable "timeout_wms_file_extraction_msg_lambda" {
  description = "Timeout for the WMS file extraction lambda function"
  
}

variable "memory_size_wms_file_extraction_msg_lambda" {
  description = "Memory size for the WMS file extraction lambda function"
 
}

variable "size_wms_file_extraction_msg_lambda" {
  description = "Ephemeral storage size for the WMS file extraction lambda function"
  
}


variable "LineageDmsDataExtractionApiUrl_wms_file_extraction" {
  description = "SNS Topic ARN for  failure notifications"
 
}



variable "sqs_queue_arn"{

}
variable "sqs_queue_arn_file" {
  description = "ARN of the SQS queue triggering the Lambda"
 
}

variable "batch_size_wms_file_extraction_msg_lambda" {
  description = "Batch size for Lambda SQS trigger"
 
}

variable "maximum_retry_attempts_wms_file_extraction_msg_lambda" {
  description = "Maximum retry attempts for Lambda invocation"
}

variable "maximum_event_age_in_seconds_wms_file_extraction_msg_lambda" {
  description = "Maximum age in seconds for Lambda event"
}

variable "retention_in_days_wms_file_extraction_msg_lambda" {
  description = "CloudWatch log retention in days"
}


//tms-datasync

variable "lambda_description" {
  description = "Description of the Lambda function"
}

variable "memory_size_tms_datasync" {
  description = "Memory size for the Lambda function"
}

variable "timeout_tms_datasync" {
  description = "Timeout in seconds for the Lambda function"
}



variable "sns_file"{
  description = "SNS Topic ARN for notifications"

}



//ftp_connection_lambda


# Lambda Function Specific
variable "description_file_connection" {
  description = "Description for the Lambda function"
}

variable "handler_file_connection" {
  description = "Lambda handler (e.g., index.handler)"
}

variable "runtime_file_connection" {
  description = "Lambda runtime environment"
}

variable "timeout_file_connection" {
  description = "Timeout in seconds for Lambda execution"
}

variable "memory_file_connection" {
  description = "Memory size for Lambda in MB"
}

variable "sns_topic_arn" {

}


//variable "deployment_package_path" {
  //description = "Path for calculating source_code_hash (same as deployment package)"
//}

# Lambda Environment Variables
variable "AWSAccessKeyId" {
  description = "AWS Access Key ID for FTP operations"
}

variable "AWSSecretKey" {
  description = "AWS Secret Access Key for FTP operations" 
}




//variable "connection_string" {
  //description = "FTP connection string"
//}

variable "s3_destination_folder" {
  description = "Destination folder in S3"
}
variable "s3folder"{

}


//ftp-file-move-s3
variable "timeout_ftp_file_move_s3_lambda" {
  description = "Timeout for the Lambda function in seconds"
 
}
variable "retention_in_days_ftp_connection" {
  description = "Retention period in days for CloudWatch logs for FTP connection Lambda"
 
}

variable "memory_size_ftp_file_move_s3_lambda" {
  description = "Memory size for the Lambda function"
 type        = number
}

variable "batch_size_ftp_file_move_s3_lambda" {
  description = "Batch size for the SQS event source"
  type        = number
}

variable "retention_in_days_ftp_file_move_s3" {
  description = "CloudWatch log retention in days"
 }


//rds

 variable "rds_username" {
  
 }
 variable "rds_password" {
  
 }
 variable "DATABASE_NAME"{

 }
 variable "lineage_sqs-url"{

 }

 variable "rds_endpoint"{
  
 }

 variable "memory_size_wms_datasync"{
  
 }

 variable "tms_dlq_queue_arn" {
  description = "ARN of the Dead Letter Queue for the Lambda function"
 
}
variable "timeout_wms_datasync" {

}
variable "WMSDataSyncFailureTopicArn_wms_datasync" {
  description = "ARN of the SNS topic to notify on Lambda failure"
  
}

variable "aws_region"{
description  ="aws region"
 
}
variable "tags"{
description  ="tags"
}
variable "network_cidr"{
description  ="CIDR block for the network"
}
variable "project_region" {
  description = "Name of the project region"
}
variable "project_name" {
  description = "Name of the project"
}
 
variable "project_environment" {
  description = "Environment of the project"
}
variable "subnet_cidr" {
  description = "CIDR block for the subnet"
}
 
//rds
 
variable "rdsProperty" {
  description = "rdsProperty"
}
 
variable "DATABASE_NAME"{
}
 
//sqs
 
variable "visibility_timeout" {
  description = "Time a message remains invisible after being received"
  }
 
variable "message_retention" {
  description = "How long messages are retained (in seconds)"
}
 
variable "max_message_size" {
  description = "Maximum size of a message in bytes"
}
 
variable "delivery_delay" {
  description = "Time a message is delayed before being delivered"
}
 
variable "max_receive_count_file" {
  description = "Number of times a message can be received before moving to DLQ"
  }
variable "visibility_timeout_file" {
  description = "Time a message remains invisible after being received"
  }
 
variable "message_retention_file" {
  description = "How long messages are retained (in seconds)"
}
 
variable "max_message_size_file" {
  description = "Maximum size of a message in bytes"
}
 
variable "delivery_delay_file" {
  description = "Time a message is delayed before being delivered"
}
variable "account_id"{
description = "ID of the account"
}
variable "email" {
  description = "Email address for SNS notifications"
  type        = string
  validation {
    condition     = can(regex("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$", var.email))
    error_message = "The email address must be valid."
  }
}
 
 
//sqs-datasync_dlq
 
variable "visibility_timeout-datasync_dlq" {
  description = "Time a message remains invisible after being received"
}
 
variable "message_retention-datasync_dlq" {
  description = "How long messages are retained in seconds"
}
 
variable "max_message_size-datasync_dlq" {
  description = "Maximum size of a message in bytes"
}
 
variable "delivery_delay-datasync_dlq" {
  description = "Time a message is delayed before being delivered"
}
 
 
//sqs-wms-file
 
variable "visibility_timeout_wms_file" {
  description = "Visibility timeout in seconds for WMS file SQS"
}
 
variable "message_retention_wms_file" {
  description = "Message retention period in seconds for WMS file SQS"
}
 
variable "max_message_size_wms_file" {
  description = "Maximum message size in bytes for WMS file SQS"
}
 
variable "delay_seconds_wms_file" {
  description = "Delay in seconds for message delivery in WMS file SQS"
}
 
 
variable "max_receive_count_wms_file" {
  description = "Max number of receives before sending message to DLQ"
}
 
 
//data-extraction
 
variable "visibility_timeout_dlq" {
  description = "Visibility timeout in seconds"
  }
 
variable "message_retention_dlq" {
  description = "Retention period in seconds"
}
 
variable "max_message_size_dlq" {
  description = "Max message size in bytes"
}
 
variable "delay_seconds_dlq" {
  description = "Delay seconds"
}
 
 
//tms-data-extract-dlq
 
variable "visibility_timeout_tms_dlq" {
  description = "Visibility timeout for TMS DLQ in seconds"
}
 
variable "message_retention_tms_dlq" {
  description = "Retention period for TMS DLQ messages"
}
 
variable "max_message_size_tms_dlq" {
  description = "Maximum message size"
}
 
variable "delay_seconds_tms_dlq" {
  description = "Delay in delivery for DLQ messages"
}
 
 
//lambda-main-dev-file-extraction-msg
 
 
variable "LineageDmsDataExtractionApiUrl"{
 
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
variable "retention_in_days_file_extraction_msg_lambda"{
}
 
//wms-file-extraction-lambda
 
variable "timeout_wms_file_extraction_msg_lambda" {
  description = "Timeout for the WMS file extraction lambda function"
  }
 
variable "memory_size_wms_file_extraction_msg_lambda" {
  description = "Memory size for the WMS file extraction lambda function"
}
 
variable "size_wms_file_extraction_msg_lambda" {
  description = "Ephemeral storage size for the WMS file extraction lambda function"
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
 
 
variable "LineageDmsDataExtractionApiUrl_wms_file_extraction" {
  description = "SNS Topic ARN for  failure notifications"
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
 
 
variable "create_filtered_subscription" {
  description = "Whether to create the filtered email subscription"
  type        = bool
  default     = false
}
 
 
 


 
//secret-manager
 
//ftp_connection_lambda
 
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
 
/*
variable "deployment_package_path_file_connection" {
  description = "Path to the Lambda deployment zip package"
}
 
variable "deployment_package_path" {
  description = "Path for calculating source_code_hash (same as deployment package)"
}
*/
 
# Lambda Environment Variables
variable "AWSAccessKeyId" {
  description = "AWS Access Key ID for FTP operations"
}
 
variable "AWSSecretKey" {
  description = "AWS Secret Access Key for FTP operations"
  type        = string
}

/*
variable "connection_string" {
  description = "FTP connection string"
}
*/
 
variable "s3_destination_folder" {
  description = "Destination folder in S3"
}
 
variable "s3folder"{
  description ="folder inside the destination folder"
}
 
variable "retention_in_days_ftp_connection" {
  description = "Number of days to retain CloudWatch logs for FTP connection Lambda"
}
 
//ftp-file-move-s3-lambda
 
variable "timeout_ftp_file_move_s3_lambda" {
  description = "Timeout for the Lambda function in seconds"
  }
 
variable "memory_size_ftp_file_move_s3_lambda" {
  description = "Memory size for the Lambda function"
}
 
variable "batch_size_ftp_file_move_s3_lambda" {
  description = "Batch size for the SQS event source"
  }
 
variable "retention_in_days_ftp_file_move_s3" {
  description = "CloudWatch log retention in days"
}
 
//ecr
 
variable "microserviceName"{
     type        = string
}
 
variable "microserviceName-2" {
    type  =string
}
variable "microserviceName-3" {
    description  = "the name of the ecr image-3"
}
variable "microserviceName-4" {
    description  = "the name of the ecr image-4"
}
variable "microserviceName-5" {
    description  = "the name of the ecr image-5"
}

variable "timeout_wms_datasync" {
  description = "Timeout (in seconds) for WMS datasync Lambda"
 
}


variable "visibility_timeout_wms_dlq" {
  
}

variable "max_message_size_wms_dlq" {
  
}

variable "message_retention_wms_dlq" {
  
}

variable "delay_seconds_wms_dlq" {
  
}

variable "memory_size_wms_datasync" {
  
}

variable "WMSDataSyncFailureTopicArn_wms_datasync" {

}

variable "domainNameSSLCertificateArn" {
  
}
variable "project_name" {
  type        = string
  description = "project_name"
}

variable "project_environment" {
  type        = string
  description = "project_environment"
}

variable "project_region" {
  type        = string
  description = "project_region"
}


variable "sns_topic_arn" {
  description = "ARN of the SNS FIFO topic"
}

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
variable "tags"{

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

variable "visibility_timeout_wms_dlq" {

}

variable "message_retention_wms_dlq" {

}

variable "max_message_size_wms_dlq" {

}

variable "delay_seconds_wms_dlq" {
  
}
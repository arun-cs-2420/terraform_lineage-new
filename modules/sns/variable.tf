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
variable "sqs_queue_arn"{

}
variable "account_id"{

}
variable "dms-s3Bucket_name"{

}
variable "sqs_queue_arn_file"{
    
}
variable "email" {
  description = "Email address for SNS notifications"
  type        = string
  validation {
    condition     = can(regex("^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$", var.email))
    error_message = "The email address must be valid."
  }
}


//

variable "create_filtered_subscription" {
  description = "Whether to create the filtered email subscription"
}
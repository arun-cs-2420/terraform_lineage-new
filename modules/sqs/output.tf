output "sqs_queue_id" {
  description = "The ID of the SQS queue"
  value       = aws_sqs_queue.lineage_sqs.id
}

output "sqs_queue_arn" {
  description = "The ARN of the SQS queue"
  value       = aws_sqs_queue.lineage_sqs.arn
}

output "sqs_queue_url" {
  description = "The URL of the SQS queue"
  value       = aws_sqs_queue.lineage_sqs.url
}

output "sqs_queue_id_file" {
  description = "The ID of the SQS queue"
  value       = aws_sqs_queue.sqs_queue_file.id
}

output "sqs_queue_arn_file" {
  description = "The ARN of the SQS queue"
  value       = aws_sqs_queue.sqs_queue_file.arn
}

output "sqs_queue_url_file" {
  description = "The URL of the SQS queue"
  value       = aws_sqs_queue.sqs_queue_file.url
}



//sqs-datasync-dlq

output "sqs_queue_id-datasync_dlq" {
  description = "The ID of the created SQS queue"
  value       = aws_sqs_queue.sqs_queue-datasync_dlq.id
}

output "sqs_queue_arn-datasync_dlq" {
  description = "The ARN of the created SQS queue"
  value       = aws_sqs_queue.sqs_queue-datasync_dlq.arn
}

output "sqs_queue_url-datasync_dlq" {
  description = "The URL of the created SQS queue"
  value       = aws_sqs_queue.sqs_queue-datasync_dlq.url
}

//wms-file


output "wms_file_queue_url" {
  description = "The URL of the WMS file SQS queue"
  value       = aws_sqs_queue.wms_file_queue.url
}

output "wms_file_queue_arn" {
  description = "The ARN of the WMS file SQS queue"
  value       = aws_sqs_queue.wms_file_queue.arn
}


//data-extraction

output "data_extract_fail_dlq_arn" {
  description = "ARN of the DLQ queue"
  value       = aws_sqs_queue.data_extract_fail_dlq.arn
}

output "data_extract_fail_dlq_name" {
  description = "Name of the DLQ queue"
  value       = aws_sqs_queue.data_extract_fail_dlq.name
}


//wms-data-extract-dlq
output "wms_dlq_queue_name" {
  description = "Name of the TMS DLQ SQS queue"
  value       = aws_sqs_queue.wms_data_extract_fail_dlq.name
}

output "wms_dlq_queue_arn" {
  description = "ARN of the TMS DLQ SQS queue"
  value       = aws_sqs_queue.wms_data_extract_fail_dlq.arn
}
output "tms_dlq_queue_arn" {
  description = "ARN of the TMS DLQ SQS queue"
  value       = aws_sqs_queue.sqs_queue-datasync_dlq.arn
}
output "lineage_sqs-url"{
  value   =  aws_sqs_queue.lineage_sqs.url
}
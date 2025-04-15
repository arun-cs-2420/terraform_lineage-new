
output "lambda_tms_datasync_code"{
value = "aws_s3_object.lambda_tms_datasync_code.id"
}

//ftp-connection

output "ftp_connection_lambda_name" {
  description = "Name of the FTP connection Lambda function"
  value       = aws_lambda_function.ftp_connection_lambda.function_name
}

output "ftp_connection_lambda_arn" {
  description = "ARN of the FTP connection Lambda function"
  value       = aws_lambda_function.ftp_connection_lambda.arn
}

output "ftp_connection_lambda_log_group" {
  description = "CloudWatch log group for the FTP connection Lambda"
  value       = "/aws/lambda/${aws_lambda_function.ftp_connection_lambda.function_name}"
}

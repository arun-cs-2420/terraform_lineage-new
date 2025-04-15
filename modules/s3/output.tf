output "dms-s3Bucket_name" {
  value       = aws_s3_bucket.tf_s3_bucket_dms_s3.id
  description = "The name of the DMS S3 bucket"
  depends_on  = [aws_s3_bucket.tf_s3_bucket_dms_s3]
}


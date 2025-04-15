
#cdn
locals {
  common_tags = var.tags
}

/* SourceCode Bucket*/
resource "aws_s3_bucket" "tf_s3_bucket_dms_s3" {
  bucket = "${var.project_name}-${var.project_region}-${var.project_environment}-dms-s3"
  force_destroy = true
  tags = merge(
    local.common_tags, {"Name"= "${var.project_name}-${var.project_region}-${var.project_environment}-dms-s3"}
  )
}
resource "aws_s3_bucket_versioning" "tf_s3_bucket_versioning_dms_s3" {
  bucket = aws_s3_bucket.tf_s3_bucket_dms_s3.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_object_lock_configuration" "tf_s3_bucket_lock_configuration_dms_s3" {
  bucket = aws_s3_bucket.tf_s3_bucket_dms_s3.id
  object_lock_enabled = "Enabled"
  depends_on = [
    aws_s3_bucket.tf_s3_bucket_dms_s3,
    aws_s3_bucket_versioning.tf_s3_bucket_versioning_dms_s3
  ]
}
resource "aws_s3_bucket_server_side_encryption_configuration" "tf_dms_s3" {
  bucket = aws_s3_bucket.tf_s3_bucket_dms_s3.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}


resource "aws_s3_bucket_public_access_block" "tf_s3_bucket_public_access_block_dms_s3" {
  bucket = aws_s3_bucket.tf_s3_bucket_dms_s3.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
# AWS
provider "aws" {
  region = var.aws_region
}

# terraform environment in AWS S3
terraform {
  backend "s3" {
    encrypt = true
  }
}
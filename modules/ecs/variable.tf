variable "aws_region" {
  description = "aws_region"
}
variable "project_region" {
  
}
variable "private_subnet_01" {
  
}
variable "private_subnet_02" {
  
}
########################### VPC Config ################################
variable "vpc_id" {
  description = "vpc id"
}

variable "public_subnet_01" {
  description = "vpc public subnet 01"
}

variable "public_subnet_02" {
  description = "vpc public subnet 02"
}

variable "project_name" {
  description = "Name of the project"
}

variable "project_environment" {
  type        = string
  description = "Project environment"
}
variable "tags" {
  description = "Project Tags"
###############################################################
}
variable "alb_listener_property" {
  description = "application loadbalancer port"
  default = {

    "ALB_PORT"        = "80"
    "PROTOCOL"        = "HTTP"
    "ACTION_TYPE"     = "forward"
    "SSL_POLICY"      = ""
    "CERTIFICATE_ARN" = ""
  }
}

variable "domainNameSSLCertificateArn" {
  description = "domainNameSSLCertificateArn"
}

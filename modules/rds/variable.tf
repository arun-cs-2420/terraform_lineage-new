variable "vpc_id" {
  description = "vpc id"
}
variable "private_subnet_03" {
  description = "ID of the first private subnet"
  type        = string
}

variable "private_subnet_04" {
  description = "ID of the second private subnet"
  type        = string
}


variable "tags" {
  description = "Project Tags"
}

variable "rdsProperty" {
  description = "rdsProperty"
}
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

variable "network_cidr" {
  description = "CIDR block for the VPC"
}
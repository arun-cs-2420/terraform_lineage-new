variable "project_region" {
  description = "The AWS region to deploy resources"
  type        = string
  default     = "ap-southeast-2"
}

variable "project_name" {
  description = "The name of the project"
  type        = string
}

variable "project_environment" {
  description = "The environment (e.g., dev, staging, prod)"
  type        = string
}
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
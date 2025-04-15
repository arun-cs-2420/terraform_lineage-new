variable "project_region" {
  
}
variable "vpc_id" {
  description = "vpc id"
}

variable "private_subnet_01" {
  description = "public_subnet_01"
}

variable "private_subnet_02" {
  description = "public_subnet_02"
}
/* Project Config */
variable "projectName" {
  description = "projectName"
}
variable "projectEnvironment" {
  description = "projectEnvironment"
}
variable "projectTags" {
  description = "projectTags"
}
variable "awsRegion" {
  description = "awsRegion"
  
}

variable "ecs_cluster_id" {

}
variable "ecs_cluster_name" {

}
variable "albListener"{

}

variable "albListenerHttps" {

}

variable "microserviceName" {
  description = "microserviceName"
  default     = "web-eract"
}

variable "containerPort" {
    default = "8085"
}

variable "healthCheckPath" {
  description = "health check path"
  default     = "/"
}

variable "albPathPriority" {
    default = "10002"
}
variable "microservicesPathPattern" {
    default = "/api/wms/health/*"
}
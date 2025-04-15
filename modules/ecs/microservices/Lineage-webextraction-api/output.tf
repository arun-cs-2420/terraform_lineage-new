output "ecrlineageextractionapiRepositoryURL" {
  value = aws_ecr_repository.tf_ecr_repository_lineage_web_extraction_api.repository_url
}
output "ecrlineageextractionapiRepositoryName" {
  value = "${var.projectName}-${var.project_region}-${var.microserviceName}-${var.projectEnvironment}-repo"
}
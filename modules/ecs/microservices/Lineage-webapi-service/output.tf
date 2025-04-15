output "ecrlineagewebapiRepositoryURL" {
  value = aws_ecr_repository.tf_ecr_repository_lineage_web_api.repository_url
}
output "ecrlineagewebapiRepositoryName" {
  value = "${var.projectName}-${var.project_region}-${var.microserviceName}-${var.projectEnvironment}-repo"
}
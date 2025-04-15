output "ecrlineageuiRepositoryURL" {
  value = aws_ecr_repository.tf_ecr_repository_lineage_ui.repository_url
}
output "ecrlineageuiRepositoryName" {
  value = "${var.projectName}-${var.project_region}-${var.microserviceName}-${var.projectEnvironment}-repo"
}
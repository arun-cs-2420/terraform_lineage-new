output "ecrlineagetmsbarcodeserviceRepositoryURL" {
  value = aws_ecr_repository.tf_ecr_repository_lineage_tms_barcode_service.repository_url
}
output "ecrlineagetmsbarcodeserviceRepositoryName" {
  value = "${var.projectName}-${var.project_region}-${var.microserviceName}-${var.projectEnvironment}-repo"
}
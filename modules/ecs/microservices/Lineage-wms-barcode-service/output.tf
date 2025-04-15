output "ecrlineagewmsbarcodeserviceRepositoryURL" {
  value = aws_ecr_repository.tf_ecr_repository_lineage_wms_barcode_service.repository_url
}
output "ecrlineagewmsbarcodeserviceRepositoryName" {
  value = "${var.projectName}-${var.project_region}-${var.microserviceName}-${var.projectEnvironment}-repo"
}
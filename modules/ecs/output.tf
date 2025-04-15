
output "ecs_cluster" {
  value = "${aws_ecs_cluster.tf_cluster}"
}

#############################################################

output "alb_arn" {
  value = "${aws_alb.tf_alb.arn}"
}

output "alb_listener" {
  value = "${aws_alb_listener.tf_alb_listener.arn}"
}

output "alb_dns_name" {
  value = "${aws_alb.tf_alb.dns_name}"
}

#################################################################

#Lineage-ui ECS Config 

output "ecrlineage-uiRepositoryURL" {
  value = "${module.lineage_ui.ecrlineageuiRepositoryURL}"
}
output "ecrlineageuiRepositoryName" {
  value = "${module.lineage_ui.ecrlineageuiRepositoryName}"
}


###################################################################

#Lineage-webapi ECS Config

output "ecrlineage-webapiRepositoryURL" {
  value = "${module.lineage_webapi.ecrlineagewebapiRepositoryURL}"
}
output "ecrlineage-webapiRepositoryName" {
  value = "${module.lineage_webapi.ecrlineagewebapiRepositoryName}"
}



#Lineage-web-extraction-api ECS Config

output "ecrlineage-webextractionapiRepositoryURL" {
  value = "${module.lineage_web_extraction_api.ecrlineageextractionapiRepositoryURL}"
}
output "ecrlineage-webextractionapiRepositoryName" {
  value = "${module.lineage_web_extraction_api.ecrlineageextractionapiRepositoryName}"
}

#lineage_wms_barcode_service

output "ecrlineagewmsbarcodeserviceRepositoryURL" {
  value = "${module.lineage_wms_barcode_service.ecrlineagewmsbarcodeserviceRepositoryURL}"
}
output "ecrlineagewmsbarcodeserviceRepositoryName" {
  value = "${module.lineage_wms_barcode_service.ecrlineagewmsbarcodeserviceRepositoryName}"
}

#lineage_tms_barcode_service

output "ecrlineagetmsbarcodeserviceRepositoryURL" {
  value = "${module.lineage_tms_barcode_service.ecrlineagetmsbarcodeserviceRepositoryURL}"
}
output "ecrlineagetmsbarcodeserviceRepositoryName" {
  value = "${module.lineage_tms_barcode_service.ecrlineagetmsbarcodeserviceRepositoryName}"
}
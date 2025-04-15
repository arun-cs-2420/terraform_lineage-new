#Lineage-ui module
module "lineage_ui" {
  source = "./microservices/Lineage-ui"

  projectName        = "${var.project_name}"
  projectEnvironment = "${var.project_environment}"
  awsRegion          = var.aws_region
  projectTags        = "${var.tags}"
  project_region = "${var.project_region}"

  vpc_id           = "${var.vpc_id}"
  private_subnet_01 = "${var.private_subnet_01}"
  private_subnet_02 = "${var.private_subnet_02}"

  
  ecs_cluster_id   = "${aws_ecs_cluster.tf_cluster.id}"
  ecs_cluster_name = "${aws_ecs_cluster.tf_cluster.name}"
  albListener      = "${aws_alb_listener.tf_alb_listener.arn}"
  albListenerHttps = "${aws_alb_listener.tf_alb_listener_https.arn}"
}

#Lineage-webapi  module

module "lineage_webapi" {
  source = "./microservices/Lineage-webapi-service"

  projectName        = "${var.project_name}"
  projectEnvironment = "${var.project_environment}"
  awsRegion          = var.aws_region
  projectTags        = "${var.tags}"
  project_region = "${var.project_region}"

  vpc_id           = "${var.vpc_id}"
  private_subnet_01 = "${var.private_subnet_01}"
  private_subnet_02 = "${var.private_subnet_02}"

  
  ecs_cluster_id   = "${aws_ecs_cluster.tf_cluster.id}"
  ecs_cluster_name = "${aws_ecs_cluster.tf_cluster.name}"
  albListener      = "${aws_alb_listener.tf_alb_listener.arn}"
  albListenerHttps = "${aws_alb_listener.tf_alb_listener_https.arn}"
}

module "lineage_web_extraction_api" {
  source = "./microservices/Lineage-webextraction-api"

  projectName        = "${var.project_name}"
  projectEnvironment = "${var.project_environment}"
  awsRegion          = var.aws_region
  projectTags        = "${var.tags}"
  project_region = "${var.project_region}"

  vpc_id           = "${var.vpc_id}"
  private_subnet_01 = "${var.private_subnet_01}"
  private_subnet_02 = "${var.private_subnet_02}"

  
  ecs_cluster_id   = "${aws_ecs_cluster.tf_cluster.id}"
  ecs_cluster_name = "${aws_ecs_cluster.tf_cluster.name}"
  albListener      = "${aws_alb_listener.tf_alb_listener.arn}"
  albListenerHttps = "${aws_alb_listener.tf_alb_listener_https.arn}"
}

module "lineage_wms_barcode_service" {
  source = "./microservices/Lineage-wms-barcode-service"

  projectName        = "${var.project_name}"
  projectEnvironment = "${var.project_environment}"
  awsRegion          = var.aws_region
  projectTags        = "${var.tags}"
  project_region = "${var.project_region}"

  vpc_id           = "${var.vpc_id}"
  private_subnet_01 = "${var.private_subnet_01}"
  private_subnet_02 = "${var.private_subnet_02}"

  
  ecs_cluster_id   = "${aws_ecs_cluster.tf_cluster.id}"
  ecs_cluster_name = "${aws_ecs_cluster.tf_cluster.name}"
  albListener      = "${aws_alb_listener.tf_alb_listener.arn}"
  albListenerHttps = "${aws_alb_listener.tf_alb_listener_https.arn}"
}

module "lineage_tms_barcode_service" {
  source = "./microservices/Lineage-tms-barcode-service"

  projectName        = "${var.project_name}"
  projectEnvironment = "${var.project_environment}"
  awsRegion          = var.aws_region
  projectTags        = "${var.tags}"
  project_region = "${var.project_region}"

  vpc_id           = "${var.vpc_id}"
  private_subnet_01 = "${var.private_subnet_01}"
  private_subnet_02 = "${var.private_subnet_02}"

  
  ecs_cluster_id   = "${aws_ecs_cluster.tf_cluster.id}"
  ecs_cluster_name = "${aws_ecs_cluster.tf_cluster.name}"
  albListener      = "${aws_alb_listener.tf_alb_listener.arn}"
  albListenerHttps = "${aws_alb_listener.tf_alb_listener_https.arn}"
}
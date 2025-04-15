module "vpc" {
  source = "./modules/vpc"
  tags =var.tags
  project_name = var.project_name
  project_environment = var.project_environment
  project_region = var.project_region
  network_cidr = var.network_cidr
  subnet_cidr  = var.subnet_cidr
  account_id   = var.account_id
}
module "rds"{
source = "./modules/rds"
vpc_id = module.vpc.vpc_id
private_subnet_03 = module.vpc.private_subnet_03
private_subnet_04 = module.vpc.private_subnet_04
tags =var.tags
project_region=var.project_region
rdsProperty =var.rdsProperty
project_name =var.project_name
project_environment =var.project_environment
network_cidr =var.network_cidr
}
 
module "s3"{
source = "./modules/s3"
project_name        =var.project_name
project_environment =var.project_environment
tags               =var.tags
project_region     =var.project_region
}
 
module "sqs"  {
    source                    ="./modules/sqs"
    sns_topic_arn=module.sns.sns_topic_arn
    visibility_timeout=var.visibility_timeout
    message_retention =var.message_retention
    max_message_size =var.max_message_size
    delivery_delay =var.delivery_delay

    delay_seconds_wms_dlq = var.delay_seconds_wms_dlq
    message_retention_wms_dlq = var.message_retention_wms_dlq
    visibility_timeout_wms_dlq = var.visibility_timeout_wms_dlq
    max_message_size_wms_dlq = var.max_message_size_wms_dlq
  

    max_receive_count_file =var.max_receive_count_file
    visibility_timeout_file=var.visibility_timeout_file
    message_retention_file =var.message_retention_file
    max_message_size_file =var.max_message_size_file
    delivery_delay_file =var.delivery_delay_file
    project_name  =var.project_name
    project_environment  =var.project_environment
    project_region   =var.project_region
    tags =var.tags
 
//datasync_dlq
    visibility_timeout-datasync_dlq =var.visibility_timeout-datasync_dlq
    message_retention-datasync_dlq  =var.message_retention-datasync_dlq
    max_message_size-datasync_dlq  =var.max_message_size-datasync_dlq
    delivery_delay-datasync_dlq =var.delivery_delay-datasync_dlq
 
//wms-file-sqs
    visibility_timeout_wms_file = var.visibility_timeout_wms_file
    message_retention_wms_file  = var.message_retention_wms_file
    max_message_size_wms_file   = var.max_message_size_wms_file
    delay_seconds_wms_file      = var.delay_seconds_wms_file
    max_receive_count_wms_file = var.max_receive_count_wms_file
 
//data-extraction-dlq
    visibility_timeout_dlq   = var.visibility_timeout_dlq
    message_retention_dlq    = var.message_retention_dlq
    max_message_size_dlq     = var.max_message_size_dlq
    delay_seconds_dlq        = var.delay_seconds_dlq

 
//tms-data-extract
    visibility_timeout_tms_dlq = var.visibility_timeout_tms_dlq
    message_retention_tms_dlq  = var.message_retention_tms_dlq
    max_message_size_tms_dlq   = var.max_message_size_tms_dlq
    delay_seconds_tms_dlq      = var.delay_seconds_tms_dlq
}
 
module "sns"   {
   source                    ="./modules/sns"
 
   project_name              =var.project_name
   project_environment       =var.project_environment
   project_region            =var.project_region
   sqs_queue_arn             = module.sqs.sqs_queue_arn
   account_id                =var.account_id
   dms-s3Bucket_name         =module.s3.dms-s3Bucket_name
   sqs_queue_arn_file        = module.sqs.sqs_queue_arn_file
 
   email                     = var.email
 
   create_filtered_subscription=var.create_filtered_subscription
}
 
module "lambda"   {
  source                    ="./modules/lambda"
 
  sns_email_topic_arn       = module.sns.sns_email_topic_arn
  LineageDmsDataExtractionApiUrl           = var.LineageDmsDataExtractionApiUrl
  data_extract_fail_dlq_arn                = module.sqs.data_extract_fail_dlq_arn
  sqs_queue_arn_file                       = module.sqs.sqs_queue_arn_file 
  vpc_id                                   = module.vpc.vpc_id
  private_subnet_01                        = module.vpc.private_subnet_01
  private_subnet_02                        = module.vpc.private_subnet_02
  memory_size_wms_datasync                 = var.memory_size_wms_datasync
  tms_dlq_queue_arn        = module.sqs.tms_dlq_queue_arn
  sqs_queue_arn                            = module.sqs.sqs_queue_arn
  timeout_file-extraction-msg-lambda       = var.timeout_file-extraction-msg-lambda
  memory_size_file-extraction-msg-lambda   = var.memory_size_file-extraction-msg-lambda
  size_file-extraction-msg-lambda          = var.size_file-extraction-msg-lambda
  batch_size_file-extraction-msg-lambda    = var.batch_size_file-extraction-msg-lambda
  maximum_retry_attempts_file_extraction_msg_lambda       = var.maximum_retry_attempts_file_extraction_msg_lambda
  maximum_event_age_in_seconds_file_extraction_msg_lambda = var.maximum_event_age_in_seconds_file_extraction_msg_lambda
  retention_in_days_file_extraction_msg_lambda            = var.retention_in_days_file_extraction_msg_lambda
  project_name             = var.project_name
  project_region           = var.project_region
  project_environment      = var.project_environment
  aws_region               =var.aws_region
  tags                     = var.tags
  account_id               =var.account_id
  dms-s3Bucket_name        =module.s3.dms-s3Bucket_name
  depends_on = [
    module.s3,
    module.vpc,
    module.sns
  ]
//wms-file-extraction-lambda
  timeout_wms_file_extraction_msg_lambda                 = var.timeout_wms_file_extraction_msg_lambda
  memory_size_wms_file_extraction_msg_lambda             = var.memory_size_wms_file_extraction_msg_lambda
  size_wms_file_extraction_msg_lambda                    = var.size_wms_file_extraction_msg_lambda
  LineageDmsDataExtractionApiUrl_wms_file_extraction     = var.LineageDmsDataExtractionApiUrl_wms_file_extraction
  batch_size_wms_file_extraction_msg_lambda              = var.batch_size_wms_file_extraction_msg_lambda
  maximum_retry_attempts_wms_file_extraction_msg_lambda       = var.maximum_retry_attempts_wms_file_extraction_msg_lambda
  maximum_event_age_in_seconds_wms_file_extraction_msg_lambda = var.maximum_event_age_in_seconds_wms_file_extraction_msg_lambda
  retention_in_days_wms_file_extraction_msg_lambda            = var.retention_in_days_wms_file_extraction_msg_lambda
 
//tms-datasync
 
  lambda_description                      = var.lambda_description
  memory_size_tms_datasync                = var.memory_size_tms_datasync
  timeout_tms_datasync                    = var.timeout_tms_datasync
  sns_topic_arn                           = module.sns.sns_topic_arn
 

  timeout_wms_datasync     = var.timeout_wms_datasync
  WMSDataSyncFailureTopicArn_wms_datasync   = var.WMSDataSyncFailureTopicArn_wms_datasync
  

//file-connection-lambda
 
  description_file_connection        = var.description_file_connection
  handler_file_connection            = var.handler_file_connection
  runtime_file_connection            = var.runtime_file_connection
  timeout_file_connection            = var.timeout_file_connection
  memory_file_connection             = var.memory_file_connection
  //deployment_package_path_file_connection = var.deployment_package_path_file_connection
  //deployment_package_path                 = var.deployment_package_path
  //SnsTopicArn                             = module..sns.sns_topic_arn
  //SqsQueueUrl                             = var.sqs_queue_url
  rds_endpoint                            = module.rds.rds_endpoint
  retention_in_days_ftp_connection          =var.retention_in_days_ftp_connection
 
//ftp-file-move-s3-lambda
  AWSAccessKeyId          = var.AWSAccessKeyId
  AWSSecretKey            = var.AWSSecretKey
  sns_file                = module.sns.sns_file
 lineage_sqs-url          = module.sqs.lineage_sqs-url
  //connection_string     = var.connection_string
 
  rds_username    =module.rds.rds_username
  rds_password    =module.rds.rds_password
  DATABASE_NAME   =var.DATABASE_NAME
 
  s3_destination_folder   = var.s3_destination_folder
  s3folder                = var.s3folder
  timeout_ftp_file_move_s3_lambda      = var.timeout_ftp_file_move_s3_lambda
  memory_size_ftp_file_move_s3_lambda  = var.memory_size_ftp_file_move_s3_lambda
  batch_size_ftp_file_move_s3_lambda   = var.batch_size_ftp_file_move_s3_lambda
  retention_in_days_ftp_file_move_s3   = var.retention_in_days_ftp_file_move_s3
  }
 
 
//secret-Manager
 
  module "secret-manager" {
  source               = "./modules/secret-manager"
  project_name         =var.project_name
  project_environment  =var.project_environment
  project_region       =var.project_region
  secret_string        = jsonencode({
  host                 = module.rds.rds_endpoint
  username             = module.rds.rds_username
  password             = module.rds.rds_password
  port                 = 5432
  })
}
 
module "ecr"  {
    source                    ="./modules/ecr"
 
microserviceName  =var.microserviceName
microserviceName-2  =var.microserviceName-2
microserviceName-3  =var.microserviceName-3
microserviceName-4  =var.microserviceName-4
microserviceName-5  =var.microserviceName-5
 
project_name              =var.project_name 
project_environment       =var.project_environment
project_region                =var.project_region
}
 
module "ecs" {
  source = "./modules/ecs"
 
  project_name        = var.project_name
  project_environment = var.project_environment
  tags = var.tags
  aws_region          = var.aws_region
  project_region     = var.project_region
  vpc_id           = module.vpc.vpc_id
  private_subnet_01 = module.vpc.private_subnet_01
  private_subnet_02 = module.vpc.private_subnet_02
  public_subnet_01  = module.vpc.public_subnet_01
  public_subnet_02  = module.vpc.public_subnet_02
  domainNameSSLCertificateArn = var.domainNameSSLCertificateArn
/*
  ecs_cluster_id   = "${aws_ecs_cluster.tf_ecs_cluster_lineage_ui.id}"
  ecs_cluster_name = "${aws_ecs_cluster.tf_ecs_cluster_lineage_ui.name}"
  albListener      = "${aws_alb_listener.tf_alb_listener.arn}"
  albListenerHttps = "${aws_alb_listener.tf_alb_listener_https.arn}"
*/
}

module "codepipeline" {
  source = "./modules/codepipeline"
 
  project_name        = var.project_name
  project_environment = var.project_environment
  aws_region          = var.aws_region
  project_region     = var.project_region
  tags               = var.tags
}
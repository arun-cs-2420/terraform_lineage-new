locals {
  common_tags = var.projectTags
}

#target group
resource "aws_alb_target_group" "tf_alb_tg_lineage_tms_barcode_service" {
  name                 = "${var.projectName}-${var.project_region}-${var.microserviceName}-${var.projectEnvironment}-tg"
  port                 = var.containerPort
  protocol             = "HTTP"
  vpc_id               = var.vpc_id
  target_type          = "ip"
  deregistration_delay = 30

  health_check {
    healthy_threshold   = "3"
    interval            = "30"
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "3"
    path                = var.healthCheckPath
    unhealthy_threshold = "2"
  }
  tags = merge(
    local.common_tags, {"Name"="${var.projectName}-${var.project_region}-${var.microserviceName}-${var.projectEnvironment}-tg"}
  )
}

resource "aws_alb_listener_rule" "tf_alb_listener_rule_lineage-tms_barcode_service" {
  listener_arn = var.albListener
  priority     = var.albPathPriority
  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.tf_alb_tg_lineage_tms_barcode_service.arn
  }
  condition {
    path_pattern {
      values = [var.microservicesPathPattern]
    }
  }
}

resource "aws_alb_listener_rule" "tf_alb_listener_rule_lineage_tms_barcode_service_https" {
  listener_arn = var.albListenerHttps
  priority     = var.albPathPriority
  action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.tf_alb_tg_lineage_tms_barcode_service.arn
  }
  condition {
    path_pattern {
      values = [var.microservicesPathPattern]
    }
  }
}

resource "aws_ecs_cluster" "tf_cluster" {
   name   = "${var.project_name}-${var.project_region}-${var.project_environment}-cluster"

}

resource "aws_ecs_cluster_capacity_providers" "tf_capacity_provider" {
  cluster_name = aws_ecs_cluster.tf_cluster.name

  capacity_providers = ["FARGATE"]

  default_capacity_provider_strategy {
    base              = 1
    weight            = 100
    capacity_provider = "FARGATE"
  }
}


######## ALB ########
resource "aws_security_group" "tf_alb_sg" {
  name        = "${var.project_name}-${var.project_region}-${var.project_environment}-alb-sg"
  description = "Controls access to the ALB"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    protocol    = "-1"
    from_port   = 0
    to_port     = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_alb" "tf_alb" {
  name            = "${var.project_name}-${var.project_region}-${var.project_environment}-alb"
  subnets         = [var.public_subnet_01, var.public_subnet_02]
  security_groups = [aws_security_group.tf_alb_sg.id]
  
}

resource "aws_alb_target_group" "tf_alb_tg_default" {
  name = "${var.project_name}-${var.project_region}-${var.project_environment}-tg"

  vpc_id      = var.vpc_id
  port        = 80
  protocol    = "HTTP"
  target_type = "ip"
  health_check {
    healthy_threshold   = "3"
    interval            = "30"
    protocol            = "HTTP"
    matcher             = "200"
    timeout             = "3"
    path                = "/"
    unhealthy_threshold = "2"
  }
  
}

resource "aws_alb_listener" "tf_alb_listener" {
  load_balancer_arn = aws_alb.tf_alb.arn
  port              = var.alb_listener_property["ALB_PORT"]

  protocol = var.alb_listener_property["PROTOCOL"]
  default_action {
    target_group_arn = aws_alb_target_group.tf_alb_tg_default.arn
    type             = "redirect"

    redirect {
               host        = "#{host}"
               path        = "/#{path}"
               port        = "443"
               protocol    = "HTTPS"
               query       = "#{query}"
               status_code = "HTTP_301"
            }


  }
}

resource "aws_alb_listener" "tf_alb_listener_https" {
  load_balancer_arn = aws_alb.tf_alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = "${var.domainNameSSLCertificateArn}"

  default_action {
    target_group_arn = aws_alb_target_group.tf_alb_tg_default.arn
    type             = var.alb_listener_property["ACTION_TYPE"]
  }
}


/* ECS - Tasks Execution Role */

resource "aws_iam_role" "tf_iam_role_ecs_tasks_execution" {
  name               = "${var.project_name}-${var.project_region}-${var.project_environment}-ecs-task-execution-role"
  assume_role_policy = "${file("${path.module}/templates/ecs-task-execution-role.json")}"
  tags = merge(
    {"Name"="${var.project_name}-${var.project_region}-${var.project_environment}-ecs-task-execution-role"}
  )
}
resource "aws_iam_role_policy_attachment" "tf_iam_role_policy_attachment_ecs_tasks_execution" {
  role       = aws_iam_role.tf_iam_role_ecs_tasks_execution.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

/* ECS - Tasks Role */

resource "aws_iam_role" "tf_iam_role_ecs_tasks_role" {
  name               = "${var.project_name}-${var.project_region}-${var.project_environment}-ecs-task-role"
  assume_role_policy = "${file("${path.module}/templates/ecs-task-role.json")}"
  tags = merge(
    {"Name"="${var.project_name}-${var.project_region}-${var.project_environment}-ecs-task-execution-role"}
  )
}
resource "aws_iam_role_policy_attachment" "tf_iam_role_policy_attachment_ecs_tasks_role" {
  role       = aws_iam_role.tf_iam_role_ecs_tasks_role.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}

/*
resource "aws_wafv2_web_acl_association" "waf_us_alb" {
  resource_arn = aws_alb.tf_alb.arn
  web_acl_arn  = "arn:aws:wafv2:me-south-1:101925610273:regional/webacl/bounce-bahrain-uat-alb-waf/d26286a9-bc46-4597-9c05-404e5e065ad9"
}
*/
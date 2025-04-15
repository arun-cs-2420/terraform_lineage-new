locals {
  comon_tags = var.projectTags
}
resource "aws_ecr_repository" "tf_ecr_repository_lineage_ui" {
  name = "${var.projectName}-${var.project_region}-${var.microserviceName}-${var.projectEnvironment}-repo"

  tags = merge(
    local.common_tags, {"Name"= "${var.projectName}-${var.project_region}-${var.microserviceName}-${var.projectEnvironment}-repo"}
  )
  
}
resource "aws_ecr_lifecycle_policy" "tf_ecr_policy" {
  count = var.projectEnvironment == "dev" ? 1: 0
  repository = aws_ecr_repository.tf_ecr_repository_lineage_ui.name

  policy = <<EOF
{
  "rules": [
    {
      "rulePriority": 1,
      "description": "remove untagged images",
      "selection": {
        "tagStatus": "untagged",
        "countType": "imageCountMoreThan",
        "countNumber": 5
      },
      "action": {
        "type": "expire"
      }
    }
  ]
}
EOF
}

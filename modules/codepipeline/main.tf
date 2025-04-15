locals {
  common_tags = var.tags
}

/* Code build role */

resource "aws_iam_role" "tf_iam_role_code_build_role" {
  name               = "${var.project_name}-${var.project_region}-${var.project_environment}-codebuild-role"
  assume_role_policy = "${file("${path.module}/templates/codebuild-role.json")}"
  tags = merge(
    {"Name"="${var.project_name}-${var.project_region}-${var.project_environment}-codebuild-role"}
  )
}

resource "aws_iam_policy" "tf_iam_codebuild_policy" {
  name            = "${var.project_name}-${var.project_region}-${var.project_environment}-codebuild-policy"
  policy = "${file("${path.module}/templates/codebuild-policy.json")}"
  tags = merge(
    {"Name"="${var.project_name}-${var.project_region}-${var.project_environment}-codebuild-policy"}
  )
}

resource "aws_iam_role_policy_attachment" "tf_iam_codebuild_policy_attachment" {
  role       = aws_iam_role.tf_iam_role_code_build_role.name
  policy_arn = aws_iam_policy.tf_iam_codebuild_policy.arn
}

/* codepipeline role */

resource "aws_iam_role" "tf_iam_role_code_pipeline_role" {
  name               = "${var.project_name}-${var.project_region}-${var.project_environment}-codepipeline-role"
  assume_role_policy = "${file("${path.module}/templates/codepipeline-role.json")}"
  tags = merge(
    {"Name"="${var.project_name}-${var.project_region}-${var.project_environment}-codebuild-role"}
  )
}

resource "aws_iam_policy" "tf_iam_codepipeline_policy" {
  name            = "${var.project_name}-${var.project_region}-${var.project_environment}-codepipeline-policy"
  policy = "${file("${path.module}/templates/codepipeline-policy.json")}"
  tags = merge(
    {"Name"="${var.project_name}-${var.project_region}-${var.project_environment}-codebuild-policy"}
  )
}

resource "aws_iam_role_policy_attachment" "tf_iam_codepipeline_policy_attachment" {
  role       = aws_iam_role.tf_iam_role_code_pipeline_role.name
  policy_arn = aws_iam_policy.tf_iam_codepipeline_policy.arn
}
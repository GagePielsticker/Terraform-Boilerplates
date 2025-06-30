variable "env" {}
variable "repositories" {}

resource "aws_iam_role" "codebuild_role" {
  name = "${var.env}-tf-pipeline-cb-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect    = "Allow",
      Principal = {
        Service = "codebuild.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy" "codebuild_policy" { #Permissions given to underlying codebuilds that get created (service role)
  role = aws_iam_role.codebuild_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "logs:*",
          "s3:*"
        ],
        Resource = "*"
      }
    ]
  })
}

resource "aws_codebuild_project" "build" {
  for_each = { for inst in var.repositories : inst.name => inst } #Foreach only accepts sets/maps, not list. Transform list into readable form.
  name          = "${var.env}-${each.value.name}"
  description   = "Codebuild for ${each.value.name}"
  build_timeout = 5

  service_role = aws_iam_role.codebuild_role.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/amazonlinux-x86_64-standard:5.0"
    type                        = "LINUX_CONTAINER"
    privileged_mode             = false
  }

  source {
    type            = "CODEPIPELINE"
    buildspec       = "buildspec.yml"
  }
}
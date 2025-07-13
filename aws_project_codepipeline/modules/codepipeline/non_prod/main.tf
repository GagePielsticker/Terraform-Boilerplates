variable "env" {}
variable "repositories" {}
variable "github_connection_arn" {}

resource "aws_iam_role" "codepipeline_role" {
  name = "${var.env}-tf-pipeline-cp-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "codepipeline.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy" "codepipeline_policy" { #Permissions given to underlying codepipelines (service role)
  role = aws_iam_role.codepipeline_role.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "codebuild:BatchGetBuilds",
          "codebuild:StartBuild",
          "codestar-connections:UseConnection",
          "s3:*"
        ],
        Resource = "*"
      }
    ]
  })
}


resource "aws_codepipeline" "pipeline" {
  for_each = { for inst in var.repositories : inst.name => inst }
  name     = "${var.env}-${var.value.name}-pipeline"
  role_arn = aws_iam_role.codepipeline_role.arn

  artifact_store {
    location = "${var.env}-${each.value.name}-artifacts"
    type     = "S3"
  }

  stage {
    name = "Source"

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = ["source_output"]

      configuration = {
        ConnectionArn    = var.github_connection_arn
        FullRepositoryId = "${each.value.id}"
        BranchName       = "${each.value.branch}"
        DetectChanges    = "true"
      }
    }
  }

  stage {
    name = "Build"

    action {
      name             = "Build"
      category         = "Build"
      owner            = "AWS"
      provider         = "CodeBuild"
      input_artifacts  = ["source_output"]
      output_artifacts = ["build_output"]
      version          = "1"

      configuration = {
        ProjectName = "${var.env}-${each.value.name}"
      }
    }
  }
}
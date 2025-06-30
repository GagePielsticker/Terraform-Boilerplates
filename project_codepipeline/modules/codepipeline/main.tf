resource "aws_iam_role" "codepipeline_role" {
  name = "codepipeline-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect    = "Allow",
      Principal = {
        Service = "codepipeline.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy" "codepipeline_policy" {
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
  name     = "github-app-codepipeline"
  role_arn = aws_iam_role.codepipeline_role.arn

  artifact_store {
    location = "${var.env}-${env.value.name}-artifacts"
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
        ConnectionArn = var.github_connection_arn
        FullRepositoryId = "${each.value.id}"
        BranchName       = "${each.value.branch}"
        DetectChanges    = "true"
      }
    }
  }

  stage {
    for_each = var.env == "prod" ? [1] : [] # ONLY INCLUDE THIS STAGE FOR PRODUCTION ENVIRONMENT
    name = "Manual-Approval"

    action {
      run_order = 1
      name             = "AWS-Admin-Approval"
      category         = "Approval"
      owner            = "AWS"
      provider         = "Manual"
      version          = "1"
      input_artifacts  = []
      output_artifacts = []

      configuration = {
        CustomData = "Approval required to deploy production environment."
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
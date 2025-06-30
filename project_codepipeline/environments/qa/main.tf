module "s3_module" {
  source = "../../modules/s3"
}

module "codebuild_module" {
  source = "../../modules/codebuild"
}

module "codepipeline_module" {
  source = "../../modules/codepipeline"
}

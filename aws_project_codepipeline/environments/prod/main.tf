module "s3_module" {
  source       = "../../modules/s3"
  repositories = var.repositories
  env          = var.env
}

module "codebuild_module" {
  source       = "../../modules/codebuild"
  repositories = var.repositories
  env          = var.env
  depends_on   = [module.s3_module]
}

module "codepipeline_module" {
  source                = "../../modules/codepipeline/prod"
  repositories          = var.repositories
  env                   = var.env
  github_connection_arn = var.github_connection_arn
  depends_on            = [module.codebuild_module]
}

# STILL UNDER CONSTRUCTION
TODO
- [] Project_codepipeline (automated pipeline deployment for multi-app environments. Use github sources)
- [] fargate_loadbalancer (ECS, ECR + LB deployment of containers for standard docker deployments of things such as react apps etc)
- [] lambda_apigateway (serverless api deployment pattern)

# Foreword
> These are terraform examples and boilerplates for future projects or common needs. These should cover what I experience in day-to-day activity as a devops engineer. I created this partly as a way to learn the technology and partly to use in the future.

# Folder structure
I keep the various example projects within `example_projects/`. You can find the base structure in `project_base`, codepipeline setup in `project_codepipeline`, and the initial s3 state bucket creation in `state_s3_provisioning`.

# How to setup projects
Terraform cannot create resources prior to terraform init. To utilize an s3 bucket as the state file & lock backend, they must be created prior. As a result I threw together a quick s3 provisioning script in `./state_s3_provisioning` to do so. It enables versioning, disables deletion, and disables public access as per best practices. To deploy out any project you must first run this

`terraform init`

`terraform plan`

`terraform apply`

# Best Practices Followed
- [Style & Structure](https://cloud.google.com/docs/terraform/best-practices/general-style-structure)
- [Root Module Practices](https://cloud.google.com/docs/terraform/best-practices/root-modules)
- [State Locking](https://rafaelmedeiros94.medium.com/goodbye-dynamodb-terraform-s3-backend-now-supports-native-locking-06f74037ad39)
- [Cost Allocation Tags](https://docs.aws.amazon.com/awsaccountbilling/latest/aboutv2/cost-alloc-tags.html)
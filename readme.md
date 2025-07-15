# Foreword
> These are terraform examples and boilerplates for future projects or common needs. These should cover what I experience in day-to-day activity as a devops engineer. I created this partly as a way to learn the technology and partly to use in the future.

# Projects
[AWS Project Base](/aws_project_base/) 
> The base folder structure you should use for terraform projects. This is following googles best practices outlined by [their documentation](https://cloud.google.com/docs/terraform/best-practices/general-style-structure)

[Datadog Monitors](/datadog_infrastructure_alarms/)
> Datadog infrastructure monitors + synthetic test example. Has a few pre-configured monitors and examples of how to setup more.

[AWS Cost Alarms](/aws_cost_alarms/)
> AWS Budgets Alarming Setup. Good for new accounts to get emailed if projected budget goes over certain thresholds.

[AWS S3 Provisioner](/aws_s3_provisioning/)
> Quick script to deploy s3 buckets

[AWS Scheduled Lambda](/aws_scheduled_lambda/)
> Eventbridge scheduler + lambda setup for simple jobs.

[AWS API-Gateway Lambda](/aws_apigw_lambda/)
> HTTP API Gateway Configured with lambda endpoints. Modularized the lambda config as much as possible so you can just drop new ones in simply.

[AWS Project Codepipeline](/aws_project_codepipeline/)
> Automated codepipeline deployer. It stands up new codepipelines for every repo listed in the variables. The codepipelines it stands up pulls from github and runs a default buildspec.yml. Good if you have a bunch of repo's that need a quick and dirty pipeline setup with centralized management of these pipelines.

[Github Repository](/github_repository/) 
> Simple github repository configurator that stands up new repos following standard gitflow practices & branch rules.

[AWS Cloudwatch Expirations](/aws_cloudwatch_expiration/)
> Simple JS script for modifying every log groups expiration times.

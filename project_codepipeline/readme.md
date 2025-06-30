# Automatic Pipeline Creation
This automatically runs through a list of repos and will create pipelines for each following best standards. This project assumes a few things defaultly:

- There are a `dev`, `qa`, and `prod` environments for your project.
- These envs are their own branches on repositories hosted on github.
- There are two seperate pipeline variations, one for `non-prod` and one for `prod`. The `prod` pipeline requires manual approval ontop of `non-prods` pipeline.
- The underlying pipelines that get created are simply invoked/deployed by a `buildspec.yml`. Nothing fancy.
- An s3 bucket exist for state of the pipeline creator in each AWS environment. (Refer to s3 provisioner in repo to create them.)

## Important note
This does not automatically create potentially needed resources for underlying pipelines (such as new s3 buckets for states of the pipelines), just the pipelines themself.

## How to use
In each respective env folder such as `environments/dev/` there are 3 files. `backend.tf` contains the s3 bucket to use for the pipeline creator states as well as tags to attach to all the pipelines. `variable.tf` contains a list of repos & branches, and also the arn of the github app connection to use. 

Modify these values to match your respective needs then manually create a codepipeline/codebuild for the pipeline creator. Make sure to define in each environment you make the folder it should reference in the env vars of the build. Have it run the buildspec.yml as the build step and you are good to go!

It has centrally managed roles used across all pipelines, and creates a new codepipeline & codebuild for each respective project in each env as defined in the variable.tf

## How to add new envs
Simply create a new manual pipeline for the pipeline creator, copy another envs folder, and have it reference that in the builds env vars. Done!
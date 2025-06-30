This has 2 required dependencies to use
- a github connection within codepipeline (for sourcing code from repos)
- an s3 bucket for state files (within each envs `backend.tf`)

you can deploy bucket via state s3 prov
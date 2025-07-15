# LAMBDA & HTTP Module Based Terraform
This is a lambda / api-gateway deployer that deploys out basic http api's. You can add/remove lambdas within the `/src` folder and modifying the `lambda_definitions/main.tf`. You can modify api gateway name & config via `main.tf`.

I tried to modularize it as much as possible. Just re-use the modules located in `lambda_definitions` to modify/add lambdas etc.
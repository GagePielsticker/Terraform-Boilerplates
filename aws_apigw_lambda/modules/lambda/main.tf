module "s3_artifact_bucket" {
  source = "../s3"
}

data "archive_file" "lambda_zip" {
  type        = "zip"
  source_dir  = "${path.module}/../../${var.lambda_file_path}"
  output_path = "${path.module}/../../${var.lambda_file_path}/${var.lambda_name}.zip"
  excludes    = ["*.zip"]
}

resource "random_id" "server" {
  keepers = {
    # Generate a new id each time we switch to a new AMI id
    lambda_name = var.lambda_name
  }

  byte_length = 8
}

resource "aws_s3_object" "lambda_app" {
  bucket = module.s3_artifact_bucket.bucket_id
  key    = "source.zip"
  source = data.archive_file.lambda_zip.output_path
  etag   = filemd5(data.archive_file.lambda_zip.output_path)
}

resource "aws_cloudwatch_log_group" "lambda_logs" {
  name              = "/aws/lambda/${var.lambda_name}-${random_id.server.id}"
  retention_in_days = var.log_retention
}

resource "aws_lambda_function" "app" {
  function_name = "${var.lambda_name}-${random_id.server.id}"
  description   = var.lambda_description

  s3_bucket = module.s3_artifact_bucket.bucket_id
  s3_key    = aws_s3_object.lambda_app.key

  runtime = var.lambda_runtime
  handler = var.lambda_handler

  memory_size = var.memory_size
  timeout     = var.timeout

  source_code_hash = data.archive_file.lambda_zip.output_base64sha256

  role       = var.lambda_role.arn
  depends_on = [aws_cloudwatch_log_group.lambda_logs]
}

resource "aws_lambda_permission" "apigw_invoke" {
  statement_id  = "AllowAPIGatewayInvoke"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.app.function_name
  principal     = "apigateway.amazonaws.com"
}

module "new_route" {
  source      = "../api-gateway-route"
  api_gateway = var.api_gateway
  route       = var.route
  method      = var.method
  lambda      = aws_lambda_function.app
}
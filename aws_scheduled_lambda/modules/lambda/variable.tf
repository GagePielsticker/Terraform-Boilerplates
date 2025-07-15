variable "lambda_file_path" {
  type        = string
  description = "Path where lambda source code is stored and should be zipped from"
}

variable "lambda_name" {
  type        = string
  description = "Lambda functions name"
}

variable "lambda_description" {
  type        = string
  description = "Lambda function description"
  default     = "Deployed Lambda Function"
}

variable "lambda_runtime" {
  type        = string
  description = "Lambda runtime" #nodejs22.x
}

variable "lambda_handler" {
  type        = string
  description = "Handler for lambda"
}

variable "log_retention" {
  type        = number
  description = "Log in days to expire log group logs. 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1096, 1827, 2192, 2557, 2922, 3288, 3653"
  default     = 14
}

variable "lambda_role" {
  description = "Lambda Execution Role"
}

variable "memory_size" {
  default     = 1024
  type        = number
  description = "Memory size to allocate to lambda"
}

variable "timeout" {
  default     = 30
  type        = number
  description = "Timeout in seconds for lambda"
}
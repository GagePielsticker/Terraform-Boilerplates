variable "apigateway_name" {
  type        = string
  default     = "MyAPI"
  description = "Name of the api gateway to deploy"
}

variable "apigateway_description" {
  type        = string
  default     = "A Test API"
  description = "Description of API"
}
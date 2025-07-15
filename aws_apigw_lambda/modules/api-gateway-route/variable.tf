variable "api_gateway" {

}

variable "lambda" {

}

variable "route" {
  type        = string
  description = "Route to use"
}

variable "method" {
  type        = string
  description = "Method to use"
}
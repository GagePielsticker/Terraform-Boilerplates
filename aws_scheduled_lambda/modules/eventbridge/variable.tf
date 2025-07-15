variable "schedule_rate" {
  type        = string
  description = "Rate at which the schedule should go off"
  default     = "rate(1 hours)"
}

variable "schedule_name" {
  type        = string
  description = "Name of the event bridge schedule to create"
}

variable "schedule_description" {
  type        = string
  description = "Description of the schedule"
  default     = "Deployed Schedule"

}

variable "lambda_arn" {
  type        = string
  description = "Arn of lambda to put on schedule"
}
variable "application_name" {
  type        = string
  description = "Application Name"
}
variable "aws_region" {
  type = string
}

variable "datadog_api_key" {
  type        = string
  description = "Datadog API Key"
}

variable "datadog_app_key" {
  type        = string
  description = "Datadog Application Key"
}

variable "org_name" {
  type = string
}

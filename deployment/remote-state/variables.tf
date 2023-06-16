variable "name" {
  description = "the name of your stack, e.g. \"demo\""
}
variable "environment" {
  description = "the name of your environment, e.g. \"prod\""
  default     = "prod"
}
variable "region" {
  type        = string
  description = "AWS region to set state on"
  default     = "eu-central-1"
}

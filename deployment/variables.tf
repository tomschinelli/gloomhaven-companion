# ---- connections ---- #
variable "cloudflare_token" {
  type        = string
  description = "API token for cloudflare"
}
variable "cloudflare_account_id" {
  type        = string
  description = "Cloudflare account id"
}

variable "aws_region" {
  type        = string
  description = "aws region"
  default     = "eu-central-1"
}

variable "ghcr_username" {
  type = string
}
variable "ghcr_password" {
  type = string
}


# ---- application ---- #
variable "container_image" {
  type        = string
  description = "Image to deploy to ecs. Should contain tag"
}

variable "prefix" {
  type        = string
  description = "Resource prefix"
}
variable "app_name" {
  type        = string
  description = "Application Name"
}

variable "app_environment" {
  type        = string
  description = "Application Environment"
}


# ---- dns ---- #

variable "domain_name" {
  type        = string
  description = "Domain name"
}

variable "cloudflare_zone" {
  type        = string
  description = "Cloudflare zone"
}


# ---- network ---- #

variable "cidr" {
  description = "The CIDR block for the VPC."
}

variable "public_subnets" {
  description = "List of public subnets"
}

variable "private_subnets" {
  description = "List of private subnets"
}

variable "availability_zones" {
  description = "List of availability zones"
}
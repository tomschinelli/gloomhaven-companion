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


variable "env_name" {
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
  type = list(string)
}

variable "private_subnets" {
  description = "List of private subnets"
  type = list(string)

}

variable "availability_zones" {
  description = "List of availability zones"
  type = list(string)

}
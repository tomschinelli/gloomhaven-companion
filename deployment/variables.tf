variable "cloudflare_token" {
  type        = string
  description = "API token for cloudflare"
}
variable "cloudflare_account_id" {
  type        = string
  description = "Cloudflare account id"
}

variable "cloudflare_zone" {
  type        = string
  description = "Cloudflare zone"
}


variable "domain_name" {
  type        = string
  description = "Domain name"
}
variable "container_image" {
  type        = string
  description = "Image to deploy to ecs. Should contain tag"
}


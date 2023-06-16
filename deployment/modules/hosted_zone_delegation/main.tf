terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 3.0"
    }
  }
}


resource "aws_route53_zone" "gloomhaven_companion" {
  name = var.domain_name
}

data "cloudflare_zone" "gloomhaven_companion" {
  account_id = var.cloudflare_account_id
  name       = var.cloudflare_zone
}
resource "cloudflare_record" "gloomhaven_companion" {
  count = 4
  zone_id = data.cloudflare_zone.gloomhaven_companion.id
  name    = var.domain_name
  value = element(aws_route53_zone.gloomhaven_companion.name_servers, count.index)

  type    = "NS"

}

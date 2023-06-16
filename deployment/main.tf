module "gloomhaven_companion" {
  source                = "./modules/hosted_zone_delegation"
  domain_name           = var.domain_name
  cloudflare_account_id = var.cloudflare_account_id
  cloudflare_zone       = var.cloudflare_zone
}
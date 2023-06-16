domain_name           = "companion.gloomhaven.tomschinelli.io"
cloudflare_account_id = "657a56c8bdb8f013919004e139c98591"
cloudflare_zone       = "tomschinelli.io"

prefix = "gloomhaven-companion-prod"
app_environment = "prod"
app_name = "gloomhaven-companion"

cidr     = "10.10.0.0/16"
availability_zones = ["eu-central-1a","eu-central-1b"]
public_subnets     = ["10.10.100.0/24", "10.10.101.0/24"]
private_subnets    = ["10.10.0.0/24", "10.10.1.0/24"]
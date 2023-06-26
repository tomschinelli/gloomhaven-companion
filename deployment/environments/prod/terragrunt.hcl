include {
  path = find_in_parent_folders()
}
terraform {
  source = "../../src"
}

inputs = {
  aws_region = "eu-central-1"

  domain_name           = "companion.gloomhaven.tomschinelli.io"
  cloudflare_account_id = "657a56c8bdb8f013919004e139c98591"
  cloudflare_zone       = "tomschinelli.io"
  container_image       = "ghcr.io/tomschinelli/gloomhaven-companion:latest"

  cidr               = "10.0.0.0/16"
  availability_zones = ["eu-central-1a", "eu-central-1b"]
  public_subnets     = ["10.0.100.0/24", "10.0.101.0/24"]
  private_subnets    = ["10.0.0.0/24", "10.0.1.0/24"]
}


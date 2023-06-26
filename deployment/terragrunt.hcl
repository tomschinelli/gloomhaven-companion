locals  {

  env_name = replace(path_relative_to_include(), "environments/", "")
}


inputs = {
  env_name = local.env_name
  prefix   = "gloomhaven-companion-${local.env_name}"
  app_name = "gloomhaven-companion"

}


remote_state {
  backend = "s3"
  generate = {
    path = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    bucket = "gloomhaven-companion-terraform-state" # Amazon S3 bucket required

    key     = "${local.env_name}/terraform.tfstate"
    region  = "eu-central-1"
    encrypt = true
  }
}
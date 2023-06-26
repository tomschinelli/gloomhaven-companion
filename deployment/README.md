## Deployment


### Run terraform plan locally
```shell
export CLOUFLARE_TOKEN="<CLOUFLARE_TOKEN>"
export GITHUB_TOKEN="<GITHUB_TOKEN>"
export APP_ENV=prod

export TF_VAR_aws_access_key=`aws configure get default.aws_access_key_id`
export TF_VAR_aws_secret_key=`aws configure get default.aws_secret_access_key`
export TF_VAR_cloudflare_token="$CLOUFLARE_TOKEN"
export TF_VAR_ghcr_username="tomschinelli"
export TF_VAR_ghcr_password="$GITHUB_TOKEN"

cd environemnts/$APP_ENV

terragrunt init 
terraform apply
```

### To-Do

#### Modules
create modules for: 

- network
- ecs
- dns + ssl
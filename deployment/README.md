Run terraform plan locally
```shell
export CLOUFLARE_TOKEN="<CLOUFLARE_TOKEN>"
export GITHUB_TOKEN="<GITHUB_TOKEN>"

terraform init 

terraform apply \
  -var="cloudflare_token=$CLOUFLARE_TOKEN" \
  -var="container_image=ghcr.io/tomschinelli/gloomhaven-companion:latest" \
  -var="ghcr_username=tomschinelli" \
  -var="ghcr_password=$GITHUB_TOKEN" 
  
```
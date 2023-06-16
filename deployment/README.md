Run terraform plan locally
```shell
export CLOUFLARE_TOKEN="<CLOUFLARE_TOKEN>"
export IMAGE="ghcr.io/tomschinelli/gloomhaven-companion:latest"

terraform init 
terraform plan \
  -var="cloudflare_token=$CLOUFLARE_TOKEN" \
  -var="container_image=$IMAGE"
  
terraform apply \
  -var="cloudflare_token=$CLOUFLARE_TOKEN" \
  -var="container_image=$IMAGE"
```
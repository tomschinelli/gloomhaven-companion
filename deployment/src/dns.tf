
resource "aws_route53_zone" "gloomhaven_companion" {
  name = var.domain_name
}

data "cloudflare_zone" "gloomhaven_companion" {
  account_id = var.cloudflare_account_id
  name       = var.cloudflare_zone


}
resource "cloudflare_record" "gloomhaven_companion" {
  count   = 4
  zone_id = data.cloudflare_zone.gloomhaven_companion.id
  name    = var.domain_name
  value   = element(aws_route53_zone.gloomhaven_companion.name_servers, count.index)
  depends_on = [
    aws_route53_zone.gloomhaven_companion
  ]
  type = "NS"

}


resource "aws_acm_certificate" "gloomhaven_companion" {
  domain_name       = aws_route53_record.app.fqdn
  validation_method = "DNS"
  lifecycle {
    create_before_destroy = true
  }
}
resource "aws_route53_record" "cert_validation" {
  allow_overwrite = true
  name            = tolist(aws_acm_certificate.gloomhaven_companion.domain_validation_options)[0].resource_record_name
  records         = [
    tolist(aws_acm_certificate.gloomhaven_companion.domain_validation_options)[0].resource_record_value
  ]
  type            = tolist(aws_acm_certificate.gloomhaven_companion.domain_validation_options)[0].resource_record_type
  zone_id         = aws_route53_zone.gloomhaven_companion.id
  ttl             = 60
}
resource "aws_acm_certificate_validation" "cert" {
  certificate_arn         = aws_acm_certificate.gloomhaven_companion.arn
  validation_record_fqdns = [aws_route53_record.cert_validation.fqdn]
}



resource "aws_route53_record" "app" {
  zone_id = aws_route53_zone.gloomhaven_companion.zone_id
  name    = var.domain_name
  type    = "A"
  alias {
    name                   = aws_alb.application_load_balancer.dns_name
    zone_id                = aws_alb.application_load_balancer.zone_id
    evaluate_target_health = false
  }
}
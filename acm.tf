//cloudfront only works with certificates in us-east-1
provider "aws" {
  alias   = "virginia"
  region  = "us-east-1"
  profile = "terraform"
}

resource "aws_acm_certificate" "this" {
  domain_name       = var.domainName
  validation_method = "DNS"

  tags                      = var.tags
  subject_alternative_names = [var.wwwDomainName]
  lifecycle {
    create_before_destroy = true
  }
  provider = aws.virginia

}

resource "aws_route53_record" "validation" {
  for_each = {
    for dvo in aws_acm_certificate.this.domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      record = dvo.resource_record_value
      type   = dvo.resource_record_type
    }
  }

  allow_overwrite = true
  name            = each.value.name
  records         = [each.value.record]
  ttl             = 60
  type            = each.value.type
  zone_id         = aws_route53_zone.primary.zone_id
  provider        = aws.virginia
  depends_on = [
    aws_acm_certificate.this,
    aws_route53_zone.primary
  ]
}

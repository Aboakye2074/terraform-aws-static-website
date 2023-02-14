resource "aws_route53_zone" "primary" {
  name = var.domainName
  tags = var.tags
}

resource "aws_route53_record" "tonboazztek-com" {
  name    = var.domainName
  type    = "A"
  zone_id = aws_route53_zone.primary.zone_id

  alias {
    name                   = aws_cloudfront_distribution.tonboazztek-com-s3_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.tonboazztek-com-s3_distribution.hosted_zone_id
    evaluate_target_health = false
  }

}

resource "aws_route53_record" "www-tonboazztek-com" {
  name    = var.wwwDomainName
  type    = "A"
  zone_id = aws_route53_zone.primary.zone_id

  alias {
    name                   = aws_cloudfront_distribution.www-tonboazztek-com-s3_distribution.domain_name
    zone_id                = aws_cloudfront_distribution.www-tonboazztek-com-s3_distribution.hosted_zone_id
    evaluate_target_health = false
  }
}

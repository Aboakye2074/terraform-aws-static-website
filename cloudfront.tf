resource "aws_cloudfront_distribution" "bahaanoah-com-s3_distribution" {
  origin {
    domain_name         = aws_s3_bucket_website_configuration.this.website_endpoint
    origin_id           = aws_s3_bucket_website_configuration.this.website_endpoint
    connection_attempts = 3
    connection_timeout  = 10


    custom_origin_config {
      http_port                = 80
      https_port               = 443
      origin_keepalive_timeout = 5
      origin_protocol_policy   = "http-only"
      origin_read_timeout      = 30
      origin_ssl_protocols = [
        "TLSv1",
        "TLSv1.1",
        "TLSv1.2",
      ]
    }
  }

  enabled         = true
  is_ipv6_enabled = true

  aliases = [var.domainName]

  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = aws_s3_bucket_website_configuration.this.website_endpoint
    viewer_protocol_policy = "redirect-to-https"
    compress               = true
    default_ttl            = 0
    max_ttl                = 0
    min_ttl                = 0
    smooth_streaming       = false
    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
  }


  restrictions {
    geo_restriction {
      locations        = []
      restriction_type = "none"
    }
  }

  tags = var.tags

  viewer_certificate {
    acm_certificate_arn            = aws_acm_certificate.this.arn
    cloudfront_default_certificate = false
    minimum_protocol_version       = "TLSv1.2_2021"
    ssl_support_method             = "sni-only"
  }

  depends_on = [
    aws_s3_bucket.this,
    aws_acm_certificate.this
  ]
}




resource "aws_cloudfront_distribution" "www-bahaanoah-com-s3_distribution" {
  origin {
    domain_name         = aws_s3_bucket_website_configuration.thisWWW.website_endpoint
    origin_id           = aws_s3_bucket_website_configuration.thisWWW.website_endpoint
    connection_attempts = 3
    connection_timeout  = 10


    custom_origin_config {
      http_port                = 80
      https_port               = 443
      origin_keepalive_timeout = 5
      origin_protocol_policy   = "http-only"
      origin_read_timeout      = 30
      origin_ssl_protocols = [
        "TLSv1",
        "TLSv1.1",
        "TLSv1.2",
      ]
    }
  }

  enabled         = true
  is_ipv6_enabled = true

  aliases = [var.wwwDomainName]

  default_cache_behavior {
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    target_origin_id       = aws_s3_bucket_website_configuration.thisWWW.website_endpoint
    viewer_protocol_policy = "redirect-to-https"
    compress               = true
    default_ttl            = 0
    max_ttl                = 0
    min_ttl                = 0
    smooth_streaming       = false
    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
  }


  restrictions {
    geo_restriction {
      locations        = []
      restriction_type = "none"
    }
  }

  tags = var.tags

  viewer_certificate {
    acm_certificate_arn            = aws_acm_certificate.this.arn
    cloudfront_default_certificate = false
    minimum_protocol_version       = "TLSv1.2_2021"
    ssl_support_method             = "sni-only"
  }

  depends_on = [
    aws_s3_bucket.thisWWW,
    aws_acm_certificate.this
  ]
}

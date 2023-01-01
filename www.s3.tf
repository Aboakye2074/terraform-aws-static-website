resource "aws_s3_bucket" "thisWWW" {
  bucket = var.wwwDomainName
  tags   = var.tags
}

resource "aws_s3_bucket_policy" "www_allow_public_access" {
  bucket = aws_s3_bucket.thisWWW.id
  policy = jsonencode(
    {
      Statement = [
        {
          Action    = "s3:GetObject"
          Effect    = "Allow"
          Principal = "*"
          Resource  = "arn:aws:s3:::${var.wwwDomainName}/*"
          Sid       = "Stmt1661600983594"
        },
      ]
      Version = "2012-10-17"
    }
  )
}

resource "aws_s3_bucket_versioning" "thisRedirect" {
  bucket = aws_s3_bucket.thisWWW.id
  versioning_configuration {
    status = "Disabled"
  }
}

resource "aws_s3_bucket_website_configuration" "thisWWW" {
  bucket = aws_s3_bucket.thisWWW.bucket

  index_document {
    suffix = "index.html"
  }
  error_document {
    key = "error.html"
  }
}

# s3 Bucket
resource "aws_s3_bucket" "s3_bucket" {
  bucket = var.bucket_name

  tags = {
    Name        = "static-website"
    Environment = "dev"
    ManagedBy   = "Terraform"
  }
}

# Block all public access
resource "aws_s3_bucket_public_access_block" "s3_bucket" {
  bucket = aws_s3_bucket.s3_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Enable bucket versioning
resource "aws_s3_bucket_versioning" "website" {
  bucket = aws_s3_bucket.s3_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

# upload website files
resource "aws_s3_object" "index" {
  bucket       = aws_s3_bucket.s3_bucket.id
  key          = "index.html"
  source       = "${path.module}/website/index.html"
  content_type = "text/html"
  etag         = filemd5("${path.module}/website/index.html")
}

# cloudfront origin access control
resource "aws_cloudfront_origin_access_control" "website" {
  name                              = "static-website-oac"
  description                       = "OAC for private S3 website bucket"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

# cloudfront distribution
resource "aws_cloudfront_distribution" "website" {
  enabled             = true
  default_root_object = "index.html"
  comment             = "Static website CDN"

  origin {
    domain_name              = aws_s3_bucket.s3_bucket.bucket_regional_domain_name
    origin_id                = "s3-static-website"
    origin_access_control_id = aws_cloudfront_origin_access_control.website.id
  }

  default_cache_behavior {
    target_origin_id       = "s3-static-website"
    viewer_protocol_policy = "redirect-to-https"

    allowed_methods = ["GET", "HEAD"]
    cached_methods  = ["GET", "HEAD"]

    compress = true

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }
  }

  # Return index.html for root url
  custom_error_response {
    error_code         = 403
    response_code      = 200
    response_page_path = "/index.html"
  }

  custom_error_response {
    error_code         = 404
    response_code      = 200
    response_page_path = "/index.html"
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  tags = {
    Environment = "dev"
    ManagedBy   = "Terraform"
  }
}

# S3 Bucket Policy
# Allow CloudFront to read objects
data "aws_iam_policy_document" "cloudfront_access" {
  statement {
    sid    = "AllowCloudFrontServicePrincipalReadOnly"
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["cloudfront.amazonaws.com"]
    }

    actions = ["s3:GetObject"]

    resources = ["${aws_s3_bucket.s3_bucket.arn}/*"]

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"

      values = [aws_cloudfront_distribution.website.arn]
    }
  }
}

resource "aws_s3_bucket_policy" "website" {
  bucket = aws_s3_bucket.s3_bucket.id
  policy = data.aws_iam_policy_document.cloudfront_access.json

  depends_on = [aws_s3_bucket_public_access_block.s3_bucket]
}



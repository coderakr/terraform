output "s3_bucket_name" {
  description = "s3 bucket name"
  value       = aws_s3_bucket.s3_bucket.bucket
}

output "cloudfront_distribution_id" {
  description = "CloudFront distribution ID"
  value       = aws_cloudfront_distribution.website.id
}

output "website_url" {
  description = "CloudFront distribution domain name"
  value       = "https://${aws_cloudfront_distribution.website.domain_name}"
}

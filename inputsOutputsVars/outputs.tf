output "s3_bucket_name" {
  value = local.bucket_name
}

output "aws_s3_bucket_tag_name" {
  value = var.s3_bucket_tag_name
}

output "Environment" {
  value = var.s3_bucket_environment
}

resource "aws_s3_bucket" "test" {
  bucket = local.bucket_name

  tags = {
    Name        = var.s3_bucket_tag_name
    Environment = var.s3_bucket_environment
  }
}

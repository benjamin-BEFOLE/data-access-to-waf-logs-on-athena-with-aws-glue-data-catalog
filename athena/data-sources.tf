data "aws_s3_objects" "log_objects" {
  bucket = var.log_bucket_name
  prefix = var.log_bucket_prefix
}

resource "aws_s3_object" "athena_queries_folder" {
  bucket        = var.log_bucket_name
  key           = "athena-queries"
  force_destroy = true
}

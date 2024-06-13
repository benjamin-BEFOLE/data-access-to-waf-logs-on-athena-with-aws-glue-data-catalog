locals {
  list_date_string = distinct([for key in data.aws_s3_objects.log_objects.keys : join("/", slice(split("/", trimprefix(key, "${var.log_bucket_prefix}/")), 0, var.partition_length))])
  list_date        = zipmap(local.list_date_string, [for str in local.list_date_string : split("/", str)])
}

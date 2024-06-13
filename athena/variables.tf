variable "aws_region" {
  type = string
}

variable "log_bucket_name" {
  type    = string
  default = "<your-log-bucket-name>"
}

variable "log_bucket_prefix" {
  type    = string
  default = "<your-log-bucket-prefix>"
}

variable "partition_length" {
  type    = number
  default = 5
}

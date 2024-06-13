variable "aws_region" {
  type = string
}

variable "log_bucket_name" {
  type    = string
  default = "aws-waf-logs-16465462542"
}

variable "log_bucket_prefix" {
  type    = string
  default = "AWSLogs/583086777388/WAFLogs/us-east-1/CreatedByALB-36139537e283231f"
}

variable "partition_length" {
  type    = number
  default = 5
}

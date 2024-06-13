resource "aws_athena_workgroup" "log" {
  name          = "workgroup-log"
  force_destroy = true

  configuration {
    enforce_workgroup_configuration    = true
    publish_cloudwatch_metrics_enabled = true

    engine_version {
      selected_engine_version = "AUTO"
    }

    result_configuration {
      output_location = "s3://${var.log_bucket_name}/${aws_s3_object.athena_queries_folder.key}"

      encryption_configuration {
        encryption_option = "SSE_S3"
      }
    }
  }
}

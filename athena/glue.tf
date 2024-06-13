# Create database `logs`
resource "aws_glue_catalog_database" "db_logs" {
  name = "logs"
}

# Create table `waf_log`
resource "aws_glue_catalog_table" "t_waf_log" {
  name          = "waf_log"
  database_name = "logs"

  table_type = "EXTERNAL_TABLE"

  parameters = {
    EXTERNAL = "TRUE"
  }

  partition_keys {
    name = "year"
    type = "string"
  }

  partition_keys {
    name = "month"
    type = "string"
  }

  partition_keys {
    name = "day"
    type = "string"
  }

  partition_keys {
    name = "hour"
    type = "string"
  }

  partition_keys {
    name = "minute"
    type = "string"
  }

  storage_descriptor {
    location      = "s3://${var.log_bucket_name}/${var.log_bucket_prefix}"
    input_format  = "org.apache.hadoop.mapred.TextInputFormat"
    output_format = "org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat"
    compressed    = true

    ser_de_info {
      serialization_library = "org.openx.data.jsonserde.JsonSerDe"
    }

    columns {
      name = "timestamp"
      type = "bigint"
    }

    columns {
      name = "formatversion"
      type = "int"
    }

    columns {
      name = "webaclid"
      type = "string"
    }

    columns {
      name = "terminatingruleid"
      type = "string"
    }

    columns {
      name = "terminatingruletype"
      type = "string"
    }

    columns {
      name = "action"
      type = "string"
    }

    columns {
      name = "terminatingrulematchdetails"
      type = "array<string>"
    }

    columns {
      name = "httpsourcename"
      type = "string"
    }

    columns {
      name = "httpsourceid"
      type = "string"
    }

    columns {
      name = "rulegrouplist"
      type = "array<string>"
    }

    columns {
      name = "ratebasedrulelist"
      type = "array<string>"
    }

    columns {
      name = "nonterminatingmatchingrules"
      type = "array<struct<ruleId:string,action:string>>"
    }

    columns {
      name = "httprequest"
      type = "struct<clientIp:string,country:string,headers:array<struct<name:string,value:string>>,uri:string,args:string,httpVersion:string,httpMethod:string,requestId:string>"
    }
  }
}

# Add Partitions to table `waf_log`
resource "aws_glue_partition" "example" {
  for_each = local.list_date

  database_name    = aws_glue_catalog_database.db_logs.name
  table_name       = aws_glue_catalog_table.t_waf_log.name
  partition_values = each.value

  storage_descriptor {
    location      = "s3://${var.log_bucket_name}/${var.log_bucket_prefix}/${join("/", each.value)}"
    input_format  = "org.apache.hadoop.mapred.TextInputFormat"
    output_format = "org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat"
    compressed    = true

    ser_de_info {
      serialization_library = "org.openx.data.jsonserde.JsonSerDe"
    }
  }
}

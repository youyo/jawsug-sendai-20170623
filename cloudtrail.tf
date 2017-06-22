resource "aws_cloudtrail" "cloudtrail" {
  name                          = "cloudtrail"
  enable_logging                = true
  s3_bucket_name                = "${aws_s3_bucket.log.id}"
  include_global_service_events = true
  is_multi_region_trail         = true
  enable_log_file_validation    = true
  depends_on                    = ["aws_s3_bucket_policy.log"]
}

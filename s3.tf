resource "aws_s3_bucket" "log" {
  bucket        = "${var.env}-log-jawsug-sendai"
  region        = "${var.aws_region}"
  acl           = "log-delivery-write"
  force_destroy = true
}

data "aws_iam_policy_document" "log" {
  statement {
    sid       = "AWSCloudTrailAclCheck"
    effect    = "Allow"
    actions   = ["s3:GetBucketAcl"]
    resources = ["arn:aws:s3:::${aws_s3_bucket.log.id}"]

    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }
  }

  statement {
    sid       = "AWSCloudTrailWrite"
    effect    = "Allow"
    actions   = ["s3:PutObject"]
    resources = ["arn:aws:s3:::${aws_s3_bucket.log.id}/*"]

    principals {
      type        = "Service"
      identifiers = ["cloudtrail.amazonaws.com"]
    }

    condition {
      test     = "StringEquals"
      variable = "s3:x-amz-acl"
      values   = ["bucket-owner-full-control"]
    }
  }
}

resource "aws_s3_bucket_policy" "log" {
  bucket     = "${aws_s3_bucket.log.id}"
  policy     = "${data.aws_iam_policy_document.log.json}"
  depends_on = ["aws_s3_bucket.log"]
}

resource "aws_s3_bucket" "test" {
  bucket        = "${var.env}-test-jawsug-sendai"
  region        = "${var.aws_region}"
  acl           = "private"
  force_destroy = true
}

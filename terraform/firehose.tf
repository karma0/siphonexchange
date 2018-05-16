# S3 Bucket
resource "aws_s3_bucket" "bucket" {
  bucket = "${var.app_name}"
  acl    = "private"
}

# Firehose
resource "aws_kinesis_firehose_delivery_stream" "app_stream" {
  name        = "${var.app_name}-stream"
  destination = "extended_s3"
  extended_s3_configuration {
    role_arn   = "${aws_iam_role.firehose_role.arn}"
    bucket_arn = "${aws_s3_bucket.bucket.arn}"
  }
}

# Firehose role
resource "aws_iam_role" "firehose_role" {
  name = "${var.app_name}-role"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "firehose.amazonaws.com"
      },
      "Effect": "Allow"
    }
  ]
}
EOF
}

# firehose access to S3, etc
resource "aws_iam_role_policy" "firehose_inline_policy" {
  name   = "${var.app_name}_firehose_inline_policy"
  role   = "${aws_iam_role.firehose_role.name}"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:AbortMultipartUpload",
        "s3:GetBucketLocation",
        "s3:GetObject",
        "s3:ListBucket",
        "s3:ListBucketMultipartUploads",
        "s3:PutObject"
      ],
      "Resource": [
        "${aws_s3_bucket.bucket.arn}",
        "${aws_s3_bucket.bucket.arn}/*"
      ]
    },
    {
      "Effect": "Allow",
      "Action": [
        "kinesis:DescribeStream",
        "kinesis:GetShardIterator",
        "kinesis:GetRecords"
      ],
      "Resource": "${aws_kinesis_firehose_delivery_stream.app_stream.arn}"
    }
  ]
}
EOF
}

# Specified IAM role access to firehose
resource "aws_iam_role_policy" "user_inline_policy" {
  name   = "${var.app_name}_user_firehose_inline_policy"
  role   = "${var.aws_iam_role_name}"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "firehose:PutRecord"
      ],
      "Resource": "${aws_kinesis_firehose_delivery_stream.app_stream.arn}"
    }
  ]
}
EOF
}

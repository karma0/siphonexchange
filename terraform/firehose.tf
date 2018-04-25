resource "aws_s3_bucket" "bucket" {
  bucket = "${var.app_name}"
  acl    = "private"
}

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
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_kinesis_firehose_delivery_stream" "app_stream" {
  name        = "${var.app_name}-stream"
  destination = "s3"

  s3_configuration {
    role_arn   = "${aws_iam_role.firehose_role.arn}"
    bucket_arn = "${aws_s3_bucket.bucket.arn}"
  }
}

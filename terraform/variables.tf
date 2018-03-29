variable "aws_region" {
  description = "The chosen region for the application."
  default = "us-east-1"
}

variable "app_name" {
  description = "The name of the S3 bucket that the firehose dumps to."
  default = "siphonexchange"
}


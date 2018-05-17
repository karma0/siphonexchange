variable "aws_region" {
  description = "The chosen region for the application."
  default = "us-east-1"
}

variable "app_name" {
  description = "The name of the S3 bucket that the firehose dumps to."
  default = "siphonexchange"
}

variable "cluster_name" {
  description = "The name of the cluster."
  default = "koralamode"
}

variable "aws_iam_role_name" {
  description = "The role associated with ECR access."
}

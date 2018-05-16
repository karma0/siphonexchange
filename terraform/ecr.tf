module "ecr" {
  source              = "git::https://github.com/cloudposse/terraform-aws-ecr.git?ref=master"
  name                = "${var.app_name}"
  namespace           = "${var.cluster_name}"
  stage               = "${terraform.env}"
  roles               = ["${var.aws_iam_roles}"]
}

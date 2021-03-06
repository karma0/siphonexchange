output "ecr_registry_id" {
  value = "${module.ecr.registry_id}"
}

output "ecr_registry_url" {
  value = "${module.ecr.registry_url}"
}

output "ecr_role_name" {
  value = ["${var.aws_iam_role_name}"]
}

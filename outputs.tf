output "arn" {
  value       = try(aws_iam_role.role[0].arn, "")
  description = "IAM Role ARN"
}

output "name" {
  value       = try(aws_iam_role.role[0].name, "")
  description = "IAM Role name"
}

output "path" {
  value       = try(aws_iam_role.role[0].path, "")
  description = "IAM Role path"
}

output "unique_id" {
  value       = try(aws_iam_role.role[0].unique_id, "")
  description = "Stable and unique string identifying the IAM Role"
}

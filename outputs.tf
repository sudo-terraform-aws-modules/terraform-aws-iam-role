output "arn" {
  value       = aws_iam_role.role[0].arn
  description = "The ARN of the role that is created"
}

output "name" {
  value       = aws_iam_role.role[0].name
  description = "The name of the role that is created"
}

output "path" {
  value       = aws_iam_role.role[0].path
  description = "The path of the role that is created"
}

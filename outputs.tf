output "arn" {
  value       = aws_iam_role.role.arn
  description = "The ARN of the role that is created"
}

output "name" {
  value       = aws_iam_role.role.name
  description = "The name of the role that is created"
}

output "path" {
  value       = aws_iam_role.role.path
  description = "The path of the role that is created"
}

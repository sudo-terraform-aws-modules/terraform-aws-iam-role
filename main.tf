
data "aws_iam_policy_document" "assume_role_policy" {
  statement {

    actions = var.trusted_role_actions

    effect = "Allow"

    dynamic "principals" {
      for_each = var.principals
      content {
        type        = principals.value.type
        identifiers = principals.value.identifiers
      }
    }
    dynamic "condition" {
      for_each = var.condition
      content {
        test     = condition.value.test
        variable = condition.value.variable
        values   = condition.value.values
      }
    }
  }
}

resource "aws_iam_role_policy_attachment" "user_defined_policies" {
  count      = length(var.custom_policy_arns)
  role       = aws_iam_role.role.name
  policy_arn = var.custom_policy_arns[count.index]
}


resource "aws_iam_role" "role" {
  name                 = local.role_name
  description          = var.description
  path                 = var.path
  assume_role_policy   = data.aws_iam_policy_document.assume_role_policy.json
  max_session_duration = var.maximum_session_duration
  permissions_boundary = var.permissions_boundary
  managed_policy_arns  = var.managed_policy_arns

  inline_policy {}

  tags = var.tags
}

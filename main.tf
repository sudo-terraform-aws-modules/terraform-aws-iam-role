
data "aws_iam_policy_document" "assume_role_policy" {
  count = var.enabled && length(local.principals) > 0 ? 1 : 0
  statement {

    actions = var.trusted_role_actions

    effect = "Allow"

    dynamic "principals" {
      for_each = local.principals
      content {
        type        = principals.value.type
        identifiers = principals.value.identifiers
      }
    }
    dynamic "condition" {
      for_each = local.condition
      content {
        test     = condition.value.test
        variable = condition.value.variable
        values   = condition.value.values
      }
    }
  }
}

resource "aws_iam_role_policy_attachment" "user_defined_policies" {
  count      = var.enabled ? length(var.custom_policy_arns) : 0
  role       = aws_iam_role.role[0].name
  policy_arn = var.custom_policy_arns[count.index]
}


resource "aws_iam_role" "role" {
  count                = var.enabled ? 1 : 0
  name                 = local.role_name
  name_prefix          = var.name_prefix
  description          = var.description
  path                 = var.path
  assume_role_policy   = try(data.aws_iam_policy_document.assume_role_policy[0].json, null)
  max_session_duration = var.maximum_session_duration
  permissions_boundary = var.permissions_boundary

  tags = var.tags
}

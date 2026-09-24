locals {
  role_name = var.name == null && var.name_prefix == null ? "sudo-${random_string.random_name[0].result}" : var.name

  check_condition  = var.condition != null && var.external_id != null ? tobool("condition and external_id are mutually exclusive — use condition to specify ExternalId explicitly") : true
  create_condition = var.condition == null && var.external_id == null ? true : false
  external_id      = local.check_condition ? (local.create_condition ? random_password.external_id[0].result : var.external_id) : null

  condition = var.condition != null ? var.condition : (
    local.create_condition ? [{
      test     = "StringEquals"
      variable = "sts:ExternalId"
      values   = [local.external_id]
    }] : []
  )

  principals = var.principals != null ? [
    for principal in var.principals : {
      type        = startswith(principal, "arn:") ? "AWS" : "Service"
      identifiers = [principal]
    }
  ] : []
}

resource "random_string" "random_name" {
  count   = var.enabled && var.name == null && var.name_prefix == null ? 1 : 0
  length  = 8
  special = false
  upper   = false
}

resource "random_password" "external_id" {
  count   = var.enabled && local.create_condition ? 1 : 0
  length  = 16
  special = false
  upper   = true
}

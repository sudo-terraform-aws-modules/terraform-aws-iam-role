locals {
  role_name        = var.name == null && var.name_prefix == null ? "sudo-${random_string.random_name[0].result}" : var.name
  check_condition  = var.condition != null && var.external_id != null ? tobool("Custom condition and External ID parameter are not compatible. Specify external ID condition in your custom condition") : true
  create_condition = var.condition == null && var.external_id == null ? true : false
  external_id      = local.check_condition ? random_password.external_id[0].result : var.external_id
  condition = var.condition != null ? var.condition : [{
    test     = "StringEquals"
    variable = "sts:ExternalId"
    values   = [local.external_id]
    }
  ]

  # aprincipals = var.principals != null ? var.principals : [{
  #   type        = "AWS"
  #   identifiers = ["arn:${data.aws_partition.current.partition}:iam::${data.aws_caller_identity.current.account_id}:role${var.path}${local.role_name}"]
  #   }
  # ]

  principals = var.principals != null ? flatten([
    for principal in var.principals : {
      type        = trimprefix(principal, "arn:") != principal ? "AWS" : "Service"
      identifiers = [principal]
    }
  ]) : []
}

resource "random_string" "random_name" {
  count   = var.enabled && var.name == null ? 1 : 0
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
# default = [{
#   test     = "StringEquals"
#   variable = "sts:ExternalId"
#   values   = ["CHANGEME"]
#   }
# ]

# default = [{
#   type        = "Service"
#   identifiers = ["ec2.amazonaws.com"]
#   }
# ]

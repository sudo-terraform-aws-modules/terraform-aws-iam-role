# Terraform AWS IAM Role
Template module to create AWS IAM Role

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.1 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.67 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.31.0 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.4.3 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_iam_role.role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.user_defined_policies](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [random_string.random_name](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [aws_iam_policy_document.assume_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_condition"></a> [condition](#input\_condition) | (optional) list of conditions | <pre>list(object({<br>    test     = string<br>    variable = string<br>    values   = list(string)<br>  }))</pre> | <pre>[<br>  {<br>    "test": "StringEquals",<br>    "values": [<br>      "CHANGEME"<br>    ],<br>    "variable": "sts:ExternalId"<br>  }<br>]</pre> | no |
| <a name="input_custom_policy_arns"></a> [custom\_policy\_arns](#input\_custom\_policy\_arns) | (optional) Custom Policy ARNs to attach to the role | `list(any)` | `[]` | no |
| <a name="input_description"></a> [description](#input\_description) | (optional) Role Description. Default: "" | `string` | `""` | no |
| <a name="input_managed_policy_arns"></a> [managed\_policy\_arns](#input\_managed\_policy\_arns) | (optional) Managed Policy ARNs to attach to the role | `list(any)` | `[]` | no |
| <a name="input_maximum_session_duration"></a> [maximum\_session\_duration](#input\_maximum\_session\_duration) | (optional) Specify the maximum duration if seconds for role sessoin. Defaul: 3600 | `number` | `3600` | no |
| <a name="input_name"></a> [name](#input\_name) | (optional) Provide the role name | `string` | `null` | no |
| <a name="input_path"></a> [path](#input\_path) | (optional) Path for your role | `string` | `"/"` | no |
| <a name="input_permissions_boundary"></a> [permissions\_boundary](#input\_permissions\_boundary) | (optional) Specify the list of ARNs of policies that are used to define the permission boundary for the role. Default: "" | `string` | `""` | no |
| <a name="input_principals"></a> [principals](#input\_principals) | (optional) list of principals | <pre>list(object({<br>    type        = string<br>    identifiers = list(string)<br>  }))</pre> | <pre>[<br>  {<br>    "identifiers": [<br>      "ec2.amazonaws.com"<br>    ],<br>    "type": "Service"<br>  }<br>]</pre> | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (optional) specify your custom tags | `map(any)` | `{}` | no |
| <a name="input_trusted_role_actions"></a> [trusted\_role\_actions](#input\_trusted\_role\_actions) | (optional) Trusted role actions | `list(any)` | <pre>[<br>  "sts:AssumeRole"<br>]</pre> | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->

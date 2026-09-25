# SUDO AWS Terraform Module for IAM Role

Creates an AWS IAM Role with a configurable trust policy, optional ExternalId condition, and policy attachments.

## Usage

### Basic Role (EC2 service principal)

```hcl
module "iam_role" {
  source  = "sudo-terraform-aws-modules/iam-role/aws"
  version = "1.0.0"

  name       = "my-ec2-role"
  principals = ["ec2.amazonaws.com"]
  condition  = []

  managed_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  ]
}
```

### ECS Task Execution Role

```hcl
module "ecs_execution_role" {
  source  = "sudo-terraform-aws-modules/iam-role/aws"
  version = "1.0.0"

  name       = "ecs-execution-role"
  principals = ["ecs-tasks.amazonaws.com"]
  condition  = []

  managed_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
  ]

  tags = { Environment = "prod" }
}
```

### Cross-Account Role with ExternalId

```hcl
module "cross_account_role" {
  source  = "sudo-terraform-aws-modules/iam-role/aws"
  version = "1.0.0"

  name       = "cross-account-role"
  principals = ["arn:aws:iam::123456789012:root"]

  # Omit condition entirely to auto-generate a random ExternalId (recommended)
  # Or pass a specific external_id:
  external_id = "my-secret-id"

  custom_policy_arns = [aws_iam_policy.my_policy.arn]
}
```

### Disable ExternalId (service-to-service trust)

```hcl
module "lambda_role" {
  source  = "sudo-terraform-aws-modules/iam-role/aws"
  version = "1.0.0"

  name       = "lambda-role"
  principals = ["lambda.amazonaws.com"]
  condition  = []   # pass empty list to disable ExternalId

  managed_policy_arns = [
    "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
  ]
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 6.0, < 7.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 6.0, < 7.0 |
| <a name="provider_random"></a> [random](#provider\_random) | >= 3.1 |

## Resources

| Name | Type |
|------|------|
| [aws_iam_role.role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.custom](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.managed](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [random_password.external_id](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |
| [random_string.random_name](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [aws_iam_policy_document.assume_role_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_name"></a> [name](#input\_name) | IAM role name. Conflicts with name_prefix | `string` | `null` | no |
| <a name="input_name_prefix"></a> [name\_prefix](#input\_name\_prefix) | IAM role name prefix. Conflicts with name | `string` | `null` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Set to false to disable all resource creation | `bool` | `true` | no |
| <a name="input_description"></a> [description](#input\_description) | IAM role description | `string` | `""` | no |
| <a name="input_path"></a> [path](#input\_path) | IAM role path | `string` | `"/"` | no |
| <a name="input_maximum_session_duration"></a> [maximum\_session\_duration](#input\_maximum\_session\_duration) | Maximum session duration in seconds (3600–43200) | `number` | `3600` | no |
| <a name="input_trusted_role_actions"></a> [trusted\_role\_actions](#input\_trusted\_role\_actions) | STS actions in the trust policy | `list(string)` | `["sts:AssumeRole"]` | no |
| <a name="input_principals"></a> [principals](#input\_principals) | Principals to trust. Full ARNs are treated as AWS type; service names as Service type | `list(string)` | `["ec2.amazonaws.com"]` | no |
| <a name="input_condition"></a> [condition](#input\_condition) | Trust policy conditions. Pass `[]` to disable the default ExternalId condition | `list(object({test=string, variable=string, values=list(string)}))` | `null` | no |
| <a name="input_external_id"></a> [external\_id](#input\_external\_id) | Explicit ExternalId. Conflicts with condition. Omit to auto-generate | `string` | `null` | no |
| <a name="input_permissions_boundary"></a> [permissions\_boundary](#input\_permissions\_boundary) | ARN of the permissions boundary policy | `string` | `null` | no |
| <a name="input_custom_policy_arns"></a> [custom\_policy\_arns](#input\_custom\_policy\_arns) | Customer-managed policy ARNs to attach | `list(string)` | `[]` | no |
| <a name="input_managed_policy_arns"></a> [managed\_policy\_arns](#input\_managed\_policy\_arns) | AWS-managed policy ARNs to attach | `list(string)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to the IAM role | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_arn"></a> [arn](#output\_arn) | IAM Role ARN |
| <a name="output_name"></a> [name](#output\_name) | IAM Role name |
| <a name="output_path"></a> [path](#output\_path) | IAM Role path |
| <a name="output_unique_id"></a> [unique\_id](#output\_unique\_id) | Stable unique ID of the IAM Role |
<!-- END_TF_DOCS -->

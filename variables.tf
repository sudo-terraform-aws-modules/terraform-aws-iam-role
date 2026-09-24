variable "name" {
  type        = string
  description = "(optional) IAM role name. Conflicts with name_prefix. Default: randomly generated"
  default     = null
}

variable "name_prefix" {
  type        = string
  description = "(optional) IAM role name prefix. Conflicts with name."
  default     = null
}

variable "enabled" {
  type        = bool
  description = "(optional) Set to false to disable resource creation entirely. Default: true"
  default     = true
}

variable "description" {
  type        = string
  description = "(optional) IAM role description."
  default     = ""
}

variable "path" {
  type        = string
  description = "(optional) IAM role path. Default: /"
  default     = "/"
}

variable "maximum_session_duration" {
  type        = number
  description = "(optional) Maximum session duration in seconds. Default: 3600"
  default     = 3600
  validation {
    condition     = var.maximum_session_duration >= 3600 && var.maximum_session_duration <= 43200
    error_message = "maximum_session_duration must be between 3600 and 43200 seconds."
  }
}

variable "trusted_role_actions" {
  type        = list(string)
  description = "(optional) STS actions allowed in the trust policy. Default: [sts:AssumeRole]"
  default     = ["sts:AssumeRole"]
}

variable "principals" {
  type        = list(string)
  description = "(optional) List of principals to trust. Use full ARNs for AWS principals (treated as AWS type) or service names like 'ec2.amazonaws.com' (treated as Service type)."
  default     = ["ec2.amazonaws.com"]
}

variable "condition" {
  type = list(object({
    test     = string
    variable = string
    values   = list(string)
  }))
  description = "(optional) Trust policy conditions. Pass an empty list [] to disable the default ExternalId condition."
  default     = null
}

variable "external_id" {
  type        = string
  description = "(optional) Explicit ExternalId value for the trust policy. Conflicts with condition. When neither is set, a random ExternalId is generated automatically."
  default     = null
}

variable "permissions_boundary" {
  type        = string
  description = "(optional) ARN of the permissions boundary policy to attach to the role."
  default     = null
}

variable "custom_policy_arns" {
  type        = list(string)
  description = "(optional) ARNs of customer-managed policies to attach to the role."
  default     = []
}

variable "managed_policy_arns" {
  type        = list(string)
  description = "(optional) ARNs of AWS-managed policies to attach to the role."
  default     = []
}

variable "tags" {
  type        = map(string)
  description = "(optional) Tags to apply to the IAM role."
  default     = {}
}

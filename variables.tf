variable "name" {
  type        = string
  description = "(optional) Provide the role name"
  default     = null
}

variable "enabled" {
  type        = bool
  description = "(optional) Enable or disable module"
  default     = true
}
variable "name_prefix" {
  type        = string
  description = "(optional) Specify the prefix for your role name"
  default     = null
}
variable "description" {
  type        = string
  description = "(optional) Role Description. Default: \"\""
  default     = ""
}

variable "maximum_session_duration" {
  type        = number
  description = "(optional) Specify the maximum duration if seconds for role sessoin. Defaul: 3600"
  default     = 3600
}

variable "trusted_role_actions" {
  type        = list(any)
  description = "(optional) Trusted role actions"
  default     = ["sts:AssumeRole"]
}

variable "path" {
  type        = string
  description = "(optional) Path for your role"
  default     = "/"
}

variable "principals" {
  type        = list(string)
  description = "(optional) list of principals"
  default     = ["ec2.amazonaws.com"]
}

variable "condition" {
  type = list(object({
    test     = string
    variable = string
    values   = list(string)
  }))
  description = "(optional) list of conditions"
  default     = null
}

variable "custom_policy_arns" {
  type        = list(any)
  description = "(optional) Custom Policy ARNs to attach to the role"
  default     = []
}

variable "permissions_boundary" {
  type        = string
  description = "(optional) Specify the list of ARNs of policies that are used to define the permission boundary for the role. Default: \"\""
  default     = ""
}

variable "tags" {
  type        = map(any)
  description = "(optional) specify your custom tags"
  default     = {}
}

variable "external_id" {
  type        = string
  description = "(optional) Specify the external ID"
  default     = null
}

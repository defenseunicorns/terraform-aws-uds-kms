variable "key_owners" {
  description = "A list of IAM ARNs for those who will have full key permissions (`kms:*`)"
  type        = list(string)
  default     = []
}

variable "kms_key_policy_default_identities" {
  description = "A list of IAM ARNs for those who will have full key permissions (`kms:*`)"
  type        = list(string)
  default     = []
}

variable "kms_key_policy_default_services" {
  description = "A list of services that will have full key permissions (`kms:*`)"
  type        = list(string)
  default     = []
}

variable "kms_key_description" {
  description = "Description for the KMS key."
  type        = string
  default     = ""
}

variable "kms_key_deletion_window" {
  description = "Waiting period for scheduled KMS Key deletion. Can be 7-30 days."
  type        = number
  default     = 7
}

variable "kms_key_alias_name_prefix" {
  description = "Prefix for KMS key alias."
  type        = string
}

variable "tags" {
  description = "A map of tags to add to all resources."
  type        = map(string)
  default     = {}
}

variable "kms_external_key" {
  description = "Whether to create an external key for importing key material"
  type        = bool
  default     = false
}

variable "kms_key_usage" {
  description = "What the key is intended to be used for (ENCRYPT_DECRYPT or SIGN_VERIFY)"
  type        = string
  default     = "ENCRYPT_DECRYPT"
}

variable "kms_key_spec" {
  description = "The key material specification (i.e. SYMMETRIC_DEFAULT)"
  type        = string
  default     = "SYMMETRIC_DEFAULT"
}

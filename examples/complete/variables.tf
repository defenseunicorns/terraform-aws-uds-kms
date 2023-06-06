variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-2"
}

variable "kms_key_alias_name_prefix" {
  description = "Alias that starts with \"alias/\" and will be suffixed with \"-<random string>\"."
  type        = string
  default     = "alias/example"
}

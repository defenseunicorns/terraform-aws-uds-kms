resource "random_id" "default" {
  byte_length = 2
}

module kms {
  source = "../../"

  kms_key_description = "Test KMS key."
  kms_key_alias_name_prefix = "${var.kms_key_alias_name_prefix}-${lower(random_id.default.hex)}"
}

output "kms_key_arn" {
  value = module.kms.key_arn
}

output "kms_key_alias" {
  value = aws_kms_alias.default.name
}

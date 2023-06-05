output "alias" {
  value = aws_kms_alias.default.name
}

locals {
  alias_prefix = "alias/"
  key_alias = startswith(var.kms_key_alias_name_prefix, local.alias_prefix) ? var.kms_key_alias_name_prefix : "${local.alias_prefix}${var.kms_key_alias_name_prefix}"

}
module "kms" {
  source  = "terraform-aws-modules/kms/aws"
  version = "1.5.0"

  description             = var.kms_key_description
  deletion_window_in_days = var.kms_key_deletion_window
  enable_key_rotation     = true
  policy                  = data.aws_iam_policy_document.kms_access.json
  multi_region            = true
  key_owners              = var.key_owners
  tags                    = var.tags
}

resource "aws_kms_alias" "default" {
  name_prefix   = local.key_alias
  target_key_id = module.kms.key_id
}

data "aws_partition" "current" {}

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

# Create custom policy for KMS
data "aws_iam_policy_document" "kms_access" {
  # checkov:skip=CKV_AWS_111: todo reduce perms on key
  # checkov:skip=CKV_AWS_109: todo be more specific with resources
  statement {
    sid = "KMS Key Default"
    principals {
      type = "AWS"
      identifiers = [
        "arn:${data.aws_partition.current.partition}:iam::${data.aws_caller_identity.current.account_id}:root"
      ]
    }

    actions = [
      "kms:*",
    ]

    resources = ["*"]
  }
  statement {
    sid = "CloudWatchLogsEncryption"
    principals {
      type        = "Service"
      identifiers = ["logs.${data.aws_region.current.name}.amazonaws.com"]
    }
    actions = [
      "kms:Encrypt*",
      "kms:Decrypt*",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:Describe*",
    ]

    resources = ["*"]
  }
  statement {
    sid = "Cloudtrail KMS permissions"
    principals {
      type = "Service"
      identifiers = [
        "cloudtrail.amazonaws.com"
      ]
    }
    actions = [
      "kms:Encrypt*",
      "kms:Decrypt*",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:Describe*",
    ]
    resources = ["*"]
  }

}

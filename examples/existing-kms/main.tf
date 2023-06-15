##############################################################################
# KMS root key
##############################################################################

module "kms_root_key" {
  source                  = "../.."
  key_protect_instance_id = var.existing_kms_instance_guid
  key_name                = "${var.prefix}-root-key"
}

##############################################################################
# KMS standard key
##############################################################################

module "kms_standard_key" {
  source                  = "../.."
  key_protect_instance_id = var.existing_kms_instance_guid
  key_name                = "${var.prefix}-standard-key"
  standard_key            = true
}

##############################################################################
# Key Protect root key
##############################################################################

module "key_protect_root_key" {
  source                  = "../.."
  key_protect_instance_id = var.existing_kms_instance_guid
  key_name                = "${var.prefix}-root-key"
}

##############################################################################
# Key Protect standard key
##############################################################################

module "key_protect_standard_key" {
  source                  = "../.."
  key_protect_instance_id = var.existing_kms_instance_guid
  key_name                = "${var.prefix}-standard-key"
  standard_key            = true
}

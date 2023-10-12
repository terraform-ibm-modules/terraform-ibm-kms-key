##############################################################################
# Resource Group
##############################################################################

module "resource_group" {
  source  = "terraform-ibm-modules/resource-group/ibm"
  version = "1.1.0"
  # if an existing resource group is not set (null) create a new one using prefix
  resource_group_name          = var.resource_group == null ? "${var.prefix}-resource-group" : null
  existing_resource_group_name = var.resource_group
}

##############################################################################
# KMS (Key Protect) instance
##############################################################################

resource "ibm_resource_instance" "key_protect_instance" {
  name              = "${var.prefix}-key-protect"
  resource_group_id = module.resource_group.resource_group_id
  service           = "kms"
  plan              = "tiered-pricing"
  location          = var.region
  tags              = var.resource_tags
}

##############################################################################
# KMS root key
##############################################################################

module "kms_root_key" {
  source          = "../.."
  kms_instance_id = ibm_resource_instance.key_protect_instance.guid
  key_name        = "${var.prefix}-root-key"
}

##############################################################################
# KMS standard key
##############################################################################

module "kms_standard_key" {
  source          = "../.."
  kms_instance_id = ibm_resource_instance.key_protect_instance.guid
  key_name        = "${var.prefix}-standard-key"
  standard_key    = true
}

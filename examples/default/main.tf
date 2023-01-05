##############################################################################
# Resource Group
##############################################################################

module "resource_group" {
  source = "git::https://github.com/terraform-ibm-modules/terraform-ibm-resource-group.git?ref=v1.0.5"
  # if an existing resource group is not set (null) create a new one using prefix
  resource_group_name          = var.resource_group == null ? "${var.prefix}-resource-group" : null
  existing_resource_group_name = var.resource_group
}

##############################################################################
# Key Protect instance
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
# Key Protect root key
##############################################################################

module "key_protect_root_key" {
  source                  = "../.."
  key_protect_instance_id = ibm_resource_instance.key_protect_instance.guid
  key_name                = "${var.prefix}-root-key"
}

##############################################################################
# Key Protect standard key
##############################################################################

module "key_protect_standard_key" {
  source                  = "../.."
  key_protect_instance_id = ibm_resource_instance.key_protect_instance.guid
  key_name                = "${var.prefix}-standard-key"
  standard_key            = true
}

##############################################################################
# Resource Group
##############################################################################

module "resource_group" {
  source = "git::https://github.com/terraform-ibm-modules/terraform-ibm-resource-group.git?ref=v1.0.4"
  # if an existing resource group is not set (null) create a new one using prefix
  resource_group_name          = var.resource_group == null ? "${var.prefix}-resource-group" : null
  existing_resource_group_name = var.resource_group
}

##############################################################################
# Key Protect module
##############################################################################

module "key_protect_module" {
  source            = "git::https://github.com/terraform-ibm-modules/terraform-ibm-key-protect.git?ref=v1.2.0"
  key_protect_name  = "${var.prefix}-key-protect"
  resource_group_id = module.resource_group.resource_group_id
  region            = var.region
  tags              = var.resource_tags
}

module "key_protect_root_key" {
  source                  = "../.."
  key_protect_instance_id = module.key_protect_module.key_protect_guid
  key_name                = "${var.prefix}-root-key"
}

module "key_protect_standard_key" {
  source                  = "../.."
  key_protect_instance_id = module.key_protect_module.key_protect_guid
  key_name                = "${var.prefix}-standard-key"
  standard_key            = true
}

##############################################################################
# Resource Group
##############################################################################

module "resource_group" {
  source  = "terraform-ibm-modules/resource-group/ibm"
  version = "1.4.0"
  # if an existing resource group is not set (null) create a new one using prefix
  resource_group_name          = var.resource_group == null ? "${var.prefix}-resource-group" : null
  existing_resource_group_name = var.resource_group
}

##############################################################################
# Secrets Manager Certificate Setup
##############################################################################

module "secrets_manager" {
  count                = var.existing_secrets_manager_crn == null ? 1 : 0
  source               = "terraform-ibm-modules/secrets-manager/ibm"
  version              = "2.11.8"
  secrets_manager_name = "${var.prefix}-secrets-manager"
  sm_service_plan      = "trial"
  resource_group_id    = module.resource_group.resource_group_id
  region               = var.region
}

module "sm_crn" {
  source  = "terraform-ibm-modules/common-utilities/ibm//modules/crn-parser"
  version = "1.3.0"
  crn     = var.existing_secrets_manager_crn == null ? module.secrets_manager[0].secrets_manager_crn : var.existing_secrets_manager_crn
}

locals {
  certificate_template_name = var.existing_cert_template_name == null ? "${var.prefix}-template" : var.existing_cert_template_name
}

module "secrets_manager_private_cert_engine" {
  count                     = var.existing_secrets_manager_crn == null && var.existing_cert_template_name == null ? 1 : 0
  source                    = "terraform-ibm-modules/secrets-manager-private-cert-engine/ibm"
  version                   = "1.11.0"
  secrets_manager_guid      = module.sm_crn.service_instance
  region                    = var.region
  root_ca_name              = "${var.prefix}-ca"
  root_ca_common_name       = "*.cloud.ibm.com"
  intermediate_ca_name      = "${var.prefix}-int-ca"
  certificate_template_name = local.certificate_template_name
  root_ca_max_ttl           = "8760h"
}

module "secrets_manager_cert" {
  # explicit depends on because the cert engine must complete creating the template before the cert is created
  # no outputs from the private cert engine to reference in this module call
  depends_on             = [module.secrets_manager_private_cert_engine]
  source                 = "terraform-ibm-modules/secrets-manager-private-cert/ibm"
  version                = "1.7.5"
  secrets_manager_guid   = module.sm_crn.service_instance
  secrets_manager_region = module.sm_crn.region
  cert_name              = "${var.prefix}-kmip-cert"
  cert_common_name       = "*.cloud.ibm.com"
  cert_template          = local.certificate_template_name
}

data "ibm_sm_private_certificate" "kmip_cert" {
  instance_id = module.sm_crn.service_instance
  region      = module.sm_crn.region
  secret_id   = module.secrets_manager_cert.secret_id
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
  kmip = [
    {
      name = "${var.prefix}-kmip-adapter"
      certificates = [
        {
          certificate = data.ibm_sm_private_certificate.kmip_cert.certificate
        }
      ]
    }
  ]
}

module "kms_root_key_2" {
  source          = "../.."
  kms_instance_id = ibm_resource_instance.key_protect_instance.guid
  key_name        = "${var.prefix}-root-key-2"

  kmip = [
    {
      name = "${var.prefix}-kmip-adapter-2"
    }
  ]
}

##############################################################################
# KMS standard key
##############################################################################

module "kms_standard_key" {
  source          = "../.."
  kms_instance_id = ibm_resource_instance.key_protect_instance.guid
  key_name        = "${var.prefix}-standard-key"
  standard_key    = true
  force_delete    = true # Setting it to true for testing purpose
}

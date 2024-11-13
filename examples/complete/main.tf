##############################################################################
# Resource Group
##############################################################################

module "resource_group" {
  source  = "terraform-ibm-modules/resource-group/ibm"
  version = "1.1.6"
  # if an existing resource group is not set (null) create a new one using prefix
  resource_group_name          = var.resource_group == null ? "${var.prefix}-resource-group" : null
  existing_resource_group_name = var.resource_group
}

##############################################################################
# Secrets Manager Certificate Setup
##############################################################################

module "sm_crn" {
  source  = "terraform-ibm-modules/common-utilities/ibm//modules/crn-parser"
  version = "1.1.0"
  crn     = var.existing_secrets_manager_crn
}

module "secrets_manager_cert" {
  source                            = "terraform-ibm-modules/secrets-manager-public-cert/ibm"
  version                           = "1.2.1"
  secrets_manager_guid              = module.sm_crn.service_instance
  secrets_manager_region            = module.sm_crn.region
  cert_name                         = "${var.prefix}-kmip-cert"
  secrets_manager_dns_provider_name = var.secrets_manager_dns_provider_name
  secrets_manager_ca_name           = var.secrets_manager_ca_name
  cert_common_name                  = "${var.prefix}.${var.domain_name}"
}

data "ibm_sm_public_certificate" "kmip_cert" {
  depends_on        = [module.secrets_manager_cert]
  instance_id       = module.sm_crn.service_instance
  region            = module.sm_crn.region
  name              = "${var.prefix}-kmip-cert"
  secret_group_name = "default"
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
          certificate = split("\n\n", data.ibm_sm_public_certificate.kmip_cert.certificate)[0]
        }
      ]
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

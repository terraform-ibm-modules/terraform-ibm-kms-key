##############################################################################
# KMS Key module
##############################################################################

resource "ibm_kms_key" "key" {
  instance_id   = var.kms_instance_id
  key_name      = var.key_name
  key_ring_id   = var.kms_key_ring_id
  standard_key  = var.standard_key
  endpoint_type = var.endpoint_type
  force_delete  = var.force_delete
}

resource "ibm_kms_key_policies" "root_key_policy" {
  count         = var.standard_key ? 0 : 1
  endpoint_type = var.endpoint_type
  instance_id   = var.kms_instance_id
  key_id        = ibm_kms_key.key.key_id
  rotation {
    interval_month = var.rotation_interval_month
  }
  dual_auth_delete {
    enabled = var.dual_auth_delete_enabled
  }
}

resource "ibm_kms_key_policies" "standard_key_policy" {
  count         = var.standard_key ? 1 : 0
  endpoint_type = var.endpoint_type
  instance_id   = var.kms_instance_id
  key_id        = ibm_kms_key.key.key_id
  dual_auth_delete {
    enabled = var.dual_auth_delete_enabled
  }
}

locals {
  # tflint-ignore: terraform_unused_declarations
  kmip_root_key_validation = (length(var.kmip) > 0 && var.standard_key) ? tobool("When providing a value for `kmip`, the key being created must be a root key.") : true

  kmip_cert_list = flatten([
    [
      for adapter in var.kmip : [
        for certificate in adapter.certificates : {
          adapter_name     = adapter.name
          certificate_name = try(certificate.name, null)
          certificate      = certificate.certificate
          # Check if filepath string is given, used in ibm_kms_kmip_client_cert call
          cert_is_file = length(regexall("^.+\\.pem$", certificate.certificate)) > 0
        }
      ] if lookup(adapter, "certificates", null) != null
    ]
  ])

  kmip_certs = {
    for idx, obj in local.kmip_cert_list : "${nonsensitive(obj.adapter_name)}-${idx}" => obj
  }

  kmip_adapter_id_output = {
    for idx, _ in ibm_kms_kmip_adapter.kmip_adapter :
    idx => ibm_kms_kmip_adapter.kmip_adapter[idx].adapter_id
  }
  kmip_cert_id_output = {
    for idx, _ in ibm_kms_kmip_client_cert.kmip_cert :
    idx => ibm_kms_kmip_client_cert.kmip_cert[idx].cert_id
  }
}

resource "ibm_kms_kmip_adapter" "kmip_adapter" {
  for_each    = { for adapter in var.kmip : adapter.name => adapter }
  instance_id = var.kms_instance_id
  profile     = "native_1.0"
  profile_data = {
    "crk_id" = ibm_kms_key.key.key_id
  }
  name          = each.key
  description   = each.value.description
  endpoint_type = var.endpoint_type
}

resource "ibm_kms_kmip_client_cert" "kmip_cert" {
  for_each      = local.kmip_certs
  endpoint_type = var.endpoint_type
  instance_id   = var.kms_instance_id
  adapter_id    = ibm_kms_kmip_adapter.kmip_adapter[each.value.adapter_name].adapter_id
  certificate   = each.value.cert_is_file ? file(each.value.certificate) : each.value.certificate
  name          = each.value.certificate_name
}

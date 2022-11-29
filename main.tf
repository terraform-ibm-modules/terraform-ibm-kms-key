##############################################################################
# Key Protect Key module
##############################################################################

resource "ibm_kms_key" "key" {
  instance_id   = var.key_protect_instance_id
  key_name      = var.key_name
  key_ring_id   = var.key_protect_key_ring_id
  standard_key  = var.standard_key
  endpoint_type = var.endpoint_type
  force_delete  = var.force_delete
}

resource "ibm_kms_key_policies" "root_key_policy" {
  count         = var.standard_key ? 0 : 1
  endpoint_type = var.endpoint_type
  instance_id   = var.key_protect_instance_id
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
  instance_id   = var.key_protect_instance_id
  key_id        = ibm_kms_key.key.key_id
  dual_auth_delete {
    enabled = var.dual_auth_delete_enabled
  }
}

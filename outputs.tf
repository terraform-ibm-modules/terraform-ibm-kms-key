##############################################################################
# Outputs
##############################################################################

output "key_id" {
  description = "Key ID"
  value       = ibm_kms_key.key.key_id
}

output "crn" {
  description = "Key CRN"
  value       = ibm_kms_key.key.crn
}

output "rotation_interval_month" {
  description = "Month Interval for Rotation"
  value       = var.standard_key ? [tomap({ "interval_month" = 0 })] : ibm_kms_key_policies.root_key_policy[0].rotation
}

output "dual_auth_delete" {
  description = "Is Dual Auth Delete Enabled"
  value       = var.standard_key ? ibm_kms_key_policies.standard_key_policy[0].dual_auth_delete : ibm_kms_key_policies.root_key_policy[0].dual_auth_delete
}

output "adapter_ids" {
  description = "KMIP Adapter IDs of the associated root key"
  value       = local.kmip_adapter_id_output
}

output "cert_ids" {
  description = "KMIP Cert IDs"
  value       = local.kmip_cert_id_output
}

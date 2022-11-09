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

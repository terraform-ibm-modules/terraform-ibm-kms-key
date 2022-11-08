##############################################################################
# Outputs
##############################################################################

output "instance_id" {
  description = "Key Protect Instance ID"
  value       = module.key_protect_module.key_protect_guid
}

output "root_key_id" {
  description = "Key Protect Key ID"
  value       = module.key_protect_root_key.key_id
}

output "root_key_rotation_interval_month" {
  description = "Month Interval for Rotation"
  value       = module.key_protect_root_key.rotation_interval_month
}

output "root_key_dual_auth_delete_enabled" {
  description = "Is Dual Auth Delete Enabled"
  value       = module.key_protect_root_key.dual_auth_delete
}

output "standard_key_id" {
  description = "Key Protect Key ID"
  value       = module.key_protect_standard_key.key_id
}

output "standard_key_rotation_interval_month" {
  description = "Month Interval for Rotation"
  value       = module.key_protect_standard_key.rotation_interval_month
}

output "standard_key_dual_auth_delete_enabled" {
  description = "Is Dual Auth Delete Enabled"
  value       = module.key_protect_standard_key.dual_auth_delete
}

output "resource_group_name" {
  description = "Resource group name"
  value       = module.resource_group.resource_group_name
}

output "resource_group_id" {
  description = "Resource group ID"
  value       = module.resource_group.resource_group_id
}

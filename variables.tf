##############################################################################
# Input Variables
##############################################################################

variable "key_protect_instance_id" {
  type        = string
  description = "ID or GUID of Key Protect Instance"
}

variable "key_name" {
  type        = string
  description = "Name to give the key"
}

variable "key_protect_key_ring_id" {
  type        = string
  description = "The ID of the key ring where you want to add your Key Protect key"
  default     = "default"
}

variable "standard_key" {
  type        = bool
  description = "Set as true for Standard Key, false for Root Key"
  default     = false
}

variable "endpoint_type" {
  type        = string
  description = "Endpoint to use when creating the Key"
  default     = "private"

  validation {
    condition     = can(regex("public|private", var.endpoint_type))
    error_message = "Variable 'endpoint_type' must be 'public' or 'private'."
  }
}

variable "rotation_interval_month" {
  type        = number
  description = "The key rotation time interval in months. Rotation policy cannot be set for standard key, so value is ignored if var.standard_key is true"
  default     = 1
  validation {
    condition     = var.rotation_interval_month <= 12 && var.rotation_interval_month >= 0
    error_message = "Value must be between 1 and 12."
  }
}

variable "dual_auth_delete_enabled" {
  type        = bool
  description = "If set to true, Key Protect enables a dual authorization policy on a single key. Note: Once the dual authorization policy is set on the key, it cannot be reverted. A key with dual authorization policy enabled cannot be destroyed by using Terraform."
  default     = false
}

variable "force_delete" {
  type        = bool
  description = "Set as true to enable forcing deletion even if key is in use"
  default     = false
}

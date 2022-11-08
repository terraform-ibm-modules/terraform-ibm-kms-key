##############################################################################
# Input Variables
##############################################################################

variable "kms_instance_id" {
  type        = string
  description = "ID of KMS Instance"
}

variable "key_name" {
  type        = string
  description = "Name to give the key"
}

variable "kms_key_ring_id" {
  type        = string
  description = "ID of Key Ring where key is assigned"
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
  description = "Interval in months to rotate the Key"
  default     = 1
}

variable "dual_auth_delete_enabled" {
  type        = bool
  description = "Set as true to enable Dual Auth Delete"
  default     = false
}

variable "force_delete" {
  type        = bool
  description = "Set as true to enable forcing deletion even if key is in use"
  default     = false
}

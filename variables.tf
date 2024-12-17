##############################################################################
# Input Variables
##############################################################################

variable "kms_instance_id" {
  type        = string
  description = "ID or GUID of KMS Instance"
}

variable "key_name" {
  type        = string
  description = "Name to give the key"
}

variable "kms_key_ring_id" {
  type        = string
  description = "The ID of the key ring where you want to add your KMS key"
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
  default     = "public"

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
    condition     = var.rotation_interval_month <= 12 && var.rotation_interval_month >= 1
    error_message = "Value must be between 1 and 12."
  }
}

variable "dual_auth_delete_enabled" {
  type        = bool
  description = "If set to true, KMS enables a dual authorization policy on a single key. Note: Once the dual authorization policy is set on the key, it cannot be reverted. A key with dual authorization policy enabled cannot be destroyed by using Terraform."
  default     = false
}

variable "force_delete" {
  type        = bool
  description = "Set as true to enable forcing deletion even if key is in use"
  default     = false
}

variable "kmip" {
  type = list(object({
    name        = string
    description = optional(string)
    certificates = optional(list(object({
      name        = optional(string)
      certificate = string
    })))
  }))
  description = "Allows a key to utilize the key management interoperability protocol (KMIP), for more information see https://cloud.ibm.com/docs/key-protect?topic=key-protect-kmip"
  default     = []

  validation {
    condition = alltrue([for adapter in var.kmip :
      length(adapter.name) >= 2 && length(adapter.name) <= 40
    ])
    error_message = "`kmip[*].name` must be between 2 and 40 characters."
  }

  validation {
    condition = alltrue([for adapter in var.kmip :
      adapter.description == null ? true :
      length(adapter.description) >= 2 && length(adapter.description) <= 240
    ])
    error_message = "`kmip[*].description` must be between 2 and 240 characters."
  }

  validation {
    condition = alltrue([
      for adapter in var.kmip :
      adapter.certificates == null ? true :
      length(adapter.certificates) <= 200
    ])
    error_message = "Each adapter can contain up to 200 certificates, current length exceeds this limit."
  }
}

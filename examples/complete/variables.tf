variable "ibmcloud_api_key" {
  type        = string
  description = "The IBM Cloud API Key"
  sensitive   = true
}

variable "region" {
  type        = string
  description = "Region to provision all resources created by this example"
}

variable "prefix" {
  type        = string
  description = "Prefix to append to all resources created by this example"
}

variable "resource_group" {
  type        = string
  description = "An existing resource group name to use for this example, if unset a new resource group will be created"
  default     = null
}

variable "resource_tags" {
  type        = list(string)
  description = "Optional list of tags to be added to created resources"
  default     = []
}

variable "existing_secrets_manager_crn" {
  type        = string
  description = "CRN of an existing Secrets Manager instance"
}

variable "secrets_manager_dns_provider_name" {
  type        = string
  description = "The DNS provider name for the certificate used for KMIP certificate"
  default     = "certificate-dns"
}

variable "secrets_manager_ca_name" {
  type        = string
  description = "The name of the CA to use in the Secrets Manager instance for certificate creation"
  default     = "certificate-ca"
}

variable "domain_name" {
  type        = string
  description = "The name of the domain to use in the Secrets Manager instance for certificate creation"
  default     = "goldeneye.dev.cloud.ibm.com"
}

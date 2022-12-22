# Key Protect key module

[![Stable (With quality checks)](https://img.shields.io/badge/Status-Stable%20(With%20quality%20checks)-green?style=plastic)](https://terraform-ibm-modules.github.io/documentation/#/badge-status)
[![Build status](https://github.com/terraform-ibm-modules/terraform-ibm-key-protect-key/actions/workflows/ci.yml/badge.svg)](https://github.com/terraform-ibm-modules/terraform-ibm-key-protect-key/actions/workflows/ci.yml)
[![semantic-release](https://img.shields.io/badge/%20%20%F0%9F%93%A6%F0%9F%9A%80-semantic--release-e10079.svg)](https://github.com/semantic-release/semantic-release)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)
[![latest release](https://img.shields.io/github/v/release/terraform-ibm-modules/terraform-ibm-key-protect-key?logo=GitHub&sort=semver)](https://github.com/terraform-ibm-modules/terraform-ibm-key-protect-key/releases/latest)
[![Renovate enabled](https://img.shields.io/badge/renovate-enabled-brightgreen.svg)](https://renovatebot.com/)

This module supports creating a standard or root key in an existing key ring and Key Protect instance. You can specify rotation and deletion policies.

## Usage

```hcl
provider "ibm" {
  ibmcloud_api_key = "XXXXXXXXXX"
  # Must be the same region the Key Protect instance is in
  region           = "us-south"
}

# Key Protect root key
module "key_protect_root_key" {
  # Replace "main" with a GIT release version to lock into a specific release
  source                   = "git::https://github.com/terraform-ibm-modules/terraform-ibm-key-protect-key.git?ref=main"
  key_protect_instance_id = ibm_resource_instance.key_protect_instance.guid
  key_name                = "my-root-key"
}

# Key Protect standard key
module "key_protect_standard_key" {
  # Replace "main" with a GIT release version to lock into a specific release
  source                   = "git::https://github.com/terraform-ibm-modules/terraform-ibm-key-protect-key.git?ref=main"
  key_protect_instance_id = ibm_resource_instance.key_protect_instance.guid
  key_name                = "my-standard-key"
  standard_key            = true
}
```

## Required IAM access policies
You need the following permissions to run this module.

- Account Management
    - **Resource Group** service
        - `Viewer` platform access
- IAM Services
    - **Key Protect** service
        - `Viewer` platform access
        - `Manager` service access

<!-- BEGIN EXAMPLES HOOK -->
## Examples

- [ End to end example with default values](examples/default)
<!-- END EXAMPLES HOOK -->
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_ibm"></a> [ibm](#requirement\_ibm) | >= 1.48.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [ibm_kms_key.key](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/kms_key) | resource |
| [ibm_kms_key_policies.root_key_policy](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/kms_key_policies) | resource |
| [ibm_kms_key_policies.standard_key_policy](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/kms_key_policies) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_dual_auth_delete_enabled"></a> [dual\_auth\_delete\_enabled](#input\_dual\_auth\_delete\_enabled) | If set to true, Key Protect enables a dual authorization policy on a single key. Note: Once the dual authorization policy is set on the key, it cannot be reverted. A key with dual authorization policy enabled cannot be destroyed by using Terraform. | `bool` | `false` | no |
| <a name="input_endpoint_type"></a> [endpoint\_type](#input\_endpoint\_type) | Endpoint to use when creating the Key | `string` | `"private"` | no |
| <a name="input_force_delete"></a> [force\_delete](#input\_force\_delete) | Set as true to enable forcing deletion even if key is in use | `bool` | `false` | no |
| <a name="input_key_name"></a> [key\_name](#input\_key\_name) | Name to give the key | `string` | n/a | yes |
| <a name="input_key_protect_instance_id"></a> [key\_protect\_instance\_id](#input\_key\_protect\_instance\_id) | ID or GUID of Key Protect Instance | `string` | n/a | yes |
| <a name="input_key_protect_key_ring_id"></a> [key\_protect\_key\_ring\_id](#input\_key\_protect\_key\_ring\_id) | The ID of the key ring where you want to add your Key Protect key | `string` | `"default"` | no |
| <a name="input_rotation_interval_month"></a> [rotation\_interval\_month](#input\_rotation\_interval\_month) | The key rotation time interval in months. Rotation policy cannot be set for standard key, so value is ignored if var.standard\_key is true | `number` | `1` | no |
| <a name="input_standard_key"></a> [standard\_key](#input\_standard\_key) | Set as true for Standard Key, false for Root Key | `bool` | `false` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_crn"></a> [crn](#output\_crn) | Key CRN |
| <a name="output_dual_auth_delete"></a> [dual\_auth\_delete](#output\_dual\_auth\_delete) | Is Dual Auth Delete Enabled |
| <a name="output_key_id"></a> [key\_id](#output\_key\_id) | Key ID |
| <a name="output_rotation_interval_month"></a> [rotation\_interval\_month](#output\_rotation\_interval\_month) | Month Interval for Rotation |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
<!-- BEGIN CONTRIBUTING HOOK -->

<!-- Leave this section as is so that your module has a link to local development environment set up steps for contributors to follow -->
## Contributing

You can report issues and request features for this module in GitHub issues in the module repo. See [Report an issue or request a feature](https://github.com/terraform-ibm-modules/.github/blob/main/.github/SUPPORT.md).

To set up your local development environment, see [Local development setup](https://terraform-ibm-modules.github.io/documentation/#/local-dev-setup) in the project documentation.
<!-- Source for this readme file: https://github.com/terraform-ibm-modules/common-dev-assets/tree/main/module-assets/ci/module-template-automation -->
<!-- END CONTRIBUTING HOOK -->

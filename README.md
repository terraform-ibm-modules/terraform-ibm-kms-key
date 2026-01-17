# KMS key module

[![Graduated (Supported)](https://img.shields.io/badge/Status-Graduated%20(Supported)-brightgreen)](https://terraform-ibm-modules.github.io/documentation/#/badge-status)
[![semantic-release](https://img.shields.io/badge/%20%20%F0%9F%93%A6%F0%9F%9A%80-semantic--release-e10079.svg)](https://github.com/semantic-release/semantic-release)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)
[![latest release](https://img.shields.io/github/v/release/terraform-ibm-modules/terraform-ibm-kms-key?logo=GitHub&sort=semver)](https://github.com/terraform-ibm-modules/terraform-ibm-kms-key/releases/latest)
[![Renovate enabled](https://img.shields.io/badge/renovate-enabled-brightgreen.svg)](https://renovatebot.com/)

This module supports creating a standard or root key in an existing key ring and KMS instance. KMS can be Key Protect or Hyper Protect Crypto Services (HPCS) Standard plan instance. You can specify rotation and deletion policies for the keys.

<!-- Below content is automatically populated via pre-commit hook -->
<!-- BEGIN OVERVIEW HOOK -->
## Overview
* [terraform-ibm-kms-key](#terraform-ibm-kms-key)
* [Examples](./examples)
:information_source: Ctrl/Cmd+Click or right-click on the Schematics deploy button to open in a new tab
    * <a href="./examples/basic">Basic example</a> <a href="https://cloud.ibm.com/schematics/workspaces/create?workspace_name=kms-key-basic-example&repository=https://github.com/terraform-ibm-modules/terraform-ibm-kms-key/tree/main/examples/basic"><img src="https://img.shields.io/badge/Deploy%20with IBM%20Cloud%20Schematics-0f62fe?logo=ibm&logoColor=white&labelColor=0f62fe" alt="Deploy with IBM Cloud Schematics" style="height: 16px; vertical-align: text-bottom; margin-left: 5px;"></a>
    * <a href="./examples/complete">Complete example</a> <a href="https://cloud.ibm.com/schematics/workspaces/create?workspace_name=kms-key-complete-example&repository=https://github.com/terraform-ibm-modules/terraform-ibm-kms-key/tree/main/examples/complete"><img src="https://img.shields.io/badge/Deploy%20with IBM%20Cloud%20Schematics-0f62fe?logo=ibm&logoColor=white&labelColor=0f62fe" alt="Deploy with IBM Cloud Schematics" style="height: 16px; vertical-align: text-bottom; margin-left: 5px;"></a>
* [Contributing](#contributing)
<!-- END OVERVIEW HOOK -->

## terraform-ibm-kms-key

### Usage

```hcl
provider "ibm" {
  ibmcloud_api_key = "XXXXXXXXXX"
  # Must be the same region the KMS instance is in
  region           = "us-south"
}

# KMS root key
module "kms_root_key" {
  source          = "terraform-ibm-modules/kms-key/ibm"
  version         = "X.X.X" # Replace "X.X.X" with a release version to lock into a specific release
  kms_instance_id = "XXxxXXxx-xxxx-XXXX-xxxx-XXxxXXxx"
  key_name        = "my-root-key"
}

# KMS standard key
module "kms_standard_key" {
  source          = "terraform-ibm-modules/kms-key/ibm"
  version         = "X.X.X" # Replace "X.X.X" with a release version to lock into a specific release
  kms_instance_id = "XXxxXXxx-xxxx-XXXX-xxxx-XXxxXXxx"
  key_name        = "my-standard-key"
  standard_key    = true
}
```

### Required IAM access policies
You need the following permissions to run this module.

- Account Management
    - **Resource Group** service
        - `Viewer` platform access
- IAM Services
    - **KMS** service
        - `Viewer` platform access
        - `Manager` service access

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
### Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.0 |
| <a name="requirement_ibm"></a> [ibm](#requirement\_ibm) | >= 1.79.0, < 2.0.0 |

### Modules

No modules.

### Resources

| Name | Type |
|------|------|
| [ibm_kms_key.key](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/kms_key) | resource |
| [ibm_kms_key_policies.root_key_policy](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/kms_key_policies) | resource |
| [ibm_kms_key_policies.standard_key_policy](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/kms_key_policies) | resource |
| [ibm_kms_kmip_adapter.kmip_adapter](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/kms_kmip_adapter) | resource |
| [ibm_kms_kmip_client_cert.kmip_cert](https://registry.terraform.io/providers/IBM-Cloud/ibm/latest/docs/resources/kms_kmip_client_cert) | resource |

### Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_dual_auth_delete_enabled"></a> [dual\_auth\_delete\_enabled](#input\_dual\_auth\_delete\_enabled) | If set to true, KMS enables a dual authorization policy on a single key. Note: Once the dual authorization policy is set on the key, it cannot be reverted. A key with dual authorization policy enabled cannot be destroyed by using Terraform. | `bool` | `false` | no |
| <a name="input_endpoint_type"></a> [endpoint\_type](#input\_endpoint\_type) | Endpoint to use when creating the Key | `string` | `"public"` | no |
| <a name="input_force_delete"></a> [force\_delete](#input\_force\_delete) | Set as true to enable forcing deletion even if key is in use | `bool` | `false` | no |
| <a name="input_key_name"></a> [key\_name](#input\_key\_name) | Name to give the key | `string` | n/a | yes |
| <a name="input_kmip"></a> [kmip](#input\_kmip) | Allows a key to utilize the key management interoperability protocol (KMIP), for more information see https://cloud.ibm.com/docs/key-protect?topic=key-protect-kmip | <pre>list(object({<br/>    name        = string<br/>    description = optional(string)<br/>    certificates = optional(list(object({<br/>      name        = optional(string)<br/>      certificate = string<br/>    })))<br/>  }))</pre> | `[]` | no |
| <a name="input_kms_instance_id"></a> [kms\_instance\_id](#input\_kms\_instance\_id) | ID or GUID of KMS Instance | `string` | n/a | yes |
| <a name="input_kms_key_ring_id"></a> [kms\_key\_ring\_id](#input\_kms\_key\_ring\_id) | The ID of the key ring where you want to add your KMS key | `string` | `"default"` | no |
| <a name="input_rotation_interval_month"></a> [rotation\_interval\_month](#input\_rotation\_interval\_month) | The key rotation time interval in months. Rotation policy cannot be set for standard key, so value is ignored if var.standard\_key is true | `number` | `1` | no |
| <a name="input_standard_key"></a> [standard\_key](#input\_standard\_key) | Set as true for Standard Key, false for Root Key | `bool` | `false` | no |

### Outputs

| Name | Description |
|------|-------------|
| <a name="output_adapter_ids"></a> [adapter\_ids](#output\_adapter\_ids) | KMIP Adapter IDs of the associated root key |
| <a name="output_cert_ids"></a> [cert\_ids](#output\_cert\_ids) | KMIP Cert IDs |
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

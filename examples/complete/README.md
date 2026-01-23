# Complete example

<!-- BEGIN SCHEMATICS DEPLOY HOOK -->
<a href="https://cloud.ibm.com/schematics/workspaces/create?workspace_name=kms-key-complete-example&repository=https://github.com/terraform-ibm-modules/terraform-ibm-kms-key/tree/main/examples/complete"><img src="https://img.shields.io/badge/Deploy%20with IBM%20Cloud%20Schematics-0f62fe?logo=ibm&logoColor=white&labelColor=0f62fe" alt="Deploy with IBM Cloud Schematics" style="height: 16px; vertical-align: text-bottom;"></a>
<!-- END SCHEMATICS DEPLOY HOOK -->


A complete example showing how to provision a Key Protect instance, a root key and a standard key.

The following resources are provisioned by this example:
 - A new resource group, if an existing one is not passed in.
 - An IBM Key Protect instance.
 - A Root Key in the KMS instance.
 - A Standard Key in the KMS instance.

<!-- BEGIN SCHEMATICS DEPLOY TIP HOOK -->
:information_source: Ctrl/Cmd+Click or right-click on the Schematics deploy button to open in a new tab
<!-- END SCHEMATICS DEPLOY TIP HOOK -->

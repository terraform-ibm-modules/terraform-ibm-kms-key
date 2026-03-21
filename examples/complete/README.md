# Complete example

<!-- BEGIN SCHEMATICS DEPLOY HOOK -->
<p>
  <a href="https://cloud.ibm.com/schematics/workspaces/create?workspace_name=kms-key-complete-example&repository=https://github.com/terraform-ibm-modules/terraform-ibm-kms-key/tree/main/examples/complete">
    <img src="https://img.shields.io/badge/Deploy%20with%20IBM%20Cloud%20Schematics-0f62fe?style=flat&logo=ibm&logoColor=white&labelColor=0f62fe" alt="Deploy with IBM Cloud Schematics">
  </a><br>
  ℹ️ Ctrl/Cmd+Click or right-click on the Schematics deploy button to open in a new tab.
</p>
<!-- END SCHEMATICS DEPLOY HOOK -->

A complete example showing how to provision a Key Protect instance, a root key and a standard key.

The following resources are provisioned by this example:
 - A new resource group, if an existing one is not passed in.
 - An IBM Key Protect instance.
 - A Root Key in the KMS instance.
 - A Standard Key in the KMS instance.

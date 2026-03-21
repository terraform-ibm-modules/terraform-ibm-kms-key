# Basic example

<!-- BEGIN SCHEMATICS DEPLOY HOOK -->
<p>
  <a href="https://cloud.ibm.com/schematics/workspaces/create?workspace_name=kms-key-basic-example&repository=https://github.com/terraform-ibm-modules/terraform-ibm-kms-key/tree/main/examples/basic">
    <img src="https://img.shields.io/badge/Deploy%20with%20IBM%20Cloud%20Schematics-0f62fe?style=flat&logo=ibm&logoColor=white&labelColor=0f62fe" alt="Deploy with IBM Cloud Schematics">
  </a><br>
  ℹ️ Ctrl/Cmd+Click or right-click on the Schematics deploy button to open in a new tab.
</p>
<!-- END SCHEMATICS DEPLOY HOOK -->

A simple example that shows how to create a standard and a root key in an existing IBM Key Management Service (KMS) instance.

## Before you begin
Make sure you have an existing KMS instance. The example requires the GUID from the instance.

The example provisions the following resources:
 - A root key in the existing KMS instance.
 - A standard key in the existing KMS instance.

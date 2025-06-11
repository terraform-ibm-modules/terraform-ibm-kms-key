terraform {
  required_version = ">= 1.9.0"
  required_providers {
    ibm = {
      source = "IBM-Cloud/ibm"
      # Use "greater than or equal to" range in modules
      version = ">= 1.79.0, < 2.0.0"
    }
  }
}

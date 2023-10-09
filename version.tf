terraform {
  required_version = ">= 1.0.0, <1.6.0"
  required_providers {
    ibm = {
      source = "IBM-Cloud/ibm"
      # Use "greater than or equal to" range in modules
      version = ">= 1.49.0"
    }
  }
}

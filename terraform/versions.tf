terraform {
  required_providers {
    ignition = {
      source  = "community-terraform-providers/ignition"
      version = ">= 2.1.1"
    }
  }
  required_version = ">= 0.13"
}

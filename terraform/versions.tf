terraform {
  required_providers {
    ignition = {
      source  = "community-terraform-providers/ignition"
      version = "~> 2.7"
    }
  }
  required_version = ">= 1.0"
}

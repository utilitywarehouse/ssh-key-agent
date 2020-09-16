terraform {
  required_providers {
    ignition = {
      source = "terraform-providers/ignition"
    }
    template = {
      source = "hashicorp/template"
    }
  }
  required_version = ">= 0.13"
}

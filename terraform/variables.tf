variable "arch" {
  type        = string
  description = "The ssh-key-agent binary arch to fecth if not running in docker"
  default     = "amd64"
  validation {
    condition     = contains(["amd64", "arm64"], var.arch)
    error_message = "Arch should be one of: amd64, arm64"
  }
}

variable "uri" {
  type        = string
  description = "The S3 URI of the authmap file"
}

variable "groups" {
  type        = list(any)
  description = "A list of allowed google groups"
}

variable "agent_version" {
  type        = string
  default     = "v1.0.16"
  description = "The ssh-key-agent version"
}

variable "enabled" {
  type        = string
  default     = true
  description = "Whether or not the service shall be enabled"
}

locals {
  vless_agent_version = trimprefix(var.agent_version, "v")
}

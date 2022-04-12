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
  default     = "v1.0.13"
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

variable "uri" {
  type        = string
  description = "The S3 URI of the authmap file"
}

variable "groups" {
  type        = list
  description = "A list of allowed google groups"
}

variable "agent_version" {
  type        = string
  default     = "1.0.10"
  description = "The ssh-key-agent version"
}

variable "enabled" {
  type        = string
  default     = true
  description = "Whether or not the service shall be enabled"
}

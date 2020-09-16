data "ignition_systemd_unit" "ssh-key-agent" {
  name    = "ssh-key-agent.service"
  enabled = var.enabled
  content = templatefile("${path.module}/resources/ssh-key-agent.service",
    {
      uri     = var.uri
      groups  = "${join(",", var.groups)}"
      version = var.ssh_key_agent_version
    }
  )
}

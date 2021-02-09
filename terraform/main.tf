data "ignition_file" "ssh_key_agent" {
  mode       = 493
  filesystem = "root"
  path       = "/opt/bin/ssh-key-agent"

  source {
    source = "https://github.com/utilitywarehouse/ssh-key-agent/releases/download/${var.agent_version}/ssh-key-agent_${var.agent_version}_linux_amd64"
  }
}

data "ignition_systemd_unit" "ssh_key_agent" {
  name    = "ssh-key-agent.service"
  enabled = var.enabled
  content = templatefile("${path.module}/resources/ssh-key-agent.service",
    {
      uri     = var.uri
      groups  = join(",", var.groups)
      version = var.agent_version
    }
  )
}

data "ignition_systemd_unit" "ssh_key_agent_download" {
  name    = "ssh-key-agent-download.service"
  enabled = var.enabled
  content = templatefile("${path.module}/resources/ssh-key-agent-download.service",
    {
      source = "https://github.com/utilitywarehouse/ssh-key-agent/releases/download/${var.agent_version}/ssh-key-agent_${var.agent_version}_linux_amd64"
    }
  )
}

data "ignition_systemd_unit" "ssh_key_agent_docker" {
  name    = "ssh-key-agent.service"
  enabled = var.enabled
  content = templatefile("${path.module}/resources/ssh-key-agent-docker.service",

    {
      uri     = var.uri
      groups  = join(",", var.groups)
      version = var.agent_version
    }
  )
}

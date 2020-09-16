data "template_file" "ssh-key-agent" {
  template = "${file("${path.module}/resources/ssh-key-agent.service")}"

  vars = {
    uri     = var.uri
    groups  = "${join(",", var.groups)}"
    version = var.ssh_key_agent_version
  }
}

data "ignition_systemd_unit" "ssh-key-agent" {
  name    = "ssh-key-agent.service"
  enabled = var.enabled
  content = data.template_file.ssh-key-agent.rendered
}

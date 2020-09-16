output "id" {
  value = data.ignition_systemd_unit.ssh-key-agent.id
}

output "template_rendered" {
  value = data.template_file.ssh-key-agent.rendered
}

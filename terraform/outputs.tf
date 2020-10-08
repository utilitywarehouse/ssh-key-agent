output "unit" {
  value = data.ignition_systemd_unit.ssh-key-agent.rendered
}

output "file" {
  value = data.ignition_file.ssh-key-agent.rendered
}

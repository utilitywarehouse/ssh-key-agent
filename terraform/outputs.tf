output "unit" {
  value = data.ignition_systemd_unit.ssh_key_agent.rendered
}

output "file" {
  value = data.ignition_file.ssh_key_agent.rendered
}

output "docker_unit" {
  value = data.ignition_systemd_unit.ssh_key_agent_docker.rendered
}

output "download_unit" {
  value = data.ignition_systemd_unit.ssh_key_agent_download.rendered
}

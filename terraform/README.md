This terraform module returns an ignition systemd unit for running
ssh-key-agent as a service on Kinvolk's Flatcar Linux.

## Input Variables
The input variables are documented in their description and it's best to refer
to [variables.tf](variables.tf).

## Outputs
- `id` - the id of the ignition systemd unit file
- `template_rendered` - the systemd unit template, rendered with the provided variables

## Usage
```hcl
module "ssh_key_agent" {
  source = "github.com/utilitywarehouse/tf_ssh_key_agent"

  groups  = [
    "ssh-dev@example-org.com",
    "ssh-admin@example-org.com"
  ]

  ssh_key_agent_version = "1.0.4"
  uri                   = "https://s3-eu-west-1.amazonaws.com/example-keys-cache/authmap"
}
```

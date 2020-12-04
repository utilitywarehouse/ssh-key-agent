This terraform module returns an ignition systemd unit for running
ssh-key-agent as a service on Kinvolk's Flatcar Linux.

## Input Variables
The input variables are documented in their description and it's best to refer
to [variables.tf](variables.tf).

## Outputs
Binary use:
- `unit` - ignition systemd unit
- `file` - ssh-key-agent binary ignition file

Docker use:
- `docker_unit` - systemd service that runs ssh-key-agent as a docker container

If unable to use `file` resource in binary installation:
- `download-unit` - systemd service to download the ssh-key-agent binary

## Usage
```hcl
module "ssh_key_agent" {
  source = "github.com/utilitywarehouse/ssh-key-agent//terraform"

  groups  = [
    "ssh-dev@example-org.com",
    "ssh-admin@example-org.com"
  ]

  uri = "https://s3-eu-west-1.amazonaws.com/example-keys-cache/authmap"
}
```

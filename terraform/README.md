This terraform module returns an ignition systemd unit for running
ssh-key-agent as a service on Kinvolk's Flatcar Linux.

## Input Variables
The input variables are documented in their description and it's best to refer
to [variables.tf](variables.tf).

## Outputs
- `unit` - the ignition systemd unit file
- `file` - the ignition file to setup the ssh-key-agent binary

## Usage
```hcl
module "ssh_key_agent" {
  source = "github.com/utilitywarehouse/ssh-key-agent//terraform"

  groups  = [
    "ssh-dev@example-org.com",
    "ssh-admin@example-org.com"
  ]

  uri                   = "https://s3-eu-west-1.amazonaws.com/example-keys-cache/authmap"
}
```

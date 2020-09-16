# ssh-key-agent

[![Docker Repository on Quay](https://quay.io/repository/utilitywarehouse/ssh-key-agent/status "Docker Repository on Quay")](https://quay.io/repository/utilitywarehouse/ssh-key-agent)

Companion service for https://github.com/utilitywarehouse/ssh-key-manager runs
on the host and populates `authorized_keys` file based on the groups provided.

### client

Required environment variables:

| env var       | example                                          | desc                                                                   |
| -------       | -------                                          | ----                                                                   |
| SKA_KEY_URI   | https://[app/bucket]/authmap                     | URI location of the authmap file create by ssh-key-manager             |
| SKA_GROUPS    | group@gsuite-domain.com,group2@gsuite-domain.com | Comma seperated list of groups that are allowed access                 |
| SKA_AKF_LOC   | /home/user/.ssh/authorized_keys                  | Location of the `authorized_keys` file which to write to               |
| SKA_INTERVAL  | 60                                               | Interval, how often the keys should be synced (seconds) AWS access key |

#### systemd service file

Requires docker install

Whatever file you are mounting into container needs to exist prior, otherwise
docker will create it as directory:

> If you use -v or --volume to bind-mount a file or directory that does not yet
> exist on the Docker host, -v will create the endpoint for you. It is always
> created as a directory.

example Systemd service: [./terraform/resources/ssh-key-agent.service](./terraform/resources/ssh-key-agent.service)

### terraform module

Repository includes a terraform module, for use instructions have a look at
[./terraform/README.md](./terraform/README.md)

# ssh-key-agent

[![Build Status](https://drone.prod.merit.uw.systems/api/badges/utilitywarehouse/ssh-key-agent/status.svg)](https://drone.prod.merit.uw.systems/utilitywarehouse/ssh-key-agent)

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

Example Systemd service: [./terraform/resources/ssh-key-agent.service](./terraform/resources/ssh-key-agent.service)

### terraform module

Repository includes a terraform module, for use instructions have a look at
[./terraform/README.md](./terraform/README.md)

### releasing

Before creating a tag/release in Github, please update the verion in [./terraform/variables.tf](./terraform/variables.tf)

### Docker instructions

If you prefer to run ssh-key-agent with docker, here's an example service:

```
[Unit]
Description=ssh-key-agent
After=docker.service
Requires=docker.service
[Service]
Restart=on-failure
ExecStartPre=-/usr/bin/mkdir -p /home/core/.ssh
ExecStartPre=-/usr/bin/touch /home/core/.ssh/authorized_keys
ExecStartPre=-/usr/bin/chown -R "core":"core" /home/core/.ssh
ExecStartPre=-/usr/bin/chmod 700 /home/core/.ssh
ExecStartPre=-/usr/bin/chmod 644 /home/core/.ssh/authorized_keys
ExecStart=/bin/sh -c 'docker run --name=%p_$(uuidgen) --rm \
 -v /home/core/.ssh/authorized_keys:/authorized_keys \
 -e SKA_KEY_URI=${uri} \
 -e SKA_GROUPS=${groups} \
 -e SKA_AKF_LOC=/authorized_keys \
 -e SKA_INTERVAL=60 \
 quay.io/utilitywarehouse/ssh-key-agent:${version}'
ExecStop=/bin/sh -c 'docker stop -t 3 "$(docker ps -q --filter=name=%p_)"'
[Install]
WantedBy=multi-user.target
```

Whatever file you are mounting into container needs to exist prior, otherwise
docker will create it as directory:

> If you use -v or --volume to bind-mount a file or directory that does not yet
> exist on the Docker host, -v will create the endpoint for you. It is always
> created as a directory.

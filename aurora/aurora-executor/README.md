# Aurora executor docker image

Current version of components:
- Mesos: 1.0.1
- Aurora-scheduler: 0.16.0
- Bease OS/docker image: centos-7

## Quick start

### Configuration.

Configuration parameters can be managed with environment variables:

```
# Defaults for Aurora executor startup
ENV AURORA_HOME /var/lib/aurora
ENV MESOS_ROOT /var/lib/mesos
ENV OBSERVER_PORT 1338
```

Please refer to Aurora documentation for details.  

### Usage

1. Starting an aurora executor instance. Executors should be started on all slave nodes (agents)

`docker run --net=host -v /var/lib/mesos:/var/lib/mesos:rw krot/aurora-executor thermos_observer`

2. DC/OS service JSON. Don't forget to add the hostname:UNIQUE constrain in order to start only one executor on each agent.

```
{
  "id": "/aurora/aurora-executor",
  "env": {
    "MESOS_ROOT": "/var/lib/mesos/slave"
  },
  "instances": 20,
  "cpus": 1,
  "mem": 128,
  "disk": 0,
  "gpus": 0,
  "constraints": [
    [
      "hostname",
      "UNIQUE"
    ]
  ],
  "container": {
    "docker": {
      "image": "krot/aurora-executor",
      "forcePullImage": true,
      "privileged": false,
      "network": "HOST"
    },
    "type": "DOCKER",
    "volumes": [
      {
        "containerPath": "/var/lib/mesos/slave",
        "hostPath": "/var/lib/mesos/slave",
        "mode": "RW"
      },
      {
        "containerPath": "/var/lib/aurora",
        "hostPath": "/var/lib/aurora",
        "mode": "RW"
      }
    ]
  }
}
```

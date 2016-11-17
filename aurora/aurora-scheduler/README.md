# Aurora scheduler docker image

This docker image is aimed at integrating Apache aurora framework with DC/OS.
Current version of components:
- Mesos: 1.0.1
- Aurora-scheduler: 0.16.0
- Bease OS/docker image: centos-7

## Quick start

### Configuration.

Configuration parameters can be managed with environment variables:

```
# Defaults for Aurora scheduler startup
# Environment variables control the behavior of the Mesos scheduler driver (libmesos).
ENV LIBPROCESS_PORT 8083
# ENV LIBPROCESS_IP=127.0.0.1
ENV GLOG_v 0

ENV AURORA_HOME /var/lib/aurora
# Name of the cluster. Please change this.
ENV CLUSTER_NAME example
# Listening port for the scheduler
ENV HTTP_PORT 8088
# Replicated log quorum size. Set to (floor(number_of_schedulers / 2) + 1)
ENV QUORUM_SIZE 1
# List of zookeeper endpoints
ENV ZK_ENDPOINTS 127.0.0.1:2181
# Zookeeper path or URL to mesos master
ENV MESOS_MASTER zk://${ZK_ENDPOINTS}/mesos
# ENV MESOS_MASTER "http://127.0.0.1:5050"
# ENV MESOS_ROLE " "
# Zookeeper ServerSet path to register at
ENV ZK_SERVERSET_PATH /aurora/scheduler
# Log path in zookeeper
ENV ZK_LOGDB_PATH /aurora/replicated-log
# Where to store the replicated log on disk
ENV LOGDB_FILE_PATH=${AURORA_HOME}/scheduler/db
# Where to store backups on disk
ENV BACKUP_DIR ${AURORA_HOME}/scheduler/backups
# Path (on the slave nodes) or URL to thermos executor or wrapper script
ENV THERMOS_EXECUTOR_PATH "/usr/bin/thermos_executor"
# A comma seperated list of additional resources to copy into the sandbox.
# Note: if thermos_executor_path is not the thermos_executor.pex file itself,
# this must include it.
ENV THERMOS_EXECUTOR_RESOURCES " "
# Extra arguments to be passed to the thermos executor
ENV THERMOS_EXECUTOR_FLAGS --announcer-ensemble 127.0.0.1:2181
# Container types that are allowed to be used by jobs.
ENV ALLOWED_CONTAINER_TYPES 'MESOS,DOCKER'
# Any args you want to add to the aurora-scheduler invocation:
ENV EXTRA_SCHEDULER_ARGS " "
```

Please refer to Aurora documentation for details.

### Usage

1. Starting an aurora scheduler instance

`docker run --net=host -e "CLUSTER_NAME=YourClaster" -e "ZK_ENDPOINTS=master.mesos:2181" -e "MESOS_MASTER=zk://master.mesos:2181/mesos" krot/aurora-scheduler aurora-scheduler`

2. Start 3 - 5 schedulers for failure tolerance

`docker run --net=host -e "CLUSTER_NAME=YourClaster" -e "ZK_ENDPOINTS=master.mesos:2181" -e "MESOS_MASTER=zk://master.mesos:2181/mesos" -e "QUORUM_SIZE=2" krot/aurora-scheduler aurora-scheduler`

3. Enabling gpu support

`docker run --net=host -e "CLUSTER_NAME=YourClaster" -e "ZK_ENDPOINTS=master.mesos:2181" -e "MESOS_MASTER=zk://master.mesos:2181/mesos" -e "EXTRA_SCHEDULER_ARGS='-allow_gpu_resource=true'" krot/aurora-scheduler aurora-scheduler`

4. DC/OS service JSON

```
{
  "id": "/aurora/aurora-scheduler",
  "env": {
    "CLUSTER_NAME": "\"YourCluster\"",
    "ZK_ENDPOINTS": "\"master.mesos:2181\"",
    "MESOS_MASTER": "\"zk://master.mesos:2181/mesos\""
  },
  "instances": 3,
  "cpus": 1,
  "mem": 1024,
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
      "image": "krot/aurora-scheduler",
      "forcePullImage": true,
      "privileged": false,
      "network": "HOST"
    },
    "type": "DOCKER",
    "volumes": [
      {
        "containerPath": "/var/lib/aurora",
        "hostPath": "/var/lib/aurora",
        "mode": "RW"
      }
    ]
  }
}
```

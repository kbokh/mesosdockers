FROM centos:7
MAINTAINER Kostaintyn Bokhan <konstboh@gmail.com>

# Add image description and version
ENV IMAGE_DESCRIPTION aurora
ENV IMAGE_VERSION 0.1
ENV AURORA_VERSION 0.16.0
ENV MESOS_VERSION 1.0.1


RUN yum update -y && \
    yum install -y wget python2.7 libcurl4-nss-dev

RUN wget --no-cookies --no-check-certificate \
      http://repos.mesosphere.com/el/7/x86_64/RPMS/mesos-1.0.1-2.0.93.centos701406.x86_64.rpm \
      -O /tmp/mesos-1.0.1-2.0.93.centos701406.x86_64.rpm && \
    yum localinstall -y /tmp/mesos-1.0.1-2.0.93.centos701406.x86_64.rpm && \
    rm -f /tmp/mesos-1.0.1-2.0.93.centos701406.x86_64.rpm

RUN wget -c https://apache.bintray.com/aurora/centos-7/aurora-scheduler-${AURORA_VERSION}-1.el7.centos.aurora.x86_64.rpm \
         -O /tmp/aurora-scheduler-${AURORA_VERSION}-1.el7.centos.aurora.x86_64.rpm && \
    yum localinstall -y /tmp/aurora-scheduler-${AURORA_VERSION}-1.el7.centos.aurora.x86_64.rpm && \
    rm -f /tmp/aurora-scheduler-${AURORA_VERSION}-1.el7.centos.aurora.x86_64.rpm && \
    yum erase -y wget && \
    yum clean all

ENV PATH /usr/lib/aurora/bin:$PATH
ENV JAVA_HOME /usr/lib/jvm/java-1.8.0-openjdk-1.8.0.111-1.b15.el7_2.x86_64/jre
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
# ENV THERMOS_EXECUTOR_PATH ${AURORA_HOME}/bin/thermos_executor
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

COPY docker-entrypoint.sh /
RUN chmod a+x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE $HTTP_PORT

CMD ["aurora-scheduler"]

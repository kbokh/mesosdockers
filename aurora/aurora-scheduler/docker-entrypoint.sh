#!/bin/bash
set -e

if [ "${1:0:1}" = '-' ]; then
	set -- aurora-scheduler "$@"
fi

if [ "$1" = 'aurora-scheduler' ]; then
  if ! [ -n "$(ls -A $LOGDB_FILE_PATH)" ]; then
		echo "Creating $LOGDB_FILE_PATH ..."
		mkdir -p "$LOGDB_FILE_PATH"
    mesos-log initialize --path="$LOGDB_FILE_PATH"
    chown -R aurora:aurora "$AURORA_HOME"
  fi
	exec "$@" -framework_name="$FRAMEWORK_NAME" -cluster_name="$CLUSTER_NAME" -http_port="$HTTP_PORT" -native_log_quorum_size="$QUORUM_SIZE" -zk_endpoints="$ZK_ENDPOINTS" -mesos_master_address="$MESOS_MASTER" -serverset_path="$ZK_SERVERSET_PATH" -native_log_zk_group_path="$ZK_LOGDB_PATH" -native_log_file_path="$LOGDB_FILE_PATH" -backup_dir="$BACKUP_DIR" -thermos_executor_path="$THERMOS_EXECUTOR_PATH"  -thermos_executor_resources="$THERMOS_EXECUTOR_RESOURCES" -thermos_executor_flags="$THERMOS_EXECUTOR_FLAGS"  -allowed_container_types="$ALLOWED_CONTAINER_TYPES" -allow_docker_parameters="$ALLOW_DOCKER_PARAMETERS" -allow_gpu_resource="$ALLOW_GPU_RESOURCE" $EXTRA_SCHEDULER_ARGS
fi

exec "$@"

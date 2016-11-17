#!/bin/bash
set -e

if [ "${1:0:1}" = '-' ]; then
	set -- thermos_observer "$@"
fi

if [ "$1" = 'thermos_observer' ]; then
	echo "Creating folder ..."
	mkdir -vp "${AURORA_HOME}/bin"
	echo "Copying executor ..."
	cp -vf /usr/bin/thermos_executor "${AURORA_HOME}/bin/thermos_executor"
	exec "$@" --port="$OBSERVER_PORT" --mesos-root="$MESOS_ROOT" --log_to_disk=NONE --log_to_stderr=google:INFO

fi

exec "$@"

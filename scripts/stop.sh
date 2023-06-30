#!/bin/bash

cd `dirname $0`

CONTEXT_ROOT=$(dirname $(pwd))

SUCCEEDED="undefined"

onexit() {
    if [ "${SUCCEEDED}" = "true" ]; then
        exit 0
    fi
    echo "Failed to stop grafana-loki."
    exit 1
}

trap 'onexit' EXIT

cd ${CONTEXT_ROOT}

docker compose stop grafana && \
docker compose stop loki && \
docker compose rm -f grafana && \
docker compose rm -f loki && \
SUCCEEDED="true"

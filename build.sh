#!/usr/bin/env bash

set -euo pipefail

if [[ -z "${GRAFANA_VERSION}" ]]; then
  echo "No GRAFANA_VERSION environment variable set"
  exit 1
fi

wget https://dl.grafana.com/oss/release/grafana-${GRAFANA_VERSION}.linux-amd64.tar.gz
echo "${GRAFANA_SHA_256}  grafana-${GRAFANA_VERSION}.linux-amd64.tar.gz" | sha256sum -c
tar -zxf grafana-${GRAFANA_VERSION}.linux-amd64.tar.gz
mv grafana-${GRAFANA_VERSION} grafana

#!/bin/bash -eux

build_prometheus() {
  # Prometheus version
  VERSION="2.48.0"
  wget https://github.com/prometheus/prometheus/releases/download/v${VERSION}/prometheus-${VERSION}.linux-amd64.tar.gz -O /workspace/_build/prometheus-${VERSION}.tar.gz -c

  mkdir -p /workspace/_build/prometheus
  tar xvzf /workspace/_build/prometheus-${VERSION}.tar.gz -C /workspace/_build/
  mv /workspace/_build/prometheus-${VERSION}.linux-amd64/* /workspace/_build/prometheus/
  cp /workspace/prometheus/prometheus.service /workspace/_build/prometheus/
  chown -R 1000:1000 /workspace/_build
  rm -rf /workspace/_build/prometheus-${VERSION}.tar.gz /workspace/_build/prometheus-${VERSION}.linux-amd64/

}

build_alertmanager() {
  # alertmanager version
  VERSION="0.26.0"
  wget https://github.com/prometheus/alertmanager/releases/download/v${VERSION}/alertmanager-${VERSION}.linux-amd64.tar.gz -O /workspace/_build/alertmanager-${VERSION}.tar.gz -c

  mkdir -p /workspace/_build/alertmanager
  tar xvzf /workspace/_build/alertmanager-${VERSION}.tar.gz -C /workspace/_build/
  mv /workspace/_build/alertmanager-${VERSION}.linux-amd64/* /workspace/_build/alertmanager/
  cp /workspace/alertmanager/prometheus-alertmanager.service /workspace/_build/alertmanager/
  chown -R 1000:1000 /workspace/_build
  rm -rf /workspace/_build/alertmanager-${VERSION}.tar.gz /workspace/_build/alertmanager-${VERSION}.linux-amd64/

}

build_postgres_exporter() {
  # postgres_exporter version
  VERSION="0.15.0"
  wget https://github.com/prometheus-community/postgres_exporter/releases/download/v${VERSION}/postgres_exporter-${VERSION}.linux-amd64.tar.gz -O /workspace/_build/postgres_exporter-${VERSION}.tar.gz -c

  mkdir -p /workspace/_build/postgres_exporter
  tar xvzf /workspace/_build/postgres_exporter-${VERSION}.tar.gz -C /workspace/_build/
  mv /workspace/_build/postgres_exporter-${VERSION}.linux-amd64/* /workspace/_build/postgres_exporter/
  cp /workspace/postgres-exporter/* /workspace/_build/postgres_exporter/
  chown -R 1000:1000 /workspace/_build
  rm -rf /workspace/_build/postgres_exporter-${VERSION}.tar.gz /workspace/_build/postgres_exporter-${VERSION}.linux-amd64/

}

build_node_exporter() {
  # node_exporter version
  VERSION="1.7.0"
  wget https://github.com/prometheus/node_exporter/releases/download/v${VERSION}/node_exporter-${VERSION}.linux-amd64.tar.gz -O /workspace/_build/node_exporter-${VERSION}.tar.gz -c

  mkdir -p /workspace/_build/node_exporter
  tar xvzf /workspace/_build/node_exporter-${VERSION}.tar.gz -C /workspace/_build/
  mv /workspace/_build/node_exporter-${VERSION}.linux-amd64/* /workspace/_build/node_exporter/
  cp /workspace/node-exporter/* /workspace/_build/node_exporter/
  chown -R 1000:1000 /workspace/_build
  rm -rf /workspace/_build/node_exporter-${VERSION}.tar.gz /workspace/_build/node_exporter-${VERSION}.linux-amd64/
}

apt update
apt install -y wget
mkdir -p /workspace/_build

case $1 in
  prometheus )
  build_prometheus
    ;;
  alertmanager )
  build_alertmanager
    ;;
  postgres_exporter )
  build_postgres_exporter
    ;;
  node_exporter )
  build_node_exporter
    ;;
  all )
  build_prometheus
  build_postgres_exporter
  build_node_exporter
  build_alertmanager
    ;;
  *)    # unknown option
  echo "Unknown option."
  exit 1
  ;;
esac

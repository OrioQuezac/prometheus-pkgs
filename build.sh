#!/bin/bash -eux

build_prometheus() {
  # Prometheus version
  VERSION="2.48.0"
  wget https://github.com/prometheus/prometheus/releases/download/v${VERSION}/prometheus-${VERSION}.linux-amd64.tar.gz -O _build/prometheus-${VERSION}.tar.gz -c

  mkdir -p _build/prometheus
  tar xvzf _build/prometheus-${VERSION}.tar.gz -C _build/
  mv _build/prometheus-${VERSION}.linux-amd64/* _build/prometheus/
  cp prometheus/prometheus.service _build/prometheus/
  chown -R 1000:1000 _build
  rm -rf _build/prometheus-${VERSION}.tar.gz _build/prometheus-${VERSION}.linux-amd64/

}

build_alertmanager() {
  # alertmanager version
  VERSION="0.26.0"
  wget https://github.com/prometheus/alertmanager/releases/download/v${VERSION}/alertmanager-${VERSION}.linux-amd64.tar.gz -O _build/alertmanager-${VERSION}.tar.gz -c

  mkdir -p _build/alertmanager
  tar xvzf _build/alertmanager-${VERSION}.tar.gz -C _build/
  mv _build/alertmanager-${VERSION}.linux-amd64/* _build/alertmanager/
  cp alertmanager/prometheus-alertmanager.service _build/alertmanager/
  chown -R 1000:1000 _build
  rm -rf _build/alertmanager-${VERSION}.tar.gz _build/alertmanager-${VERSION}.linux-amd64/

}

build_postgres_exporter() {
  # postgres_exporter version
  VERSION="0.15.0"
  wget https://github.com/prometheus-community/postgres_exporter/releases/download/v${VERSION}/postgres_exporter-${VERSION}.linux-amd64.tar.gz -O _build/postgres_exporter-${VERSION}.tar.gz -c

  mkdir -p _build/postgres_exporter
  tar xvzf _build/postgres_exporter-${VERSION}.tar.gz -C _build/
  mv _build/postgres_exporter-${VERSION}.linux-amd64/* _build/postgres_exporter/
  cp postgres-exporter/* _build/postgres_exporter/
  chown -R 1000:1000 _build
  rm -rf _build/postgres_exporter-${VERSION}.tar.gz _build/postgres_exporter-${VERSION}.linux-amd64/

}

build_node_exporter() {
  # node_exporter version
  VERSION="1.7.0"
  wget https://github.com/prometheus/node_exporter/releases/download/v${VERSION}/node_exporter-${VERSION}.linux-amd64.tar.gz -O _build/node_exporter-${VERSION}.tar.gz -c

  mkdir -p _build/node_exporter
  tar xvzf _build/node_exporter-${VERSION}.tar.gz -C _build/
  mv _build/node_exporter-${VERSION}.linux-amd64/* _build/node_exporter/
  cp node-exporter/* _build/node_exporter/
  chown -R 1000:1000 _build
  rm -rf _build/node_exporter-${VERSION}.tar.gz _build/node_exporter-${VERSION}.linux-amd64/
}

apt update
apt install -y wget
mkdir -p _build

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

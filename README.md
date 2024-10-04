# prometheus-pkgs

This repository provides some utilities to package `prometheus` and `exporters` for Debian(-likes) and RedHat(-likes). 

## How to build

These packages are build with `nfpm` and require docker (and docker compose) to build locally. 

Build all packages : 
```
$ make all 
```

Build prometheus packages : 
```
$ make prometheus-pkgs
```

Build altermanager packages : 
```
$ make prometheus-alertmanager
```

Build postgres_exporter packages : 
```
$ make postgres_exporter
```

Build node_exporter packages : 
```
$ make node_exporter 
```

## How to update versions 

The version of each component is stored in the `build.sh` script. 
E.g. For prometheus : 
```
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
```

To get the latest version, go to the prometheus project repository and apply the latest version number to the `$VERSION` variable in the `build.sh` script. 

## Releases 

Each package is available in Release page of this repository. 
When creating a new tag starting with a letter "v" (e.g. v2023-11-30), the GitHub Workflow will create a new release with new packages. 
For more details, please consult the `.github/workflows` directory. 

all:
	PKG=all docker-compose run --rm build
	PKG=prometheus docker-compose run --rm nfpm-rpm
	PKG=prometheus docker-compose run --rm nfpm-deb
	PKG=alertmanager docker-compose run --rm nfpm-rpm
	PKG=alertmanager docker-compose run --rm nfpm-deb
	PKG=postgres_exporter docker-compose run --rm nfpm-rpm
	PKG=postgres_exporter docker-compose run --rm nfpm-deb
	PKG=node_exporter docker-compose run --rm nfpm-rpm
	PKG=node_exporter docker-compose run --rm nfpm-deb

prometheus-pkgs:
	PKG=prometheus docker-compose run --rm build
	PKG=prometheus docker-compose run --rm nfpm-rpm
	PKG=prometheus docker-compose run --rm nfpm-deb

prometheus-alertmanager:
	PKG=alertmanager docker-compose run --rm build
	PKG=alertmanager docker-compose run --rm nfpm-rpm
	PKG=alertmanager docker-compose run --rm nfpm-deb

postgres_exporter:
	PKG=postgres_exporter docker-compose run --rm build
	PKG=postgres_exporter docker-compose run --rm nfpm-rpm
	PKG=postgres_exporter docker-compose run --rm nfpm-deb

node_exporter:
	PKG=node_exporter docker-compose run --rm build
	PKG=node_exporter docker-compose run --rm nfpm-rpm
	PKG=node_exporter docker-compose run --rm nfpm-deb

clean:
	rm -rf _build/

# Calyptia Fluentd Daemonset for Kubernetes

## Supported tags and respective `Dockerfile` links

See also GitHub container repository page: https://github.com/calyptia/calyptia-fluentd-kubernetes-daemonset/pkgs/container/calyptia-fluentd-kubernetes-daemonset

### Debian

##### Multi-Arch images
- `Elasticsearch7`
  - `docker pull ghcr.io/calyptia/calyptia-fluentd-kubernetes-daemonset:v1.15.1-debian-elasticsearch7-1.0`
  - `docker pull ghcr.io/calyptia/calyptia-fluentd-kubernetes-daemonset:v1.15-debian-elasticsearch7-1`
  - `docker pull ghcr.io/calyptia/calyptia-fluentd-kubernetes-daemonset:v1-debian-elasticsearch`
- `Elasticsearch8`
  - `docker pull ghcr.io/calyptia/calyptia-fluentd-kubernetes-daemonset:v1.15.1-debian-elasticsearch8-1.0`
  - `docker pull ghcr.io/calyptia/calyptia-fluentd-kubernetes-daemonset:v1.15-debian-elasticsearch8-1`
  - `docker pull ghcr.io/calyptia/calyptia-fluentd-kubernetes-daemonset:v1-debian-elasticsearch8`
- `Opensearch`
  - `docker pull ghcr.io/calyptia/calyptia-fluentd-kubernetes-daemonset:v1.15.1-debian-opensearch-1.0`
  - `docker pull ghcr.io/calyptia/calyptia-fluentd-kubernetes-daemonset:v1.15-debian-opensearch-1`
  - `docker pull ghcr.io/calyptia/calyptia-fluentd-kubernetes-daemonset:v1-debian-opensearch`
- `Forward`
  - `docker pull ghcr.io/calyptia/calyptia-fluentd-kubernetes-daemonset:v1.15.1-debian-forward-1.0`
  - `docker pull ghcr.io/calyptia/calyptia-fluentd-kubernetes-daemonset:v1.15-debian-forward-1`
  - `docker pull ghcr.io/calyptia/calyptia-fluentd-kubernetes-daemonset:v1-debian-forward`
- `Kafka2`
  - `docker pull ghcr.io/calyptia/calyptia-fluentd-kubernetes-daemonset:v1.15.1-debian-kafka2-1.0`
  - `docker pull ghcr.io/calyptia/calyptia-fluentd-kubernetes-daemonset:v1.15-debian-kafka2-1`
  - `docker pull ghcr.io/calyptia/calyptia-fluentd-kubernetes-daemonset:v1-debian-kafka2`

##### x86_64 images
- `Elasticsearch7` [Dockerfile](docker-image/v1.15/debian-elasticsearch7/Dockerfile)
  - `docker pull ghcr.io/calyptia/calyptia-fluentd-kubernetes-daemonset:v1.15.1-debian-elasticsearch7-1.0`
  - `docker pull ghcr.io/calyptia/calyptia-fluentd-kubernetes-daemonset:v1.15-debian-elasticsearch7-1`
  - `docker pull ghcr.io/calyptia/calyptia-fluentd-kubernetes-daemonset:v1-debian-elasticsearch`
- `Elasticsearch8` [Dockerfile](docker-image/v1.15/debian-elasticsearch8/Dockerfile)
  - `docker pull ghcr.io/calyptia/calyptia-fluentd-kubernetes-daemonset:v1.15.1-debian-elasticsearch8-1.0`
  - `docker pull ghcr.io/calyptia/calyptia-fluentd-kubernetes-daemonset:v1.15-debian-elasticsearch8-1`
  - `docker pull ghcr.io/calyptia/calyptia-fluentd-kubernetes-daemonset:v1-debian-elasticsearch8`
- `Opensearch` [Dockerfile](docker-image/v1.15/debian-opensearch/Dockerfile)
  - `docker pull ghcr.io/calyptia/calyptia-fluentd-kubernetes-daemonset:v1.15.1-debian-opensearch-1.0`
  - `docker pull ghcr.io/calyptia/calyptia-fluentd-kubernetes-daemonset:v1.15-debian-opensearch-1`
  - `docker pull ghcr.io/calyptia/calyptia-fluentd-kubernetes-daemonset:v1-debian-opensearch`
- `Forward` [Dockerfile](docker-image/v1.15/debian-forward/Dockerfile)
  - `docker pull ghcr.io/calyptia/calyptia-fluentd-kubernetes-daemonset:v1.15.1-debian-forward-1.0`
  - `docker pull ghcr.io/calyptia/calyptia-fluentd-kubernetes-daemonset:v1.15-debian-forward-1`
  - `docker pull ghcr.io/calyptia/calyptia-fluentd-kubernetes-daemonset:v1-debian-forward`
- `Kafka2` [Dockerfile](docker-image/v1.15/debian-kafka2/Dockerfile)
  - `docker pull ghcr.io/calyptia/calyptia-fluentd-kubernetes-daemonset:v1.15.1-debian-kafka2-1.0`
  - `docker pull ghcr.io/calyptia/calyptia-fluentd-kubernetes-daemonset:v1.15-debian-kafka2-amd64-1`
  - `docker pull ghcr.io/calyptia/calyptia-fluentd-kubernetes-daemonset:v1-debian-kafka2`

##### arm64 images
- `Elasticsearch7` [Dockerfile](docker-image/v1.15/debian-elasticsearch7/Dockerfile)
  - `docker pull ghcr.io/calyptia/calyptia-fluentd-kubernetes-daemonset:v1.15.1-debian-elasticsearch7-1.0`
  - `docker pull ghcr.io/calyptia/calyptia-fluentd-kubernetes-daemonset:v1.15-debian-elasticsearch7-1`
  - `docker pull ghcr.io/calyptia/calyptia-fluentd-kubernetes-daemonset:v1-debian-elasticsearch`
- `Elasticsearch8` [Dockerfile](docker-image/v1.15/debian-elasticsearch8/Dockerfile)
  - `docker pull ghcr.io/calyptia/calyptia-fluentd-kubernetes-daemonset:v1.15.1-debian-elasticsearch8-1.0`
  - `docker pull ghcr.io/calyptia/calyptia-fluentd-kubernetes-daemonset:v1.15-debian-elasticsearch8-1`
  - `docker pull ghcr.io/calyptia/calyptia-fluentd-kubernetes-daemonset:v1-debian-elasticsearch8`
- `Opensearch` [Dockerfile](docker-image/v1.15/debian-opensearch/Dockerfile)
  - `docker pull ghcr.io/calyptia/calyptia-fluentd-kubernetes-daemonset:v1.15.1-debian-opensearch-1.0`
  - `docker pull ghcr.io/calyptia/calyptia-fluentd-kubernetes-daemonset:v1.15-debian-opensearch-1`
  - `docker pull ghcr.io/calyptia/calyptia-fluentd-kubernetes-daemonset:v1-debian-opensearch`
- `Forward` [Dockerfile](docker-image/v1.15/debian-forward/Dockerfile)
  - `docker pull ghcr.io/calyptia/calyptia-fluentd-kubernetes-daemonset:v1.15.1-debian-forward-1.0`
  - `docker pull ghcr.io/calyptia/calyptia-fluentd-kubernetes-daemonset:v1.15-debian-forward-1`
  - `docker pull ghcr.io/calyptia/calyptia-fluentd-kubernetes-daemonset:v1-debian-forward`
- `Kafka2` [Dockerfile](docker-image/v1.15/debian-kafka2/Dockerfile)
  - `docker pull ghcr.io/calyptia/calyptia-fluentd-kubernetes-daemonset:v1.15.1-debian-kafka2-1.0`
  - `docker pull ghcr.io/calyptia/calyptia-fluentd-kubernetes-daemonset:v1.15-debian-kafka2-amd64-1`
  - `docker pull ghcr.io/calyptia/calyptia-fluentd-kubernetes-daemonset:v1-debian-kafka2`

You can also use `v1-debian-PLUGIN` tag to refer latest v1 image, e.g. `v1-debian-elasticsearch`. On production, strict tag is better to avoid unexpected update.

## What is Fluentd?

![Fluentd Logo](http://www.fluentd.org/assets/img/miscellany/fluentd-logo.png)

Fluentd is an open source data collector, which lets you unify the data
collection and consumption for a better use and understanding of data.

> [www.fluentd.org](http://www.fluentd.org/)


## Image versions

Fluentd versioning is as follows:

| Series | Description                         |
|--------|-------------------------------------|
| v1.x   | current stable                      |

## Settings

### Default image version

Default YAML uses latest v1 images like `fluent/fluentd-kubernetes-daemonset:v1-debian-kafka`. If you want to avoid unexpected image update, specify exact version for `image` like `fluent/fluentd-kubernetes-daemonset:v1.14.0-debian-kafka2-1.0`.

### Use your configuration

These images have default configuration and support some environment variables for parameters
but it sometimes doesn't fit your case. If you want to use your configuration, use ConfigMap feature.

Each image has following configurations:

- calyptia.conf: Calyptia Monitoring API setting.
- fluent.conf: Destination setting, Elaticsearch, kafka and etc.
- kubernetes.conf: k8s specific setting. `kubernetes_metadata` filter
  - kubernetes/*.conf: k8s specific setting. `tail` input for log files.
- tail_container_parse.conf: parser setting for `/var/log/containers/*.log`. See also "Use CRI parser for containerd/cri-o" logs section
- prometheus.conf: prometheus plugin for fluentd monitoring
- systemd.conf: systemd plugin for collecting systemd-journal log. See also "Disable systemd input" section.

### Daemonset definitions

This Calyptia flavor Daemonset contains two types of daemonset definitions:

* [minikube](minikube): Daemonset definitions for default minikube installation
* [cri-o](cri-o): Daemonset definitions for containerd/cri-o environment

Ths first one is minikube which is default installation.
Default minikube installation, minikube still uses dockerd as k8s backend. This means that `tail_container_parse.conf` uses `json` parser for parsing container logs.

The other is containerd/cri-o environment that is standard backend for recent kubernetes.
This type of definitions use `cri` parser on `tail_container_parse.conf`.

And top-level symlinked daemonset definition yaml files are cri-o versions.
If you want to use minikube versions, please use daemonset definitions under [minikube](minikube) directory.

### Use CRI parser for containerd/cri-o logs

By default, these images use `json` parser for parsing log files for containers.
On the other hand, you can use `cri` parser for `/var/log/containers/` when you parse containerd/cri-o log format files.
To parse such logs, this daemonset use [`cri` parser](https://github.com/fluent/fluent-plugin-parser-cri).

You can use `cri` parser by overwriting `tail_container_parse.conf` via ConfigMap.

```
# configuration example
<parse>
  @type cri
  time_format '%Y-%m-%dT%H:%M:%S.%L%z'
</parse>
```

See also [CRI parser README](https://github.com/fluent/fluent-plugin-parser-cri#log-and-configuration-example)

### Use FLUENT_CONTAINER_TAIL_EXCLUDE_PATH to exclude specific container logs


You can exclude container logs from `/var/log/containers/` with `FLUENT_CONTAINER_TAIL_EXCLUDE_PATH`.
If you have a trouble with specific log, use this envvar, e.g. `["/var/log/containers/logname-*"]`.

- `exclude_path` parameter document: https://docs.fluentd.org/input/tail#exclude_path
- Fluentd log issue with backslash: https://github.com/fluent/fluentd/issues/2545

### Disable systemd input

If you don't setup systemd in the container, fluentd shows following messages by default configuration.

```
[warn]: #0 [in_systemd_bootkube] Systemd::JournalError: No such file or directory retrying in 1s
[warn]: #0 [in_systemd_kubelet] Systemd::JournalError: No such file or directory retrying in 1s
[warn]: #0 [in_systemd_docker] Systemd::JournalError: No such file or directory retrying in 1s
```

You can suppress these messages by setting `disable` to `FLUENTD_SYSTEMD_CONF` environment variable in your kubernetes configuration.

### Disable prometheus input plugins

By default, latest images launch `prometheus` plugins to monitor fluentd.
You can disable prometheus input plugin by setting `disable` to `FLUENTD_PROMETHEUS_CONF` environment variable in your kubernetes configuration.

### Disable Calyptia monitoring plugin

By default, the latest images launch `calyptia_monitoring` plugin to monitor fluentd via Calyptia Monitoring service.
You can disable calyptia monitoring input plugin by setting `disable` to `FLUENTD_CALYPTIA_CONF` environment variable in your kubernetes configuration.

### Disable AWS OpenSearch credentials injection on OpenSearch plugin

By default, OpenSearch image injects the credentails for AWS OpenSearch Service.
You can disable to include AWS credentials configuration by setting `disable` to `FLUENTD_AWS_OPENSEARTCH_SERVICE_CREDENTAILS_CONF` environment variable in your kubernetes configuration.

## Note

### kafka image doesn't support zookeeper parameters

zookeeper gem doesn't work on Debian 10, so kafka image doesn't include zookeeper gem.

### Windows k8s daemonset not supported in this repository

Maintainers don't have k8s experience on Windows.
Some users create k8s daemonset on Windows:

- https://github.com/bgsilvait/k8s-fluentd-windows
- https://github.com/k1nger/fluentd-windows-daemon

Please check them out.

### References

[Kubernetes Logging with Fluentd][fluentd-article]

## Issues

If you have any problems with or questions about this image, please contact us
through a [GitHub issue](https://github.com/calyptia/calyptia-fluentd-kubernetes-daemonset/issues).

## Pull Request

Update `templates` files instead of `docker-image` files.
`docker-image` files are automatically generated from `templates`.

_Note: This file is generated from [templates/README.md.erb](templates/README.md.erb)_

[alpine-home]: http://alpinelinux.org
[alpine-dockerhub]: https://hub.docker.com/_/alpine
[debian-dockerhub]: https://hub.docker.com/_/debian
[fluentd-article]: https://docs.fluentd.org/container-deployment/kubernetes

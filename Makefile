# This Makefile automates possible operations of this project.
#
# Images and description on Docker Hub will be automatically rebuilt on
# pushes to `master` branch of this repo and on updates of parent images.
#
# Note! Docker Hub `post_push` hook must be always up-to-date with values
# specified in current Makefile. To update it just use:
#	make post-push-hook-all
#
# It's still possible to build, tag and push images manually. Just use:
#	make release-all

IMAGE_NAME := ghcr.io/calyptia/calyptia-fluentd-kubernetes-daemonset
IMAGES :=\
	v1.14/debian-elasticsearch7:v1.14.4-debian-elasticsearch7-1.0,v1.14-debian-elasticsearch7-1,v1-debian-elasticsearch \
	v1.14/debian-opensearch:v1.14.4-debian-opensearch-1.2,v1.14-debian-open-1,v1-debian-opensearch \
	v1.14/debian-forward:v1.14.4-debian-forward-1.0,v1.14-debian-forward-1,v1-debian-forward \
	v1.14/debian-kafka2:v1.14.4-debian-kafka2-1.0,v1.14-debian-kafka2-amd64-1,v1-debian-kafka2 \

#	<Dockerfile>:<version>,<tag1>,<tag2>,...

ALL_IMAGES := $(IMAGES) # We provides buildx sub command built images.

PLATFORMS := linux/amd64,linux/arm64

NEED_AWS_CREDENTIALS_IMAGE := v1.14/debian-opensearch

comma := ,
empty :=
space := $(empty) $(empty)

# Default is first image from ALL_IMAGES list.
DOCKERFILE ?= $(word 1,$(subst :, ,$(word 1,$(ALL_IMAGES))))
TARGET ?= $(word 2,$(subst -, , $(DOCKERFILE)))

# Gets the version value based on the directory the dockerfile is in.
FLUENTD_VERSION ?= $(word 1,$(subst /, ,$(DOCKERFILE)))

# Finds the image tags based on whatever DOCKERFILE is set to, even if the user
# has passed DOCKERFILE explicitly
#
# Gets the <version>,<tag1>,<tag2>,... from <Dockerfile>:<version>,<tag1>,<tag2>,...
TAGS ?= $(word 2,$(subst :, ,$(word 1,$(filter $(DOCKERFILE)%, $(ALL_IMAGES)))))
# Gets the <version> from <Dockerfile>:<version>,<tag1>,<tag2>,...
VERSION ?= $(word 1,$(subst $(comma), ,$(TAGS)))

no-cache ?= no

eq = $(if $(or $(1),$(2)),$(and $(findstring $(1),$(2)),\
                                $(findstring $(2),$(1))),1)

## Docker image management

no-cache-arg = $(if $(call eq, $(no-cache), yes), --no-cache, $(empty))

## Daemonset targets

DAEMONSET_YAMLS := \
	calyptia-fluentd-daemonset-elasticsearch-rbac.yaml \
	calyptia-fluentd-daemonset-elasticsearch.yaml \
	calyptia-fluentd-daemonset-opensearch-rbac.yaml \
	calyptia-fluentd-daemonset-opensearch.yaml \
	calyptia-fluentd-daemonset-forward.yaml

DAEMONSET_TARGETS := \
	minikube \
	cri-o

# Default is first yaml from DAEMONSET_YAMLS list.
DAEMONSET_YAML ?= $(word 1,$(subst :, ,$(word 1,$(DAEMONSET_YAMLS))))

# Render the given erb template.
#
# Usage:
#	make daemonset-yaml-template [DAEMONSET_YAML=] [TARGET=]
daemonset-yaml-template:
	mkdir -p $(TARGET)/$(dir $(DAEMONSET_YAML))
	docker run --rm -i -v $(PWD)/templates/$(DAEMONSET_YAML).erb:/$(basename $(DAEMONSET_YAML)).erb:ro \
	ruby:alpine erb -U -T 1 \
		target='$(TARGET)' \
	/$(basename $(DAEMONSET_YAML)).erb > $(TARGET)/$(DAEMONSET_YAML)

daemonset:
	(set -e ; $(foreach target,$(DAEMONSET_TARGETS), \
		make daemonset-yaml-template TARGET=$(target) DAEMONSET_YAML=$(DAEMONSET_YAML); \
	))

daemonset-all:
	(set -e ; $(foreach daemonset_yaml,$(DAEMONSET_YAMLS), \
		make daemonset DAEMONSET_YAML=$(daemonset_yaml); \
	))

# Build Docker image.
#
# Usage:
#	make image [no-cache=(yes|no)] [DOCKERFILE=] [VERSION=]
image:
	docker build $(no-cache-arg) -t $(IMAGE_NAME):$(VERSION) docker-image/$(DOCKERFILE)

multiarch-image:
	docker buildx build $(no-cache-arg) -t $(IMAGE_NAME):$(VERSION) docker-image/$(DOCKERFILE) --build-arg VERSION=$(VERSION) --platform=$(PLATFORMS)

# Build all supported Docker images.
#
# Usage:
#	make release-all [no-cache=(yes|no)]
image-all:
	(set -e ; $(foreach img,$(ALL_IMAGES), \
		make image no-cache=$(no-cache) \
			DOCKERFILE=$(word 1,$(subst :, ,$(img))) \
			VERSION=$(word 1,$(subst $(comma), ,\
			                 $(word 2,$(subst :, ,$(img))))) \
			TAGS=$(word 2,$(subst :, ,$(img))) ; \
	))


parsed-tags = $(subst $(comma), $(space), $(TAGS))

# Tag Docker image with given tags.
#
# Usage:
#	make tags [VERSION=] [TAGS=t1,t2,...]
tags:
	(set -e ; $(foreach tag, $(parsed-tags), \
		docker tag $(IMAGE_NAME):$(VERSION) $(IMAGE_NAME):$(tag) ; \
	))

multiarch-tags:
	(set -e ;  $(foreach tag, $(parsed-tags), \
		docker buildx build -t $(IMAGE_NAME):$(tag) docker-image/$(DOCKERFILE) --build-arg VERSION=$(VERSION) --platform=$(PLATFORMS) ; \
	))

# Make manual release of all supported Docker images to GitHub Container registry.
#
# Usage:
#	make release-all [no-cache=(yes|no)]
tags-all:
	(set -e ; $(foreach img,$(ALL_IMAGES), \
		make tags no-cache=$(no-cache) \
			DOCKERFILE=$(word 1,$(subst :, ,$(img))) \
			VERSION=$(word 1,$(subst $(comma), ,\
			                 $(word 2,$(subst :, ,$(img))))) \
			TAGS=$(word 2,$(subst :, ,$(img))) ; \
	))

# Manually push Docker images to GitHub Container registry.
#
# Usage:
#	make push [TAGS=t1,t2,...]
push:
	(set -e ; $(foreach tag, $(parsed-tags), \
		docker push $(IMAGE_NAME):$(tag) ; \
	))

multiarch-push:
	(set -e ;  $(foreach tag, $(parsed-tags), \
		docker buildx build -t $(IMAGE_NAME):$(tag) docker-image/$(DOCKERFILE) --build-arg VERSION=$(VERSION) --platform=$(PLATFORMS) --push ; \
	))

# Make manual release of Docker images to GitHub Container registry.
#
# Usage:
#	make release [no-cache=(yes|no)] [DOCKERFILE=] [VERSION=] [TAGS=t1,t2,...]
release: | image tags push

# Make manual release of all supported Docker images to GitHub Container registry.
#
# Usage:
#	make release-all [no-cache=(yes|no)]
release-all:
	(set -e ; $(foreach img,$(ALL_IMAGES), \
		make release no-cache=$(no-cache) \
			DOCKERFILE=$(word 1,$(subst :, ,$(img))) \
			VERSION=$(word 1,$(subst $(comma), ,\
			                 $(word 2,$(subst :, ,$(img))))) \
			TAGS=$(word 2,$(subst :, ,$(img))) ; \
	))


## Template processing

# Generate Docker image sources.
#
# Usage:
#	make src [DOCKERFILE=] [VERSION=] [TAGS=t1,t2,...]
src: dockerfile gemfile fluent.conf calyptia.conf systemd.conf prometheus.conf kubernetes.conf plugins entrypoint.sh cluster-autoscaler.conf containers.conf docker.conf etcd.conf glbc.conf kube-apiserver-audit.conf kube-apiserver.conf kube-controller-manager.conf kube-proxy.conf kube-scheduler.conf kubelet.conf rescheduler.conf salt.conf startupscript.conf tail_container_parse.conf aws_credentials.conf

# Generate sources for all supported Docker images.
#
# Usage:
#	make src-all
src-all: README.md
	(set -e ; $(foreach img,$(ALL_IMAGES), \
		make src \
			DOCKERFILE=$(word 1,$(subst :, ,$(img))) \
			VERSION=$(word 1,$(subst $(comma), ,\
			                 $(word 2,$(subst :, ,$(img))))) \
			TAGS=$(word 2,$(subst :, ,$(img))) ; \
	))

# Render the given erb template.
#
# Usage:
#	make container-image-template [FILE=] [DOCKERFILE=] [VERSION=]
container-image-template:
	mkdir -p docker-image/$(DOCKERFILE)/$(dir $(FILE))
	docker run --rm -i -v $(PWD)/templates/$(FILE).erb:/$(basename $(FILE)).erb:ro \
		ruby:alpine erb -U -T 1 \
			dockerfile='$(DOCKERFILE)' \
			version='$(VERSION)' \
		/$(basename $(FILE)).erb > docker-image/$(DOCKERFILE)/$(FILE)

# Execute the given TARGET for each images
#
# Usage:
#	make each-image TARGET=
each-image:
	(set -e ; $(foreach img,$(ALL_IMAGES), \
		make $(TARGET) \
			DOCKERFILE=$(word 1,$(subst :, ,$(img))) \
			VERSION=$(word 1,$(subst $(comma), ,\
			                 $(word 2,$(subst :, ,$(img))))) ; \
	))


# Generate Dockerfile from template.
#
# Usage:
#	make dockerfile [DOCKERFILE=] [VERSION=]
dockerfile:
	make container-image-template FILE=Dockerfile
	cp $(PWD)/templates/.dockerignore docker-image/$(DOCKERFILE)/.dockerignore
dockerfile-all:
	make each-image TARGET=dockerfile

# Generate Gemfile and Gemfile.lock from template.
#
# Usage:
#	make gemfile [DOCKERFILE=] [VERSION=]
gemfile:
	make container-image-template FILE=Gemfile
	docker run --rm -i -v $(PWD)/docker-image/$(DOCKERFILE)/Gemfile:/Gemfile:ro \
		ruby:alpine sh -c "apk add --no-cache --quiet git && bundle lock --print --remove-platform x86_64-linux-musl --add-platform ruby" > docker-image/${DOCKERFILE}/Gemfile.lock

# Generate Gemfile and Gemfile.lock from template for all supported Docker images.
#
# Usage:
#	make gemfile-all
gemfile-all:
	make each-image TARGET=gemfile

# Generate entrypoint.sh from template.
#
# Usage:
#	make entrypoint.sh [DOCKERFILE=] [VERSION=]
entrypoint.sh:
	make container-image-template FILE=entrypoint.sh
	chmod 755 docker-image/$(DOCKERFILE)/entrypoint.sh

# Generate entrypoint.sh from template for all supported Docker images.
#
# Usage:
#	make entrypoint.sh-all
entrypoint.sh-all:
	make each-image TARGET=entrypoint.sh

# Generate fluent.conf from template.
#
# Usage:
#	make fluent.conf [DOCKERFILE=] [VERSION=]
fluent.conf:
	make container-image-template FILE=conf/fluent.conf
fluent.conf-all:
	make each-image TARGET=fluent.conf

# Generate calyptia.conf from template.
#
# Usage:
#	make calyptia.conf [DOCKERFILE=] [VERSION=]
calyptia.conf:
	make container-image-template FILE=conf/calyptia.conf
calyptia.conf-all:
	make each-image TARGET=calyptia.conf


# Generate kubernetes.conf from template.
#
# Usage:
#	make kubernetes.conf [DOCKERFILE=] [VERSION=]
kubernetes.conf:
	make container-image-template FILE=conf/kubernetes.conf
kubernetes.conf-all:
	make each-image TARGET=kubernetes.conf

cluster-autoscaler.conf:
	make container-image-template FILE=conf/kubernetes/cluster-autoscaler.conf
cluster-autoscaler.conf-all:
	make each-image TARGET=cluster-autoscaler.conf

containers.conf:
	make container-image-template FILE=conf/kubernetes/containers.conf
containers.conf-all:
	make each-image TARGET=containers.conf

docker.conf:
	make container-image-template FILE=conf/kubernetes/docker.conf
docker.conf-all:
	make each-image TARGET=docker.conf

etcd.conf:
	make container-image-template FILE=conf/kubernetes/etcd.conf
etcd.conf-all:
	make each-image TARGET=etcd.conf

glbc.conf:
	make container-image-template FILE=conf/kubernetes/glbc.conf
glbc.conf-all:
	make each-image TARGET=glbc.conf

kube-apiserver-audit.conf:
	make container-image-template FILE=conf/kubernetes/kube-apiserver-audit.conf
kube-apiserver-audit.conf-all:
	make each-image TARGET=kube-apiserver-audit.conf

kube-apiserver.conf:
	make container-image-template FILE=conf/kubernetes/kube-apiserver.conf
kube-apiserver.conf-all:
	make each-image TARGET=kube-apiserver.conf

kube-controller-manager.conf:
	make container-image-template FILE=conf/kubernetes/kube-controller-manager.conf
kube-controller-manager.conf-all:
	make each-image TARGET=kube-controller-manager.conf

kubelet.conf:
	make container-image-template FILE=conf/kubernetes/kubelet.conf
kubelet.conf-all:
	make each-image TARGET=kubelet.conf

kube-proxy.conf:
	make container-image-template FILE=conf/kubernetes/kube-proxy.conf
kube-proxy.conf-all:
	make each-image TARGET=kube-proxy.conf

kube-scheduler.conf:
	make container-image-template FILE=conf/kubernetes/kube-scheduler.conf
kube-scheduler.conf-all:
	make each-image TARGET=kube-scheduler.conf

rescheduler.conf:
	make container-image-template FILE=conf/kubernetes/rescheduler.conf
rescheduler.conf-all:
	make each-image TARGET=rescheduler.conf

salt.conf:
	make container-image-template FILE=conf/kubernetes/salt.conf
salt.conf-all:
	make each-image TARGET=salt.conf

startupscript.conf:
	make container-image-template FILE=conf/kubernetes/startupscript.conf
startupscript.conf-all:
	make each-image TARGET=startupscript.conf



systemd.conf:
	make container-image-template FILE=conf/systemd.conf
systemd.conf-all:
	make each-image TARGET=systemd.conf

tail_container_parse.conf:
	make container-image-template FILE=conf/tail_container_parse.conf
tail_container_parse.conf-all:
	make each-image TARGET=tail_container_parse.conf

aws_credentials.conf:
ifeq "$(DOCKERFILE)" "$(NEED_AWS_CREDENTIALS_IMAGE)"
	make container-image-template FILE=conf/aws_credentials.conf
else
	@echo "Skip generating aws_credentials.conf for ${DOCKERFILE}"
endif

aws_credentials.conf-all:
	make each-image TARGET=aws_credentials.conf

prometheus.conf:
	make container-image-template FILE=conf/prometheus.conf
prometheus.conf-all:
	make each-image TARGET=prometheus.conf


README.md: templates/README.md.erb
	docker run --rm -i -v $(PWD)/templates/README.md.erb:/README.md.erb:ro \
		ruby:alpine erb -U -T 1 \
	                all_images='$(ALL_IMAGES)' \
		/README.md.erb > README.md

.github/dependabot.yml: templates/dependabot.yml.erb
	erb $< > $@

# Generate plugins for version
#
# Usage:
#    make plugins [DOCKERFILE=]
plugins:
	mkdir -p docker-image/$(DOCKERFILE)/plugins
	cp -R plugins/$(FLUENTD_VERSION)/shared/. docker-image/$(DOCKERFILE)/plugins/
	cp -R plugins/$(FLUENTD_VERSION)/$(TARGET)/. docker-image/$(DOCKERFILE)/plugins/

# copy plugins required for all supported Docker images.
#
# Usage:
#	make plugins-all
plugins-all:
	(set -e ; $(foreach img,$(ALL_IMAGES), \
		make plugins \
			DOCKERFILE=$(word 1,$(subst :, ,$(img))) ; \
	))


.PHONY: image tags push \
        release release-all \
        src src-all \
        container-image-template each-image \
        dockerfile dockerfile-all \
        gemfile gemfile-all \
        entrypoint.sh entrypoint.sh-all \
        fluent.conf fluent.conf-all \
        calyptia.conf calyptia.conf-all \
        kubernetes.conf kubernetes.conf-all\
        cluster-autoscaler.conf cluster-autoscaler.conf-all \
        containers.conf containers.conf-all \
        docker.conf docker.conf-all \
        etcd.conf etcd.conf-all \
        glbc.conf glbc.conf-all \
        kube-apiserver-audit.conf kube-apiserver-audit.conf-all \
        kube-apiserver.conf kube-apiserver.conf-all \
        kube-controller-manager.conf kube-controller-manager.conf-all \
        kubelet.conf kubelet.conf-all \
        kube-proxy.conf kube-proxy.conf-all \
        kube-scheduler.conf kube-scheduler.conf-all \
        rescheduler.conf rescheduler.conf-all \
        salt.conf salt.conf-all \
        startupscript.conf startupscript.conf-all \
        systemd.conf systemd.conf-all \
        tail_container_parse.conf tail_container_parse.conf-all \
        prometheus.conf prometheus.conf-all \
        plugins plugins-all \
        README.md

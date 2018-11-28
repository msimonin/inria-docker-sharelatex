# UNUSED: The namespace to use, we should condider switching to gitlab
NAMESPACE=registry.gitlab.inria.fr/sed-rennes/sharelatex/inria-docker-sharelatex
FLAGS=--no-cache --network host
FLAGS=--network host
TAG=inria-1.2.1

TARGETS=web
RELEASES=base-r web-r clsi_worker-r

all: $(TARGETS)

release: $(RELEASES)

.PHONY: $(TARGETS) base clsi_worker

base:
	cd $@ && docker build $(FLAGS) -t $(NAMESPACE)/$@:$(TAG) .

clsi_worker:
	cd $@ && docker build $(FLAGS) -t $(NAMESPACE)/$@:$(TAG) .

$(TARGETS): base
	cd $@ && docker build $(FLAGS) -t $(NAMESPACE)/$@:$(TAG) .

$(RELEASES):
	docker push $(NAMESPACE)/${@:-r=}:$(TAG)




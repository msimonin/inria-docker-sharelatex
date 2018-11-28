# UNUSED: The namespace to use, we should condider switching to gitlab
NAMESPACE=registry.gitlab.inria.fr/sed-rennes/sharelatex/inria-docker-sharelatex
FLAGS=--no-cache --network host
FLAGS=--network host
TAG=inria-1.2.1

TARGETS=web real-time document-updater clsi track-changes filestore docstore chat tags spelling contacts notifications
RELEASES=base-r web-r clsi_worker-r real-time-r document-updater-r clsi-r track-changes-r filestore-r docstore-r chat-r tags-r spelling-r contacts-r notifications-r


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




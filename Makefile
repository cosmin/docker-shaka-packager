.PHONY: all
all: docker

.PHONY: docker
stable:
	$(eval VERSION=stable)
	docker build -t shaka-packager:$(VERSION) .
experimental:
	$(eval VERSION=experimental)
	docker build --build-arg shaka_packager_version=master -t shaka-packager:$(VERSION) .

.PHONY: push
push: docker
	docker tag shaka-packager:$(VERSION) offbytwo/shaka-packager:$(VERSION)
	docker push offbytwo/shaka-packager:$(VERSION)

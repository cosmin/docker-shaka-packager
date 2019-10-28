.PHONY: all
all: docker

.PHONY: docker
docker:
	docker build -t shaka-packager:latest .

.PHONY: push
push: docker
	docker tag shaka-packager:latest offbytwo/shaka-packager:latest
	docker push offbytwo/shaka-packager:latest

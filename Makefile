-include .env
export

VERSION := $(shell cat VERSION)
# PUBLISHED is a file that contains the docker image to publish to. If it doesn't exist, use the default DOCKER_IMAGE which is an enviorment variable in CI
PUBLISHEDIMAGE := $(shell if [ -f PUBLISHED ]; then cat PUBLISHED; else echo $(DOCKER_IMAGE); fi)

prepare:
	mkdir -p content


# first build-base should have been run
build:
	docker build -f Dockerfile.build --build-arg "VERSION=${VERSION}" -t informatievlaanderen/standaardenregister-run:${VERSION} .

# first build-base should have been run
# Build latest to always contain the most recent information of all the standards inside the /content folder
build-latest:
	docker build -f Dockerfile.build --build-arg "VERSION=${VERSION}" -t informatievlaanderen/standaardenregister-run:latest .


publish:
	docker tag informatievlaanderen/standaardenregister-run:${VERSION} ${PUBLISHEDIMAGE}:${VERSION}
	docker push ${PUBLISHEDIMAGE}:${VERSION}

publish-latest:
	docker tag informatievlaanderen/standaardenregister-run:latest ${PUBLISHEDIMAGE}:latest
	docker push ${PUBLISHEDIMAGE}:latest

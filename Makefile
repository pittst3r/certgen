image_name = pittst3r/certgen
version = $(shell cat VERSION)

build:
	docker build --tag certgen .

check-dirty:
	test -z "`git status --porcelain`"

check-version:
	test -z "$(shell docker images --filter reference=${image_name}:${version} | grep ${image_name})"

build-release: check-dirty check-version
	docker build --tag ${image_name}:${version} .
	docker tag ${image_name}:${version} ${image_name}:latest

tag-release:
	git tag v${version} HEAD

docker-hub-login:
	docker login

publish: build-release tag-release docker-hub-login
	docker push ${image_name}

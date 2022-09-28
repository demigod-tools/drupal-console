PROJECT_PATH ?= $(shell realpath .)
PROJECT_ORG  ?= $(shell cat composer.json | jq -r '.name | split("/") | .[0]')
PROJECT_NAME ?= $(shell cat composer.json | jq -r '.name | split("/") | .[1]')
REPO_NAME    ?= ${PROJECT_ORG}/${PROJECT_NAME}
VCS_REF      ?= $(shell git rev-parse --short HEAD)
DATE_TAG     ?= $(shell TZ=UTC date +%Y-%m-%d_%H.%M)
VERSION      ?= $(shell cat .version)
PHP_VERSION  ?= 8.1


deps:
	## Todo:
	## Install Phar-composer bumpversion github-cli jq
	## Login via github CLI
	## ${PROJECT_PATH}
	## ${PROJECT_ORG}
	## ${PROJECT_NAME}
	## ${REPO_NAME}

clean:
	rm -Rf drupal-console.phar
	rm -Rf drupal

build: clean
	phar-composer build .
	mv drupal-console.phar drupal
	chmod +x ./drupal

version-bump:  ##  Increase the version number by one
	bumpversion minor
	git push origin master --tags

release:
	gh release create "${VERSION}" --generate-notes

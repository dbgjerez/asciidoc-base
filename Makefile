#!make
-include .env
HUB ?= b0rr3g0
IMAGE ?= service-mesh-wasm-go
VERSION ?= 0.1-SNAPSHOT
OUTPUT_FOLDER=output
CONTAINER ?= container/Dockerfile

MAIN_NAME?=index.adoc

BUILDER_NAME ?= tmp/asciidoctor-builder
.DEFAULT_GOAL := help

.PHONY: help 
help: ## Show options and short description
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

build-html: ## Build the documentation as html
	@asciidoctor content/index.adoc -o index.html

build-pdf: ## Build the documentation as pdf
	@asciidoctor-pdf content/index.adoc -o doc.pdf

.PHONY: clean
clean: ## Clean all tmp files, docker image and output files
	@rm -rf ${OUTPUT_FOLDER}
	@docker images | grep ${BUILDER_NAME} | awk '{printf "%s:%s", $$1, $$2}' | xargs -r docker rmi -f

.PHONY: image-builder
image-builder: ## Build a secure image with nonroot user to build an image
	@docker build -t ${BUILDER_NAME}:latest --build-arg USER_UID=$$UID -f build/Dockerfile.builder build

.PHONY: image-build
image-build: clean image-builder ## Build an imagen with html documentation
	@mkdir output
	@docker run -it \
        -v $(shell pwd):/documents \
        ${BUILDER_NAME}:latest  \
        asciidoctor content/${MAIN_NAME} \
		-a allow-uri-read \
		-D ${OUTPUT_FOLDER}
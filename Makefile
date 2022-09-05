#!make
-include .env
HUB ?= b0rr3g0
IMAGE ?= service-mesh-wasm-go
VERSION ?= 0.1-SNAPSHOT
CONTAINER ?= container/Dockerfile

MAIN_NAME?=index.adoc

.DEFAULT_GOAL := help

.PHONY: help 
help: ## Show options and short description
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

build-html: ## Build the documentation as html
	@podman run -it -v ./content:/documents/ docker.io/asciidoctor/docker-asciidoctor asciidoctor index.adoc

build-pdf: ## Build the documentation as pdf
	@podman run -it -v ./content:/documents/ docker.io/asciidoctor/docker-asciidoctor asciidoctor-pdf index.adoc

.PHONY: build-image
build-image: clbuild-html ## Build an imagen with html documentation
	@podman run -it \
        -v $(shell pwd):/documents \
        ${BUILDER_NAME}:latest  \
        asciidoctor content/${MAIN_NAME} \
		-a allow-uri-read \
		-D ${OUTPUT_FOLDER}
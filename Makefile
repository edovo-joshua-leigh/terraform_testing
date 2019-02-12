.DEFAULT_GOAL := help
PYTHON := $(shell which python2.7)
ENV := $(CURDIR)/env
PIP := $(ENV)/bin/pip
DOCKER := $(shell which docker)
TERRAFORM:= $(DOCKER) run -it --rm \
-v ~/.aws:/root/.aws \
-v $(CURDIR):/data \
-w /data/$(DIR) \
hashicorp/terraform

help:
	@printf "\033[0;31mWelcome the Terraform repo! Build 'n Destroy\n"
	@printf "!! Terraform can break all the things, take care !!\n\033[0m\n"
	@grep -E '^[0-9a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'
	@echo

ensure-%: # forces variables to be set
	@if [ -z '${${*}}' ]; then echo 'Environment variable $* not set' && exit 1; fi

deps: ## pulls in the stuff needed to run standard terraform
	$(DOCKER) pull hashicorp/terraform:latest

clean: ## clears out the python environment in repo
	rm -rf $(ENV)

terraform_help: ensure-DIR ## return the terraform help prompt
	$(TERRAFORM) help

init: ensure-DIR #required for initialization
	$(TERRAFORM) init

plan: ensure-DIR init ## run a terraform plan from the DIR
	$(TERRAFORM) plan

apply: ensure-DIR init ## run a terraform plan from the DIR
	$(TERRAFORM) apply

destroy: ensure-DIR init ## run a terraform plan from the DIR
	$(TERRAFORM) destroy

container_troubleshoot:
	$(DOCKER) run -it --rm \
	--entrypoint /bin/sh \
	-v ~/.aws:/root/.aws \
	-v $(CURDIR):/data \
	-w /data/$(DIR) \
	hashicorp/terraform

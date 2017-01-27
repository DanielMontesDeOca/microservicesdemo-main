CURRENT_DIRECTORY=$(shell pwd)

DOCKER_BASE_COMPOSE=-f $(CURRENT_DIRECTORY)/docker-compose.yml
DOCKER_DEV_COMPOSE=$(DOCKER_BASE_COMPOSE) -f $(CURRENT_DIRECTORY)/docker-compose.dev.yml
DOCKER_E2E_COMPOSE=$(DOCKER_BASE_COMPOSE) -f $(CURRENT_DIRECTORY)/docker-compose.e2e.yml

# Build services or build single service with service=name
docker-build:
	@docker-compose $(DOCKER_BASE_COMPOSE) build $(service)

# Ssh into service container
docker-bash:
	@docker-compose $(DOCKER_BASE_COMPOSE) exec $(service) /bin/bash

# Test current build of a service
docker-test:
	@docker-compose $(DOCKER_BASE_COMPOSE) -f $(CURRENT_DIRECTORY)/$(service)/docker-compose.test.yml build $(service)
	@docker-compose $(DOCKER_BASE_COMPOSE) -f $(CURRENT_DIRECTORY)/$(service)/docker-compose.test.yml up $(service)
	@docker-compose $(DOCKER_BASE_COMPOSE) down

# Destroy test environment
docker-test-down:
	@docker-compose $(DOCKER_BASE_COMPOSE) down

# Run e2e tests
docker-e2e-test:
	@docker-compose $(DOCKER_E2E_COMPOSE) build e2e-tests
	@docker-compose $(DOCKER_E2E_COMPOSE) up e2e-tests
	@docker-compose $(DOCKER_E2E_COMPOSE) down

# Destroy e2e environment
docker-e2e-down:
	@docker-compose $(DOCKER_E2E_COMPOSE) down

# Lift dev environment or single service with service=name
docker-dev:
	@docker-compose $(DOCKER_DEV_COMPOSE) up $(service)

# Destroy dev environment
docker-dev-down:
	@docker-compose $(DOCKER_DEV_COMPOSE) down

update-services:
	git submodule update --recursive

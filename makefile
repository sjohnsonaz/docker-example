default: up

.PHONY: up
up:
	docker-compose up -d

.PHONY: up-dev
up-dev:
	docker-compose -f docker-compose.dev.yml up

.PHONY: down
down:
	docker-compose down

.PHONY: clean
clean:
	docker-compose down --rmi all

.PHONY: build
build:
	docker-compose build

.PHONY: build-dev
build-dev:
	docker-compose -f docker-compose.dev.yml build

.PHONY: stop
stop:
	docker-compose stop

.PHONY: start
start:
	docker-compose start

install: install-client install-server

.PHONY: install-client
install-client:
	cd client && npm install

.PHONY: install-server
install-server:
	cd server && npm install

docs: docs-up

.PHONY: docs-up
docs-up:
	cd docs && docker-compose up

.PHONY: docs-down
docs-down:
	cd docs && docker-compose down

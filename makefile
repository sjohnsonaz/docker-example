default: up

.PHONY: up
up:
	docker-compose up -d

.PHONY: down
down:
	docker-compose down

.PHONY: clean
clean:
	docker-compose down --rmi all

.PHONY: build
build:
	docker-compose build

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
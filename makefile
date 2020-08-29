default: up
up:
	docker-compose up -d
down:
	docker-compose down
clean:
	docker-compose down --rmi all
build:
	docker-compose build
stop:
	docker-compose stop
start:
	docker-compose start
install: install-client install-server
install-client:
	cd client && npm install
install-server:
	cd server && npm install
PROJECT = docker-example
NAMESPACE = docker-example
INGRESS_VERSION = 0.35.0
CERT_MANAGER_VERSION = 1.0.1

default: up

#------------------------
# Docker Compose Commands
#------------------------

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


#-----------------------
# Local Install Commands
#-----------------------

install: install-client install-server

.PHONY: install-client
install-client:
	cd client && npm install

.PHONY: install-server
install-server:
	cd server && npm install


#--------------
# Docs Commands
#--------------

docs: docs-up

.PHONY: docs-up
docs-up:
	cd docs && docker-compose up

.PHONY: docs-down
docs-down:
	cd docs && docker-compose down


#----------------------------
# Dev Docker Compose Commands
#----------------------------

.PHONY: dev-up
dev-up: 
	docker-compose\
		-f docker-compose.yml\
		-f docker-compose.dev.yml\
		up

.PHONY: dev-build
dev-build:
	docker-compose\
		-f docker-compose.yml\
		-f docker-compose.dev.yml\
		build


#-------------
# Dev Commands
#-------------

dev-run: dev-build dev-install

dev-install: dev-client-install dev-server-install

.PHONY: dev-client-install
dev-client-install:
	docker run\
		-v $(PROJECT)_client_node_modules:/client/node_modules\
		$(PROJECT)_client\
		npm install

.PHONY: dev-server-install
dev-server-install:
	docker run\
		-v $(PROJECT)_server_node_modules:/server/node_modules\
		$(PROJECT)_server\
		npm install

.PHONY: dev-network-build
dev-network-build:
	docker network create\
		-d bridge\
		$(PROJECT)_network

.PHONY: dev-build
dev-build: dev-ingress-build dev-client-build dev-server-build

.PHONY: dev-ingress-build
dev-ingress-build:
	docker build\
		-t sjohnsonaz.azurecr.io/$(PROJECT)/ingress\
		-f ./ingress/Dockerfile\
		./ingress

.PHONY: dev-client-build
dev-client-build:
	docker build\
		-t sjohnsonaz.azurecr.io/$(PROJECT)/client\
		-f ./client/Dockerfile\
		./client
	docker volume create\
		$(PROJECT)_client_node_modules

.PHONY: dev-server-build
dev-server-build:
	docker build\
		-t sjohnsonaz.azurecr.io/$(PROJECT)/server\
		-f ./server/Dockerfile\
		./server
	docker volume create\
		$(PROJECT)_server_node_modules

.PHONY: dev-client-run
dev-client-run:
	docker run\
		-v $(PROJECT)_client_node_modules:/client/node_modules\
		-p 8080:8080\
		--network=$(PROJECT)_network\
		--name=$(PROJECT)_client\
		$(PROJECT)_client

.PHONY: dev-server-run
dev-server-run:
	docker run\
		-v $(PROJECT)_server_node_modules:/server/node_modules\
		-p 9229:9229\
		--network=$(PROJECT)_network\
		--name=$(PROJECT)_server\
		$(PROJECT)_server


#--------------------
# Kubernetes Commands
#--------------------

.PHONY: ingress-cloud-install
ingress-cloud-install:
	kubectl apply \
		-f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v$(INGRESS_VERSION)/deploy/static/provider/cloud/deploy.yaml

.PHONY: ingress-cloud-delete
ingress-cloud-delete:
	kubectl delete \
		-f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v$(INGRESS_VERSION)/deploy/static/provider/cloud/deploy.yaml

.PHONY: ingress-install
ingress-install:
	kubectl apply \
		-f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v$(INGRESS_VERSION)/deploy/static/provider/do/deploy.yaml

.PHONY: ingress-delete
ingress-delete:
	kubectl delete \
		-f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v$(INGRESS_VERSION)/deploy/static/provider/do/deploy.yaml

.PHONY: ingress-info-pods
ingress-info-pods:
	kubectl get pods \
		-n ingress-nginx \
		-l app.kubernetes.io/name=ingress-nginx \
		--watch

.PHONY: ingress-info-svc
ingress-info-svc:
	kubectl get svc \
		-n ingress-nginx \
		--watch

.PHONY: cert-manager-install
cert-manager-install:
	kubectl apply \
		--validate=false \
		-f https://github.com/jetstack/cert-manager/releases/download/v$(CERT_MANAGER_VERSION)/cert-manager.yaml

.PHONY: cert-manager-delete
cert-manager-delete:
	kubectl delete \
		-f https://github.com/jetstack/cert-manager/releases/download/v$(CERT_MANAGER_VERSION)/cert-manager.yaml

.PHONY: namespace
namespace:
	kubectl apply\
		-f ./namespaces/

.PHONY: apply
apply:
	kubectl apply\
		-f ./manifests/\
		--namespace=$(NAMESPACE)

.PHONY: kube-delete
kube-delete:
	kubectl delete\
		-f ./manifests/\
		--namespace=$(NAMESPACE)

.PHONY: kube-local
kube-local: dev-build apply

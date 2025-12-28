CLUSTER_NAME=devops-lab
NAMESPACE=devops-demo
IMAGE_LOCAL=fastapi-devops:local

.PHONY: kind-up kind-down build load deploy status test

kind-up:
	kind create cluster --name $(CLUSTER_NAME) --config kind-config.yaml

kind-down:
	kind delete cluster --name $(CLUSTER_NAME)

build:
	docker build -t $(IMAGE_LOCAL) .

load:
	kind load docker-image $(IMAGE_LOCAL) --name $(CLUSTER_NAME)

deploy:
	kubectl apply -f k8s/

status:
	kubectl -n $(NAMESPACE) get pods
	kubectl -n $(NAMESPACE) get svc fastapi-svc

test:
	curl -sS http://localhost:8080/health
	curl -sS http://localhost:8080/


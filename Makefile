.PHONY: test clean

all: build
	docker-compose -d up

build:
	make build -C hadoop
	make build -C presto
	make build -C consumer
	docker-compose build

run:
	docker-compose up -d
	@echo "Startup completed, go to http://localhost:8080"

presto-cli:
	presto/presto-cli.jar --server http://localhost:8080

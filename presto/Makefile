.PHONY: test clean

all: build
	docker-compose up -d
	@echo "Starting cluster, give it some time and check out localhost:8080 or localhost:50070"

build:
	docker build -t sbaldrich/presto-base:latest presto-base
	docker build -t sbaldrich/presto-coordinator:latest presto-coordinator
	docker build -t sbaldrich/presto-worker:latest presto-worker

logs:
	docker-compose logs

run:
	docker-compose up -d
	@echo "Please check http://localhost:8080"

restart:
	docker-compose restart

down:
	docker-compose down

cleanup: down
	docker rm $(docker ps -aq)
	make -C consumer clean

cli:
	./presto-cli.jar --server localhost:8080 --catalog postgresql --schema public

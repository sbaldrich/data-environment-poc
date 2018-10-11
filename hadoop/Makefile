.PHONY: test clean

all: build
	docker-compose up

build:
	 docker build -t sbaldrich/hadoop-base:latest hadoop-base
	 docker build -t sbaldrich/hadoop-namenode:latest hadoop-namenode
	 docker build -t sbaldrich/hadoop-datanode:latest hadoop-datanode

up:
	docker-compose up

down:
	docker-compose down

clean:
	docker rm `docker ps -aq`

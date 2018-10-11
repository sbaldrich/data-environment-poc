.PHONY: test clean

all: build

build:
	./gradlew distZip
	cp build/distributions/consumer.zip .
	docker build -t sbaldrich/presto-consumer-example:latest .
	rm consumer.zip

clean:
	./gradlew clean
	rm -f ./consumer.zip

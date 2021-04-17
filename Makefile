all: build

build:
	docker build -t sparanoid/live-dl:latest .

run:
	docker run --rm --name live-dl sparanoid/live-dl:latest

push:
	docker push sparanoid/live-dl:latest

stop:
	docker rm -f live-dl

clean:
	docker rmi sparanoid/live-dl:latest

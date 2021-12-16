all: build

build:
	docker build -t sparanoid/live-dl:local .

buildx:
	docker buildx bake -f docker-bake.hcl

run:
	docker run --rm -it --name live-dl sparanoid/live-dl:local

up:
	docker-compose down --volumes --remove-orphans && docker-compose up --build

push:
	docker push sparanoid/live-dl:latest

stop:
	docker rm -f live-dl

clean:
	docker rmi sparanoid/live-dl:latest

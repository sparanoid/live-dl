all: build

build:
	docker build -t sparanoid/live-dl:latest .

run:
	docker run --rm -it --name live-dl sparanoid/live-dl:latest

up:
	docker-compose down --volumes --remove-orphans && docker-compose up --build

push:
	docker push sparanoid/live-dl:latest

stop:
	docker rm -f live-dl

clean:
	docker rmi sparanoid/live-dl:latest

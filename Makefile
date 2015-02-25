


all: installdb

installdocker:
	sudo apt-get install docker.io

installdb:
	docker build -t test .
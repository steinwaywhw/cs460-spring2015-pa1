


all: 

docker:
	docker build -t test .

cloud9:
	sudo chmod +x setup.sh
	sudo ./setup.sh

cloud9test:
	cd ./scripts && \
	sudo su postgres -c ./init.sh && \
	sudo su postgres -c ./query.sh
	


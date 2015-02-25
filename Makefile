


all: 

docker:
	docker build -t test .

cloud9:
	sudo chmod +x setup.sh
	sudo ./setup.sh
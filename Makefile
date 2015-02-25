


all: 

docker:
	docker build -t test .

cloud9:
	sudo chmod +x setup.sh
	sudo ./setup.sh

cloud9test:
	sudo rm -rf /var/lib/postgresql/* ./output
	mkdir -p output
	
	cd ./scripts && \
	sudo su postgres -c ./init.sh && \
	sudo su postgres -c ./query.sh

	cp /tmp/query_results.log /tmp/query_stats.log ./output
	


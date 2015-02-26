


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

testclock:
	export DBNAME=testdb
	export SRCDIR=$(PWD)/postgresql

	cp ./policy/freelist.clock.c      ./postgresql/src/backend/storage/buffer/freelist.c
	cp ./policy/bufmgr.clock.c        ./postgresql/src/backend/storage/buffer/bufmgr.c
	cp ./policy/buf_internals.clock.h ./postgresql/src/include/storage/buf_internals.h

	cd $(SRCDIR) && sudo make uninstall && make -j8 && sudo make install
	./scripts/test.sh clock ./output

setup:
	export SRCDIR=$(PWD)/postgresql
	echo "using source dir $(SRCDIR)"
	chmod a+x scripts/*.sh
	./scripts/download.sh
	./scripts/compile.sh

	mkdir -p policy
	cp ./postgresql/src/backend/storage/buffer/freelist.c ./policy/freelist.clock.c
	cp ./postgresql/src/backend/storage/buffer/bufmgr.c   ./policy/bufmgr.clock.c
	cp ./postgresql/src/include/storage/buf_internals.h   ./policy/buf_internals.clock.h
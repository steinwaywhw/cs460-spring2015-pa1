
SRCDIR = $(PWD)/postgresql


all: 

testclock:
	mkdir -p ./output

	cp ./policy/freelist.clock.c      $(SRCDIR)/src/backend/storage/buffer/freelist.c
	cp ./policy/bufmgr.clock.c        $(SRCDIR)/src/backend/storage/buffer/bufmgr.c
	cp ./policy/buf_init.clock.c      $(SRCDIR)/src/backend/storage/buffer/buf_init.c
	cp ./policy/buf_internals.clock.h $(SRCDIR)/src/include/storage/buf_internals.h

	cd ./scripts && ./compile.sh $(SRCDIR) && ./test.sh clock $(PWD)/output

	
testmru: 
	mkdir -p ./output

	cp ./policy/freelist.mru.c      $(SRCDIR)/src/backend/storage/buffer/freelist.c
	cp ./policy/bufmgr.mru.c        $(SRCDIR)/src/backend/storage/buffer/bufmgr.c
	cp ./policy/buf_init.mru.c      $(SRCDIR)/src/backend/storage/buffer/buf_init.c
	cp ./policy/buf_internals.mru.h $(SRCDIR)/src/include/storage/buf_internals.h

	cd ./scripts && ./compile.sh $(SRCDIR) && ./test.sh mru $(PWD)/output

setup:
	rm -rf $(SRCDIR)
	cd scripts && ./download.sh $(SRCDIR)
	cd $(SRCDIR) && ./configure --with-blocksize=1 
	cd scripts && ./compile.sh $(SRCDIR)
	cd ./scripts && sudo su postgres -c ./init.sh 


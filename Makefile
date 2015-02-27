
SRCDIR = $(PWD)/postgresql

all: 

testclock:
	mkdir -p ./output

	cp ./policy/freelist.clock.c      $(SRCDIR)/src/backend/storage/buffer/freelist.c
	cp ./policy/bufmgr.clock.c        $(SRCDIR)/src/backend/storage/buffer/bufmgr.c
	cp ./policy/buf_internals.clock.h $(SRCDIR)/src/include/storage/buf_internals.h

	cd $(SRCDIR) && sudo make uninstall && make -j8 && sudo make install
	cd ./scripts && ./test.sh clock $(PWD)/output

setup:
	cd scripts && ./download.sh $(SRCDIR)
	cd scripts && ./compile.sh $(SRCDIR)

	mkdir -p policy

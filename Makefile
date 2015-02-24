


all: installdb


installdb:
	cd $HOME
	mkdir postgresql
	wget -qO- https://ftp.postgresql.org/pub/source/v9.4.1/postgresql-9.4.1.tar.gz  | tar -xvz --strip-components=1 -C postgresql
	cd postgresql
	./configure
	make -j8
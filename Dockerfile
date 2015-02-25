FROM ubuntu:14.10

ADD scripts /scripts
ADD setup.sh /setup.sh 

RUN chmod +x /setup.sh 
RUN /setup.sh

# RUN \
# 	apt-get update && \
# 	apt-get install -y wget libreadline-dev zlib1g-dev bison flex gcc make

# RUN \
# 	mkdir /postgresql && \
# 	wget -qO- https://ftp.postgresql.org/pub/source/v8.4.22/postgresql-8.4.22.tar.gz  | tar -xvz --strip-components=1 -C /postgresql && \
# 	cd /postgresql && \
# 	sed -i 's/#define BLCKSZ\s*8192$/#define BLCKSZ 512/' ./src/include/pg_config.h.in && \ 
# 	./configure --with-blocksize=1 && \
# 	make -j8 && \
# 	make install

# RUN \
# 	groupadd -r postgres && \
# 	useradd -r -g postgres postgres && \
# 	mkdir -p /var/run/postgresql && \
# 	chown -R postgres /var/run/postgresql && \
# 	mkdir -p /var/lib/postgresql/data && \
# 	chown -R postgres /var/lib/postgresql

# ADD scripts /scripts
# RUN \
# 	chown -R postgres /scripts && \
# 	cd /scripts && \
# 	su postgres -c ./init.sh && \
# 	su postgres -c ./query.sh


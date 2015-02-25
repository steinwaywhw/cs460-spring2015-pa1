#!/bin/bash

apt-get update 
apt-get install -y wget libreadline-dev zlib1g-dev bison flex gcc make

mkdir ./postgresql 
wget -qO- https://ftp.postgresql.org/pub/source/v8.4.22/postgresql-8.4.22.tar.gz  | tar -xvz --strip-components=1 -C ./postgresql 
cd ./postgresql 
#sed -i 's/#define BLCKSZ\s*8192$/#define BLCKSZ 512/' ./src/include/pg_config.h.in  
./configure --with-blocksize=1 
make -j8 
make install
cd ..

groupadd -r postgres 
useradd -r -g postgres postgres 
mkdir -p /var/run/postgresql 
chown -R postgres /var/run/postgresql 
mkdir -p /var/lib/postgresql/data 
chown -R postgres /var/lib/postgresql
chown -R postgres ./scripts 

cd ./scripts 
sudo su postgres -c ./init.sh 
sudo su postgres -c ./query.sh
cd ..

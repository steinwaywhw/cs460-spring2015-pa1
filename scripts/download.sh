#!/bin/bash
#
# Author: Hanwen Wu <steinwaywhw@gmail.com>
# Date: Feb 25 2015
# 

sudo apt-get update 
sudo apt-get install -y wget libreadline-dev zlib1g-dev bison flex gcc make

mkdir -p $SRCDIR
wget -qO- https://ftp.postgresql.org/pub/source/v8.4.22/postgresql-8.4.22.tar.gz  | tar -xvz --strip-components=1 -C $SRCDIR

sudo groupadd -r postgres 
sudo useradd -r -g postgres postgres 
sudo mkdir -p /var/run/postgresql 
sudo chown -R postgres /var/run/postgresql 
sudo mkdir -p /var/lib/postgresql/data 
sudo chown -R postgres /var/lib/postgresql


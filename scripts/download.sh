#!/bin/bash
#
# Author: Hanwen Wu <steinwaywhw@gmail.com>
# Date: Feb 25 2015
# 

apt-get update 
apt-get install -y wget libreadline-dev zlib1g-dev bison flex gcc make

mkdir -p $SRCDIR
wget -qO- https://ftp.postgresql.org/pub/source/v8.4.22/postgresql-8.4.22.tar.gz  | tar -xvz --strip-components=1 -C $SRCDIR

groupadd -r postgres 
useradd -r -g postgres postgres 
mkdir -p /var/run/postgresql 
chown -R postgres /var/run/postgresql 
mkdir -p /var/lib/postgresql/data 
chown -R postgres /var/lib/postgresql


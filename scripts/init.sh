#!/bin/bash
#           -*-mode:ksh-*-  (keep emacs happy)
#
# init.sh: Initialize the experiment
# 
# Sailesh Krishnamurthy
#
# Modified by ashwin thangali
# Updated by Hanwen Wu <steinwaywhw@gmail.com> 02-24-2015


help ()
{
  	echo
  	echo 'Usage: init.sh [index]'
  	echo 
  	echo 'The argument if provided should be the string "index" and'
  	echo 'results in the creation of indices on the R and S tables.'
  	echo
}

DBNAME=testdb
SEC=3
INDEX=0

# ==================================
if [ "$#" -gt 1 ]
then
  	help
  	exit 1
fi

# ==================================
if [ "$#" == 1 ]
then
	if [ "$1" != "index" ]
	then
  	  	help
	  	exit 1
	fi
	INDEX=1
fi

# ==================================
source env.sh

# ==================================
echo "executing initdb"
initdb 
echo "initdb successful"
echo "local all all trust" >> /var/lib/postgresql/data/pg_hba.conf

# ==================================
echo "starting postmaster"
pg_ctl start 
if [ "$?" != "0" ]
then
  echo "error while statring postgres server: pg_ctl start"
  exit 1;
fi
echo "sleeping $SEC seconds while the postmaster brushes its teeth"
sleep $SEC

# ==================================
echo "executing createdb"
createdb $DBNAME 
if [ "$?" != "0" ]
then
  echo "error while executing: createdb $DBNAME"
  pg_ctl stop
  exit 1;
fi
echo "createdb successful"

# ==================================
echo "executing commands from prepare.sql"
psql -d $DBNAME -f prepare.sql
if [ "$?" != "0" ]
then
  echo "error when executing psql $DBNAME -f prepare.sql"
	echo "stopping postmaster"
	pg_ctl stop
	exit 1;
fi
echo "commands from prepare.sql executed successfully"

# ==================================
if [ $INDEX -eq 1 ]
then
	echo "executing commands from indexes.sql"
	psql -d $DBNAME -f indexes.sql
	if [ "$?" != "0" ]
	then
		echo "error when executing psql $DBNAME -f indexes.sql"
		echo "stopping postmaster"
		pg_ctl stop
		exit 1;
	fi
	echo "Commands from indexes.sql executed successfully"
fi

# ==================================
echo "stopping postmaster"
pg_ctl stop

# ==================================
echo
echo "init.sh completed successfully"


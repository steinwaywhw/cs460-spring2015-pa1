#!/bin/bash

help ()
{
	echo
	echo 'Usage: test.sh clock|mru|lru outputdir '
	echo
}

if [ "$#" != 2 ]
then
  	help
  	exit 1
fi

if [ "$1" != "clock" -a "$1" != "mru" -a "$1" != "lru" ]
then 
	help
	exit 1 
fi

sudo su postgres -c ./init.sh 
sudo su postgres -c ./query.sh

cp /tmp/query_results.log $2/result.$1.$(date +%T).log
cp /tmp/query_stats.log   $2/stats.$1.$(date  +%T).log

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

source env.sh

rm -f /tmp/query_results.log /tmp/query_results.log
sudo su postgres -c ./reinit.sh
sudo su postgres -c ./query.sh

DATE=$(date +%T)

cp /tmp/query_results.log $2/result.$1.$DATE.log
cp /tmp/query_results.log $2/buffer.$1.$DATE.log
cp /tmp/query_stats.log   $2/stats.$1.$DATE.log

sed -i '/^[\[<]/d' $2/result.$1.$DATE.log
sed -i '/^[\[<]/!d' $2/buffer.$1.$DATE.log
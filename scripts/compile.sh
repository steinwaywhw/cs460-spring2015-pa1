#!/bin/bash
#
# Author: Hanwen Wu <steinwaywhw@gmail.com>
# Date: Feb 25 2015
# 

if [ "$#" != 1 ]
then 
	echo
	echo "Usage: compile.sh dir"
	echo
fi

cd $1
#sed -i 's/#define BLCKSZ\s*8192$/#define BLCKSZ 512/' ./src/include/pg_config.h.in  
./configure --with-blocksize=1 
sudo make uninstall
make -j8 
sudo make install

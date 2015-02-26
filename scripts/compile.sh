#!/bin/bash
#
# Author: Hanwen Wu <steinwaywhw@gmail.com>
# Date: Feb 25 2015
# 

cd $SRCDIR
#sed -i 's/#define BLCKSZ\s*8192$/#define BLCKSZ 512/' ./src/include/pg_config.h.in  
./configure --with-blocksize=1 
make -j8 
make install

#!/bin/bash
set -e
cores=4

cd mp4v2
    find . | xargs touch --date="2009-05-20 00:00:00" 
	./configure
	make -j $cores libmp4v2.la
cd ..

cd faad2
	./configure
	cd libfaad
		make -j $cores
	cd ..
cd ..

autoreconf -vif

if [[ "$(uname -s)" == "CYGWIN"* ]]; then 
    rm -rf m4/
fi

./configure
make -j $cores
strip -s "aacgain/aacgain"
echo Your compiled binary is aacgain/aacgain -- You should copy it somewhere on your path to use it

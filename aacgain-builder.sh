#!/bin/bash
set -e
cores=4

cp -p aacgain/linux/configure.ac .
cp -p aacgain/linux/Makefile.am.topsrcdir Makefile.am
cp -p aacgain/linux/Makefile.am.mp3gain mp3gain/Makefile.am
cp -p aacgain/linux/Makefile.am.mpglibDBL mp3gain/mpglibDBL/Makefile.am
rm -f mp3gain/mpglibDBL/config.h

sed 's!\.\.\/!!g' aacgain/mp4v2.patch | patch -p0
sed 's!\.\.\/!!g' aacgain/linux/mp3gain.patch | patch -p0 -N
patch -p0 <rtphint.patch
patch -p0 <Utility.patch

autoreconf -vif

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

./configure
make -j $cores
strip -s "aacgain/aacgain"
echo Your compiled binary is aacgain/aacgain -- You should copy it somewhere on your path to use it

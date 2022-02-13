#!/bin/bash
set -e

cp -p aacgain/linux/configure.ac .
cp -p aacgain/linux/Makefile.am.topsrcdir Makefile.am
cp -p aacgain/linux/Makefile.am.mp3gain mp3gain/Makefile.am
cp -p aacgain/linux/Makefile.am.mpglibDBL mp3gain/mpglibDBL/Makefile.am
rm -f mp3gain/mpglibDBL/config.h

sed 's!\.\.\/!!g' aacgain/mp4v2.patch | patch -p0
sed 's!\.\.\/!!g' aacgain/linux/mp3gain.patch | patch -p0 -N
patch -p0 <rtphint.patch
patch -p0 <Utility.patch

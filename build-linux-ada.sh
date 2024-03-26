#!/bin/sh

set -xe

mkdir -p linux
gcc -ggdb main.c -o linux/main -ldl
gcc -ggdb -c dummy.c -o dummy.o -ldl
gnatmake -ggdb -f -fPIC -gnat2022 -c message.adb
gnatbind -Lmessage message.ali
gnatlink message.ali -o linux/libmessage.so -shared dummy.o
#gcc -shared message.o -o linux/libmessage.so -L/lib/gcc/x86_64-pc-linux-gnu/13.2.1/adalib/ -l:libgnat_pic.a

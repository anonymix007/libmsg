#!/bin/sh

set -xe

mkdir -p linux-llvm
llvm-gcc -ggdb main.c -o linux-llvm/main -ldl
llvm-gcc -ggdb -fPIC -c dummy.c -o dummy.o -ldl
llvm-gnatmake -ggdb -f -fPIC -gnat2022 -c message.adb
llvm-gnatbind -Lmessage message.ali
llvm-gnatlink message.ali -o linux-llvm/libmessage.so -shared dummy.o
#gcc -shared message.o -o linux/libmessage.so -L/lib/gcc/x86_64-pc-linux-gnu/13.2.1/adalib/ -l:libgnat_pic.a

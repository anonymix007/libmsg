#!/bin/sh

set -xe

mkdir -p linux
gcc main.c -o linux/main -ldl
gcc -shared libmessage.c -o linux/libmessage.so

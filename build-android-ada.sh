#!/bin/sh

set -xe

SYSROOT=$CLANG_R475365B_CUSTOM/../../../sysroots/ndk/arm64

mkdir -p android
$CLANG_R475365B_CUSTOM/bin/clang --target=aarch64-linux-android29 -ggdb main.c -o android/main -ldl --sysroot=$SYSROOT
$LLVM_GNAT/llvm-interface/bin/llvm-gcc --target=aarch64-linux-android29 -ggdb -fPIC -gnat2022 -c message.adb
$LLVM_GNAT/llvm-interface/bin/llvm-gnatbind -Lmessage message.ali
$LLVM_GNAT/llvm-interface/bin/llvm-gnatlink message.ali -o android/libmessage.so -shared
#$CLANG_R475365B_CUSTOM/bin/ld.lld -shared message.o -o android/libmessage.so

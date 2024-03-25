#!/bin/sh

set -xe

SYSROOT=$CLANG_R475365B_CUSTOM/../../../sysroots/ndk/arm64
LLD=$CLANG_R475365B_CUSTOM/bin/ld.lld

mkdir -p android
$CLANG_R475365B_CUSTOM/bin/clang --target=aarch64-linux-android29 -ggdb main.c -o android/main -ldl --sysroot=$SYSROOT
$CLANG_R475365B_CUSTOM/bin/clang --target=aarch64-linux-android29 -ggdb -fPIC -c dummy.c -o dummy.o --sysroot=$SYSROOT
$LLVM_GNAT/llvm-interface/bin/llvm-gcc --target=aarch64-linux-android29 -ggdb -fPIC -gnat2022 -c message.adb
$LLVM_GNAT/llvm-interface/bin/llvm-gnatbind -Lmessage message.ali
$LLVM_GNAT/llvm-interface/bin/llvm-gnatlink message.ali -o android/libmessage.so --LINK="$LLD" dummy.o -shared --sysroot=$SYSROOT -L$CLANG_R475365B_CUSTOM/lib/clang/16.0.2/lib/linux -L$CLANG_R475365B_CUSTOM/lib/clang/16.0.2/lib/linux/aarch64 -L$SYSROOT/usr/lib/aarch64-linux-android/29 -L$SYSROOT/usr/lib/aarch64-linux-android -lc -l:libclang_rt.builtins-aarch64-android.a -lunwind

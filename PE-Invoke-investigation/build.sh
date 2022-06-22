#!/bin/bash 
[[ ! -d build ]] && mkdir build && rm -rf build/*
[[ ! -d bak ]] && mkdir bak
x86_64-w64-mingw32-gcc-win32 src/main.c -Dm64 -o build/investigator_x64.exe
x86_64-w64-mingw32-gcc-win32 src/main.c -Dm32 -o build/investigator_x32.exe

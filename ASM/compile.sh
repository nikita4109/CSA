#!/bin/bash

nasm -f elf64 -F dwarf main.asm -g
gcc -fsanitize=address -fno-pie -no-pie *.o
rm *.o

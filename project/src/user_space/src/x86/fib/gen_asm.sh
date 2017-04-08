#!/bin/bash

echo "Compile code first before generating assembly code"
objdump -Sd ./fib.o > fib.out
objdump -Sd ./fib_gem5.o > fib_gem5.out

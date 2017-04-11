#!/bin/bash

echo "Compile code first before generating assembly code"
objdump -Sd ./fib.o > fib.out

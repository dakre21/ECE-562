## Homework 2 - Benchmark Automation Script
##### Author: Jon Anderson

Run the make_benchmark_commands.sh file inside this directory:

 * This file will generate commands for all benchmarks in all possible configurations
 * Run run_benchmarks_multithreaded.sh to Run each benchmark per core of CPU.
 * The output files are name by the benchmark and cache configuration
 * E.g. crc_2_16_4.txt (crc benchmark with cache size of 2, line size of 16 and associativity of 4)
 
 ### Output Directory
 
 * Jon/Results


## How to run the benchmark

```bash
chmod +x run_benchmarks.sh
chmod +x run_benchmarks_multithreaded.sh
sudo apt-get update
sudo apt-get install parallel
./make_benchmark_commands.sh
./run_benchmarks_multithreaded.sh
```
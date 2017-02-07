#! /bin/bash
echo "===========================Benchmark Script Created by Jon Anderson==========================="
echo "Starting Benchmarks:"
#$simplescalar/sim-outorder -cache:il1 il1:8:64:4:l -cache:dl1 dl1:<size>:<line_size>:<associativity>:l -cache:il1lat 1 -cache:dl1lat 1 -mem:lat 80 2 -issue:inorder -redir:sim <statistics_output_file> $cmd
#././../../simplesim-3.0/sim-outorder -cache:il1 il1:8:64:4:l -cache:dl1 dl1:${i}:${j}:<associativity>:l -cache:il1lat 1 -cache:dl1lat 1 -mem:lat 80 2 -issue:inorder redir:sim Results/crc_sim_results.txt -redir:prog Results/crc_data_results.txt  ././../../MiBench/crc ././../../MiBench/Benchmarks/telecomm/adpcm/data/large.pcm
for((i = 2; i<=8; i=$((i*2))))
do
    #echo i="$i"

    for((j = 16; j<=64; j=$((j*2))))
    do
        #echo  j="$j"
       ././../../simplesim-3.0/sim-outorder -cache:il1 il1:8:64:4:l -cache:dl1 dl1:${i}:${j}:1:l -cache:il1lat 1 -cache:dl1lat 1 -mem:lat 80 2 -issue:inorder -redir:sim Results/crc_sim_results_${i}_${j}.txt ././../../MiBench/crc ././../../MiBench/Benchmarks/telecomm/adpcm/data/large.pcm
    done


done
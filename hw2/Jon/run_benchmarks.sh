#! /bin/bash
RED='\033[0;31m' # RED!
NC='\033[0m' # No Color
echo "===========================Benchmark Script Created by Jon Anderson==========================="
echo "Starting Benchmarks:"
#Since each benchmark requires different parameters, you can't iterate over the same command
#Thus the command to run each benchmark (according to their runme_small.sh) is hardcoded in each loop
#Each benchmark is ran in all permutations in the nested for loops
#Each benchmark has it's own loop to reduce complexity and technical debt

echo "${RED}#########################Starting Benchmark (crc)#########################${NC}"
for((i = 2048; i<=8192; i=$((i*2))))
do
    #echo i="$i"

    for((j = 16; j<=64; j=$((j*2))))
        do
            #echo  j="$j"
                for((l = 1; l<=4; l=$((l*2))))
                     do
                        echo  "Starting crc benchmark with cache size of ${i}, line size ${j} and associativity of ${l}"
                        eval "././../../simplesim-3.0/sim-outorder -cache:il1 il1:8:64:4:l -cache:dl1 dl1:${i}:${j}:${l}:l -cache:il1lat 1 -cache:dl1lat 1 -mem:lat 80 2 -issue:inorder -redir:sim Results/crc_${i}_${j}_${l}.txt  ././../../MiBench/crc ././../../MiBench/Benchmarks/telecomm/adpcm/data/large.pcm"
                      done
    done


done

echo "${RED}#########################Starting Benchmark (dijkstra_small)#########################${NC}"
for((i = 2048; i<=8192; i=$((i*2))))
do
    #echo i="$i"

    for((j = 16; j<=64; j=$((j*2))))
        do
            #echo  j="$j"
                for((l = 1; l<=4; l=$((l*2))))
                     do
                        echo  "Starting dijkstra_small benchmark with cache size of ${i}, line size ${j} and associativity of ${l}"
                        eval "././../../simplesim-3.0/sim-outorder -cache:il1 il1:8:64:4:l -cache:dl1 dl1:${i}:${j}:${l}:l -cache:il1lat 1 -cache:dl1lat 1 -mem:lat 80 2 -issue:inorder -redir:sim Results/dijkstra_small_${i}_${j}_${l}.txt  ././../../MiBench/dijkstra_small ././../../MiBench/Benchmarks/network/dijkstra/input.dat"
                      done
    done


done

echo "${RED}#########################Starting Benchmark (fft)#########################${NC}"
for((i = 2048; i<=8192; i=$((i*2))))
do
    #echo i="$i"

    for((j = 16; j<=64; j=$((j*2))))
        do
            #echo  j="$j"
                for((l = 1; l<=4; l=$((l*2))))
                     do
                        echo  "Starting fft benchmark with cache size of ${i}, line size ${j} and associativity of ${l}"
                        eval "././../../simplesim-3.0/sim-outorder -cache:il1 il1:8:64:4:l -cache:dl1 dl1:${i}:${j}:${l}:l -cache:il1lat 1 -cache:dl1lat 1 -mem:lat 80 2 -issue:inorder -redir:sim Results/fft_${i}_${j}_${l}.txt  ././../../MiBench/fft 4 4096"
                        echo  "Starting fft inverse benchmark with cache size of ${i}, line size ${j} and associativity of ${l}"
                        eval "././../../simplesim-3.0/sim-outorder -cache:il1 il1:8:64:4:l -cache:dl1 dl1:${i}:${j}:${l}:l -cache:il1lat 1 -cache:dl1lat 1 -mem:lat 80 2 -issue:inorder -redir:sim Results/fft_${i}_${j}_${l}.txt  ././../../MiBench/fft 4 8192 -i"
                      done
    done


done

echo "${RED}#########################Starting Benchmark (qsort_small)#########################${NC}"
for((i = 2048; i<=8192; i=$((i*2))))
do
    #echo i="$i"

    for((j = 16; j<=64; j=$((j*2))))
        do
            #echo  j="$j"
                for((l = 1; l<=4; l=$((l*2))))
                     do
                        echo  "Starting qsort_small benchmark with cache size of ${i}, line size ${j} and associativity of ${l}"
                        eval "././../../simplesim-3.0/sim-outorder -cache:il1 il1:8:64:4:l -cache:dl1 dl1:${i}:${j}:${l}:l -cache:il1lat 1 -cache:dl1lat 1 -mem:lat 80 2 -issue:inorder -redir:sim Results/qsort_small_${i}_${j}_${l}.txt  ././../../MiBench/qsort_small ././../../MiBench/Benchmarks/automotive/qsort/input_small.dat"
                      done
    done


done

echo "${RED}#########################Starting Benchmark (rawcaudio)#########################${NC}"
for((i = 2048; i<=8192; i=$((i*2))))
do
    #echo i="$i"

    for((j = 16; j<=64; j=$((j*2))))
        do
            #echo  j="$j"
                for((l = 1; l<=4; l=$((l*2))))
                     do
                        echo  "Starting rawcaudio benchmark with cache size of ${i}, line size ${j} and associativity of ${l}"
                        eval "././../../simplesim-3.0/sim-outorder -cache:il1 il1:8:64:4:l -cache:dl1 dl1:${i}:${j}:${l}:l -cache:il1lat 1 -cache:dl1lat 1 -mem:lat 80 2 -issue:inorder -redir:sim Results/rawcaudio_${i}_${j}_${l}.txt  ././../../MiBench/rawcaudio < ././../../MiBench/Benchmarks/telecomm/adpcm/data/small.pcm"
                      done
    done


done

echo "${RED}#########################Starting Benchmark (rijndael)#########################${NC}"
for((i = 2048; i<=8192; i=$((i*2))))
do
    #echo i="$i"

    for((j = 16; j<=64; j=$((j*2))))
        do
            #echo  j="$j"
                for((l = 1; l<=4; l=$((l*2))))
                     do
                        echo  "Starting rijndael ENCODE benchmark with cache size of ${i}, line size ${j} and associativity of ${l}"
                        eval "././../../simplesim-3.0/sim-outorder -cache:il1 il1:8:64:4:l -cache:dl1 dl1:${i}:${j}:${l}:l -cache:il1lat 1 -cache:dl1lat 1 -mem:lat 80 2 -issue:inorder -redir:sim Results/rijndael_${i}_${j}_${l}.txt  ././../../MiBench/rijndael ././../../MiBench/Benchmarks/security/rijndael/input_small.asc Results/output_small_${i}_${j}_${l}.enc e 1234567890abcdeffedcba09876543211234567890abcdeffedcba0987654321"
                        echo  "Starting rijndael DECODE benchmark with cache size of ${i}, line size ${j} and associativity of ${l}"
                        eval "././../../simplesim-3.0/sim-outorder -cache:il1 il1:8:64:4:l -cache:dl1 dl1:${i}:${j}:${l}:l -cache:il1lat 1 -cache:dl1lat 1 -mem:lat 80 2 -issue:inorder -redir:sim Results/rijndael_${i}_${j}_${l}.txt  ././../../MiBench/rijndael Results/output_small_${i}_${j}_${l}.enc d 1234567890abcdeffedcba09876543211234567890abcdeffedcba0987654321"
                      done
    done


done

echo "${RED}#########################Starting Benchmark (search_large)#########################${NC}"
for((i = 2048; i<=8192; i=$((i*2))))
do
    #echo i="$i"

    for((j = 16; j<=64; j=$((j*2))))
        do
            #echo  j="$j"
                for((l = 1; l<=4; l=$((l*2))))
                     do
                        echo  "Starting search_large benchmark with cache size of ${i}, line size ${j} and associativity of ${l}"
                        eval "././../../simplesim-3.0/sim-outorder -cache:il1 il1:8:64:4:l -cache:dl1 dl1:${i}:${j}:${l}:l -cache:il1lat 1 -cache:dl1lat 1 -mem:lat 80 2 -issue:inorder -redir:sim Results/search_large_${i}_${j}_${l}.txt  ././../../MiBench/search_large"
                      done
    done


done

echo "${RED}#########################Starting Benchmark (sha)#########################${NC}"
for((i = 2048; i<=8192; i=$((i*2))))
do
    #echo i="$i"

    for((j = 16; j<=64; j=$((j*2))))
        do
            #echo  j="$j"
                for((l = 1; l<=4; l=$((l*2))))
                     do
                        echo  "Starting sha benchmark with cache size of ${i}, line size ${j} and associativity of ${l}"
                        eval "././../../simplesim-3.0/sim-outorder -cache:il1 il1:8:64:4:l -cache:dl1 dl1:${i}:${j}:${l}:l -cache:il1lat 1 -cache:dl1lat 1 -mem:lat 80 2 -issue:inorder -redir:sim Results/sha_${i}_${j}_${l}.txt  ././../../MiBench/sha ././../../MiBench/Benchmarks/security/sha/input_small.asc"
                      done
    done


done

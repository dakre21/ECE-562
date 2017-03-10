#! /bin/bash
RED='\033[0;31m' # RED!
NC='\033[0m' # No Color
rm commands
touch commands
echo "echo ===========================Benchmark Script Created by Jon Anderson===========================" >> commands
echo "echo Starting Benchmarks:" >> commands
#Since each benchmark requires different parameters, you can't iterate over the same command
#Thus the command to run each benchmark (according to their runme_small.sh) is hardcoded in each loop
#Each benchmark is ran in all permutations in the nested for loops
#Each benchmark has it's own loop to reduce complexity and technical debt

echo "echo -e '${RED}#########################Starting Benchmark (crc)#########################${NC}'" >> commands
for((i = 2048; i<=8192; i=$((i*2))))
do
    ##echo i="$i"

    for((j = 16; j<=64; j=$((j*2))))
        do
            ##echo  j="$j"
                for((l = 1; l<=4; l=$((l*2))))
                     do
                        s=$(($i / $j / $l))
                        echo "echo Starting crc benchmark with cache size of ${i}: number of sets ${s}, line size ${j} and associativity of ${l}" >> commands
                        echo "././../../simplesim-3.0/sim-outorder -cache:il1 il1:8:64:4:l -cache:dl1 dl1:${s}:${j}:${l}:l -cache:il1lat 1 -cache:dl1lat 1 -mem:lat 80 2 -issue:inorder -redir:sim Results/crc_${s}_${j}_${l}.txt  ././../../MiBench/crc ././../../MiBench/Benchmarks/telecomm/adpcm/data/large.pcm" >> commands
                      done
    done


done

echo "echo -e '${RED}#########################Starting Benchmark (dijkstra_small)#########################${NC}'"  >> commands
for((i = 2048; i<=8192; i=$((i*2))))
do
    ##echo i="$i"

    for((j = 16; j<=64; j=$((j*2))))
        do
            ##echo  j="$j"
                for((l = 1; l<=4; l=$((l*2))))
                     do
                        s=$(($i / $j / $l))
                        echo "echo Starting dijkstra_small benchmark with cache size of ${i}: number of sets ${s}, line size ${j} and associativity of ${l}" >> commands
                        echo "././../../simplesim-3.0/sim-outorder -cache:il1 il1:8:64:4:l -cache:dl1 dl1:${s}:${j}:${l}:l -cache:il1lat 1 -cache:dl1lat 1 -mem:lat 80 2 -issue:inorder -redir:sim Results/dijkstrasmall_${s}_${j}_${l}.txt  ././../../MiBench/dijkstra_small ././../../MiBench/Benchmarks/network/dijkstra/input.dat" >> commands
                      done
    done


done

echo "echo -e '${RED}#########################Starting Benchmark (fft)#########################${NC}'"  >> commands
for((i = 2048; i<=8192; i=$((i*2))))
do
    ##echo i="$i"

    for((j = 16; j<=64; j=$((j*2))))
        do
            ##echo  j="$j"
                for((l = 1; l<=4; l=$((l*2))))
                     do
                        s=$(($i / $j / $l))
                        echo "echo Starting fft benchmark with cache size of ${i}: number of sets ${s}, line size ${j} and associativity of ${l}" >> commands
                        echo "././../../simplesim-3.0/sim-outorder -cache:il1 il1:8:64:4:l -cache:dl1 dl1:${s}:${j}:${l}:l -cache:il1lat 1 -cache:dl1lat 1 -mem:lat 80 2 -issue:inorder -redir:sim Results/fft_${s}_${j}_${l}.txt  ././../../MiBench/fft 4 4096" >> commands
                        echo "echo Starting fft inverse benchmark with cache size of ${i}: number of sets ${s}, line size ${j} and associativity of ${l}" >> commands
                        echo "././../../simplesim-3.0/sim-outorder -cache:il1 il1:8:64:4:l -cache:dl1 dl1:${s}:${j}:${l}:l -cache:il1lat 1 -cache:dl1lat 1 -mem:lat 80 2 -issue:inorder -redir:sim Results/fftinv_${s}_${j}_${l}.txt  ././../../MiBench/fft 4 8 -i" >> commands
                      done
    done


done

echo "echo -e '${RED}#########################Starting Benchmark (qsort_small)#########################${NC}'"  >> commands
for((i = 2048; i<=8192; i=$((i*2))))
do
    ##echo i="$i"

    for((j = 16; j<=64; j=$((j*2))))
        do
            ##echo  j="$j"
                for((l = 1; l<=4; l=$((l*2))))
                     do
                        s=$(($i / $j / $l))
                        echo "echo Starting qsort_small benchmark with cache size of ${i}: number of sets ${s}, line size ${j} and associativity of ${l}" >> commands
                        echo "././../../simplesim-3.0/sim-outorder -cache:il1 il1:8:64:4:l -cache:dl1 dl1:${s}:${j}:${l}:l -cache:il1lat 1 -cache:dl1lat 1 -mem:lat 80 2 -issue:inorder -redir:sim Results/qsortsmall_${s}_${j}_${l}.txt  ././../../MiBench/qsort_small ././../../MiBench/Benchmarks/automotive/qsort/input_small.dat" >> commands
                      done
    done


done

echo "echo -e '${RED}#########################Starting Benchmark (rawcaudio)#########################${NC}'"  >> commands
for((i = 2048; i<=8192; i=$((i*2))))
do
    ##echo i="$i"

    for((j = 16; j<=64; j=$((j*2))))
        do
            ##echo  j="$j"
                for((l = 1; l<=4; l=$((l*2))))
                     do
                        s=$(($i / $j / $l))
                        echo "echo Starting rawcaudio benchmark with cache size of ${i}: number of sets ${s}, line size ${j} and associativity of ${l}" >> commands
                        echo "././../../simplesim-3.0/sim-outorder -cache:il1 il1:8:64:4:l -cache:dl1 dl1:${s}:${j}:${l}:l -cache:il1lat 1 -cache:dl1lat 1 -mem:lat 80 2 -issue:inorder -redir:sim Results/rawcaudio_${s}_${j}_${l}.txt  ././../../MiBench/rawcaudio < ././../../MiBench/Benchmarks/telecomm/adpcm/data/small.pcm > Results/rawcaudio_${s}_${j}_${l}.dat" >> commands
                      done
    done


done

echo "echo -e '${RED}#########################Starting Benchmark (rijndael)#########################${NC}'"  >> commands
for((i = 2048; i<=8192; i=$((i*2))))
do
    ##echo i="$i"

    for((j = 16; j<=64; j=$((j*2))))
        do
            ##echo  j="$j"
                for((l = 1; l<=4; l=$((l*2))))
                     do
                        s=$(($i / $j / $l))
                        echo "echo Starting rijndael ENCODE benchmark with cache size of ${i}: number of sets ${s}, line size ${j} and associativity of ${l}" >> commands
                        echo "././../../simplesim-3.0/sim-outorder -cache:il1 il1:8:64:4:l -cache:dl1 dl1:${s}:${j}:${l}:l -cache:il1lat 1 -cache:dl1lat 1 -mem:lat 80 2 -issue:inorder -redir:sim Results/rijndaelencode_${s}_${j}_${l}.txt  ././../../MiBench/rijndael ././../../MiBench/Benchmarks/security/rijndael/input_small.asc Results/output_small_${s}_${j}_${l}.enc e 1234567890abcdeffedcba09876543211234567890abcdeffedcba0987654321" >> commands
                      done
    done


done
for((i = 2048; i<=8192; i=$((i*2))))
do
    ##echo i="$i"

    for((j = 16; j<=64; j=$((j*2))))
        do
            ##echo  j="$j"
                for((l = 1; l<=4; l=$((l*2))))
                     do
                        s=$(($i / $j / $l))
                        echo "echo Starting rijndael DECODE benchmark with cache size of ${i}: number of sets ${s}, line size ${j} and associativity of ${l}" >> commands
                        echo "././../../simplesim-3.0/sim-outorder -cache:il1 il1:8:64:4:l -cache:dl1 dl1:${s}:${j}:${l}:l -cache:il1lat 1 -cache:dl1lat 1 -mem:lat 80 2 -issue:inorder -redir:sim Results/rijndaeldecode_${s}_${j}_${l}.txt  ././../../MiBench/rijndael Results/output_small_${s}_${j}_${l}.enc Results/output_small_${s}_${j}_${l}.dec d 1234567890abcdeffedcba09876543211234567890abcdeffedcba0987654321" >> commands
                      done
    done


done
echo "echo -e '${RED}#########################Starting Benchmark (search_large)#########################${NC}'"  >> commands
for((i = 2048; i<=8192; i=$((i*2))))
do
    ##echo i="$i"

    for((j = 16; j<=64; j=$((j*2))))
        do
            ##echo  j="$j"
                for((l = 1; l<=4; l=$((l*2))))
                     do
                        s=$(($i / $j / $l))
                        echo "echo Starting search_large benchmark with cache size of ${i}: number of sets ${s}, line size ${j} and associativity of ${l}" >> commands
                        echo "././../../simplesim-3.0/sim-outorder -cache:il1 il1:8:64:4:l -cache:dl1 dl1:${s}:${j}:${l}:l -cache:il1lat 1 -cache:dl1lat 1 -mem:lat 80 2 -issue:inorder -redir:sim Results/searchlarge_${s}_${j}_${l}.txt  ././../../MiBench/search_large" >> commands
                      done
    done


done

echo "echo -e '${RED}#########################Starting Benchmark (sha)#########################${NC}'"  >> commands
for((i = 2048; i<=8192; i=$((i*2))))
do
    ##echo i="$i"

    for((j = 16; j<=64; j=$((j*2))))
        do
            ##echo  j="$j"
                for((l = 1; l<=4; l=$((l*2))))
                     do
                        s=$(($i / $j / $l))
                        echo "echo Starting sha benchmark with cache size of ${i}: number of sets ${s}, line size ${j} and associativity of ${l}" >> commands
                        echo "././../../simplesim-3.0/sim-outorder -cache:il1 il1:8:64:4:l -cache:dl1 dl1:${s}:${j}:${l}:l -cache:il1lat 1 -cache:dl1lat 1 -mem:lat 80 2 -issue:inorder -redir:sim Results/sha_${s}_${j}_${l}.txt  ././../../MiBench/sha ././../../MiBench/Benchmarks/security/sha/input_small.asc" >> commands
                      done
    done


done

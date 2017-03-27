#! /bin/python

# Author: Jon Anderson
# Python version of the command builder script
# This will have more configurations than the original 2KB-8KB , but I followed the first script.

benchmarks = ["crc"]
line_sizes = [16, 32, 64]
num_sets = [8, 16, 32, 64, 128, 256, 512]
associativity = [1, 2, 4]

for i in range(len(benchmarks)):
    print "echo -e '\033[0;31m#########################Starting Benchmark ("+benchmarks[i]+")#########################\033[0m'"
    for x in range(len(num_sets)):
        for y in range(len(line_sizes)):
            for z in range(len(associativity)):
                print "echo Starting "+benchmarks[i]+" benchmark with Number of sets="+str(num_sets[x])+" Line Size="+str(line_sizes[y])+" and Associativity of "+str(associativity[z])+". Total Cache size is "+str(num_sets[x]*line_sizes[y])+" Bytes"
                print "././../../simplesim-3.0/sim-outorder -cache:il1 il1:8:64:4:l -cache:dl1 dl1:"+str(num_sets[x])+":"+str(line_sizes[y])+":"+str(associativity[z])+":l -cache:il1lat 1 -cache:dl1lat 1 -mem:lat 80 2 -issue:inorder -redir:sim Results/crc_"+str(num_sets[x])+"_"+str(line_sizes[y])+"_"+str(associativity[z])+".txt  ././../../MiBench/crc ././../../MiBench/Benchmarks/telecomm/adpcm/data/large.pcm"
                # print  benchmarks[i] + "_" + str(num_sets[x]) + "_" + str(line_sizes[y]) + "_" + str(associativity[z])
benchmarks = ["dijkstrasmall"]
for i in range(len(benchmarks)):
    print "echo -e '\033[0;31m#########################Starting Benchmark ("+benchmarks[i]+")#########################\033[0m'"
    for x in range(len(num_sets)):
        for y in range(len(line_sizes)):
            for z in range(len(associativity)):
                print "echo Starting "+benchmarks[i]+" benchmark with Number of sets="+str(num_sets[x])+" Line Size="+str(line_sizes[y])+" and Associativity of "+str(associativity[z])+". Total Cache size is "+str(num_sets[x]*line_sizes[y])+" Bytes"
                print "././../../simplesim-3.0/sim-outorder -cache:il1 il1:8:64:4:l -cache:dl1 dl1:"+str(num_sets[x])+":"+str(line_sizes[y])+":"+str(associativity[z])+":l -cache:il1lat 1 -cache:dl1lat 1 -mem:lat 80 2 -issue:inorder -redir:sim Results/dijkstrasmall_"+str(num_sets[x])+"_"+str(line_sizes[y])+"_"+str(associativity[z])+".txt  ././../../MiBench/dijkstra_small ././../../MiBench/Benchmarks/network/dijkstra/input.dat"
                # print  benchmarks[i] + "_" + str(num_sets[x]) + "_" + str(line_sizes[y]) + "_" + str(associativity[z])
benchmarks = ["fft"]
for i in range(len(benchmarks)):
    print "echo -e '\033[0;31m#########################Starting Benchmark ("+benchmarks[i]+")#########################\033[0m'"
    for x in range(len(num_sets)):
        for y in range(len(line_sizes)):
            for z in range(len(associativity)):
                print "echo Starting "+benchmarks[i]+" benchmark with Number of sets="+str(num_sets[x])+" Line Size="+str(line_sizes[y])+" and Associativity of "+str(associativity[z])+". Total Cache size is "+str(num_sets[x]*line_sizes[y])+" Bytes"
                print "././../../simplesim-3.0/sim-outorder -cache:il1 il1:8:64:4:l -cache:dl1 dl1:"+str(num_sets[x])+":"+str(line_sizes[y])+":"+str(associativity[z])+":l -cache:il1lat 1 -cache:dl1lat 1 -mem:lat 80 2 -issue:inorder -redir:sim Results/fft_"+str(num_sets[x])+"_"+str(line_sizes[y])+"_"+str(associativity[z])+".txt  ././../../MiBench/fft 4 4096"
                # print  benchmarks[i] + "_" + str(num_sets[x]) + "_" + str(line_sizes[y]) + "_" + str(associativity[z])
benchmarks = ["fftinv"]
for i in range(len(benchmarks)):
    print "echo -e '\033[0;31m#########################Starting Benchmark ("+benchmarks[i]+")#########################\033[0m'"
    for x in range(len(num_sets)):
        for y in range(len(line_sizes)):
            for z in range(len(associativity)):
                print "echo Starting "+benchmarks[i]+" benchmark with Number of sets="+str(num_sets[x])+" Line Size="+str(line_sizes[y])+" and Associativity of "+str(associativity[z])+". Total Cache size is "+str(num_sets[x]*line_sizes[y])+" Bytes"
                print "././../../simplesim-3.0/sim-outorder -cache:il1 il1:8:64:4:l -cache:dl1 dl1:"+str(num_sets[x])+":"+str(line_sizes[y])+":"+str(associativity[z])+":l -cache:il1lat 1 -cache:dl1lat 1 -mem:lat 80 2 -issue:inorder -redir:sim Results/fftinv_"+str(num_sets[x])+"_"+str(line_sizes[y])+"_"+str(associativity[z])+".txt  ././../../MiBench/fft 4 8 -i"
                # print  benchmarks[i] + "_" + str(num_sets[x]) + "_" + str(line_sizes[y]) + "_" + str(associativity[z])
benchmarks = ["qsortsmall"]
for i in range(len(benchmarks)):
    print "echo -e '\033[0;31m#########################Starting Benchmark ("+benchmarks[i]+")#########################\033[0m'"
    for x in range(len(num_sets)):
        for y in range(len(line_sizes)):
            for z in range(len(associativity)):
                print "echo Starting "+benchmarks[i]+" benchmark with Number of sets="+str(num_sets[x])+" Line Size="+str(line_sizes[y])+" and Associativity of "+str(associativity[z])+". Total Cache size is "+str(num_sets[x]*line_sizes[y])+" Bytes"
                print "././../../simplesim-3.0/sim-outorder -cache:il1 il1:8:64:4:l -cache:dl1 dl1:"+str(num_sets[x])+":"+str(line_sizes[y])+":"+str(associativity[z])+":l -cache:il1lat 1 -cache:dl1lat 1 -mem:lat 80 2 -issue:inorder -redir:sim Results/qsortsmall_"+str(num_sets[x])+"_"+str(line_sizes[y])+"_"+str(associativity[z])+".txt  ././../../MiBench/qsort_small ././../../MiBench/Benchmarks/automotive/qsort/input_small.dat"
                # print  benchmarks[i] + "_" + str(num_sets[x]) + "_" + str(line_sizes[y]) + "_" + str(associativity[z])
benchmarks = ["rawcaudio"]
for i in range(len(benchmarks)):
    print "echo -e '\033[0;31m#########################Starting Benchmark ("+benchmarks[i]+")#########################\033[0m'"
    for x in range(len(num_sets)):
        for y in range(len(line_sizes)):
            for z in range(len(associativity)):
                print "echo Starting "+benchmarks[i]+" benchmark with Number of sets="+str(num_sets[x])+" Line Size="+str(line_sizes[y])+" and Associativity of "+str(associativity[z])+". Total Cache size is "+str(num_sets[x]*line_sizes[y])+" Bytes"
                print "././../../simplesim-3.0/sim-outorder -cache:il1 il1:8:64:4:l -cache:dl1 dl1:"+str(num_sets[x])+":"+str(line_sizes[y])+":"+str(associativity[z])+":l -cache:il1lat 1 -cache:dl1lat 1 -mem:lat 80 2 -issue:inorder -redir:sim Results/rawcaudio_"+str(num_sets[x])+"_"+str(line_sizes[y])+"_"+str(associativity[z])+".txt  ././../../MiBench/rawcaudio < ././../../MiBench/Benchmarks/telecomm/adpcm/data/small.pcm > Results/rawcaudio_"+str(num_sets[x])+"_"+str(line_sizes[y])+"_"+str(associativity[z])+".dat"
                # print  benchmarks[i] + "_" + str(num_sets[x]) + "_" + str(line_sizes[y]) + "_" + str(associativity[z])
benchmarks = ["rijndaelencode"]
for i in range(len(benchmarks)):
    print "echo -e '\033[0;31m#########################Starting Benchmark ("+benchmarks[i]+")#########################\033[0m'"
    for x in range(len(num_sets)):
        for y in range(len(line_sizes)):
            for z in range(len(associativity)):
                print "echo Starting "+benchmarks[i]+" benchmark with Number of sets="+str(num_sets[x])+" Line Size="+str(line_sizes[y])+" and Associativity of "+str(associativity[z])+". Total Cache size is "+str(num_sets[x]*line_sizes[y])+" Bytes"
                print "././../../simplesim-3.0/sim-outorder -cache:il1 il1:8:64:4:l -cache:dl1 dl1:"+str(num_sets[x])+":"+str(line_sizes[y])+":"+str(associativity[z])+":l -cache:il1lat 1 -cache:dl1lat 1 -mem:lat 80 2 -issue:inorder -redir:sim Results/rijndaelencode_"+str(num_sets[x])+"_"+str(line_sizes[y])+"_"+str(associativity[z])+".txt  ././../../MiBench/rijndael ././../../MiBench/Benchmarks/security/rijndael/input_small.asc Results/output_small_"+str(num_sets[x])+"_"+str(line_sizes[y])+"_"+str(associativity[z])+".enc e 1234567890abcdeffedcba09876543211234567890abcdeffedcba0987654321"
                # print  benchmarks[i] + "_" + str(num_sets[x]) + "_" + str(line_sizes[y]) + "_" + str(associativity[z])
benchmarks = ["rijndaeldecode"]
for i in range(len(benchmarks)):
    print "echo -e '\033[0;31m#########################Starting Benchmark ("+benchmarks[i]+")#########################\033[0m'"
    for x in range(len(num_sets)):
        for y in range(len(line_sizes)):
            for z in range(len(associativity)):
                print "echo Starting "+benchmarks[i]+" benchmark with Number of sets="+str(num_sets[x])+" Line Size="+str(line_sizes[y])+" and Associativity of "+str(associativity[z])+". Total Cache size is "+str(num_sets[x]*line_sizes[y])+" Bytes"
                print "././../../simplesim-3.0/sim-outorder -cache:il1 il1:8:64:4:l -cache:dl1 dl1:"+str(num_sets[x])+":"+str(line_sizes[y])+":"+str(associativity[z])+":l -cache:il1lat 1 -cache:dl1lat 1 -mem:lat 80 2 -issue:inorder -redir:sim Results/rijndaeldecode_"+str(num_sets[x])+"_"+str(line_sizes[y])+"_"+str(associativity[z])+".txt  ././../../MiBench/rijndael Results/output_small_"+str(num_sets[x])+"_"+str(line_sizes[y])+"_"+str(associativity[z])+".enc Results/output_small_"+str(num_sets[x])+"_"+str(line_sizes[y])+"_"+str(associativity[z])+".dec d 1234567890abcdeffedcba09876543211234567890abcdeffedcba0987654321"
                # print  benchmarks[i] + "_" + str(num_sets[x]) + "_" + str(line_sizes[y]) + "_" + str(associativity[z])
benchmarks = ["searchlarge"]
for i in range(len(benchmarks)):
    print "echo -e '\033[0;31m#########################Starting Benchmark ("+benchmarks[i]+")#########################\033[0m'"
    for x in range(len(num_sets)):
        for y in range(len(line_sizes)):
            for z in range(len(associativity)):
                print "echo Starting "+benchmarks[i]+" benchmark with Number of sets="+str(num_sets[x])+" Line Size="+str(line_sizes[y])+" and Associativity of "+str(associativity[z])+". Total Cache size is "+str(num_sets[x]*line_sizes[y])+" Bytes"
                print "././../../simplesim-3.0/sim-outorder -cache:il1 il1:8:64:4:l -cache:dl1 dl1:"+str(num_sets[x])+":"+str(line_sizes[y])+":"+str(associativity[z])+":l -cache:il1lat 1 -cache:dl1lat 1 -mem:lat 80 2 -issue:inorder -redir:sim Results/searchlarge_"+str(num_sets[x])+"_"+str(line_sizes[y])+"_"+str(associativity[z])+".txt  ././../../MiBench/search_large"
                # print  benchmarks[i] + "_" + str(num_sets[x]) + "_" + str(line_sizes[y]) + "_" + str(associativity[z])
benchmarks = ["sha"]
for i in range(len(benchmarks)):
    print "echo -e '\033[0;31m#########################Starting Benchmark ("+benchmarks[i]+")#########################\033[0m'"
    for x in range(len(num_sets)):
        for y in range(len(line_sizes)):
            for z in range(len(associativity)):
                print "echo Starting "+benchmarks[i]+" benchmark with Number of sets="+str(num_sets[x])+" Line Size="+str(line_sizes[y])+" and Associativity of "+str(associativity[z])+". Total Cache size is "+str(num_sets[x]*line_sizes[y])+" Bytes"
                print "././../../simplesim-3.0/sim-outorder -cache:il1 il1:8:64:4:l -cache:dl1 dl1:"+str(num_sets[x])+":"+str(line_sizes[y])+":"+str(associativity[z])+":l -cache:il1lat 1 -cache:dl1lat 1 -mem:lat 80 2 -issue:inorder -redir:sim Results/sha_"+str(num_sets[x])+"_"+str(line_sizes[y])+"_"+str(associativity[z])+".txt  ././../../MiBench/sha ././../../MiBench/Benchmarks/security/sha/input_small.asc"
                # print  benchmarks[i] + "_" + str(num_sets[x]) + "_" + str(line_sizes[y]) + "_" + str(associativity[z])
#!/usr/bin/python
import csv

# Created by David Akre 2/6/17
#
# Description: Simple python script that takes in txt output from bash 
# script created by Jon Anderson, snags IPC and dCache Miss Rates from 
# the benchmark under test, and transforms the output into a simple csv file
# to be used for analytics
#
# Inputs: N/A to func, but requires outputs from bash script
#
# Outputs: N/A from func, but creates csv files with IPC/dCache miss rates 
# for the benchmark under test with a particular configuration
#
def csvify():
    # Forward declarations
    dir = "./Results/"
    benchmarks = ["crc", "dijkstrasmall", "fft","fftinv", "qsortsmall", "rawcaudio", "rijndaeldecode","rijndaelencode", "searchlarge", "sha"]
    line_sizes = [16, 32, 64]
    num_sets = [8, 16, 32, 64, 128, 256, 512]
    associativity = [1, 2, 4]
    out_ext = ".csv"
    in_ext = ".txt"
    ipc_str = "sim_IPC"
    ipc_desc = "# instructions per cycle"
    mrate_str = "dl1.miss_rate"
    mrate_desc = "# miss rate (i.e., misses/ref)"
    ipc = ""
    mr = ""
    cols = ["IPC", "Miss_Rate"]

    # Iterate through outputs generated from bashrc, and grab IPC/dCache Miss Rates
    for i in range(len(benchmarks)):
	for x in range(len(num_sets)):
            for y in range(len(line_sizes)):
                for z in range(len(associativity)):
		    flag = True
                    in_file = dir + benchmarks[i] + "_" + str(num_sets[x]) + "_" + str(line_sizes[y]) + "_" + str(associativity[z]) + in_ext
		    out_file = dir + benchmarks[i] + "_" + str(num_sets[x]) + "_" + str(line_sizes[y]) + "_" + str(associativity[z]) + out_ext
		    try:
		        with open(in_file) as inf:
			    for line in inf:
				if ipc_str in line:
				    ipc = line.replace(ipc_str, "").replace(ipc_desc, "").strip()
		 		elif mrate_str in line:
				    mr = line.replace(mrate_str, "").replace(mrate_desc, "").strip()
		 			
		    except:
		        #print "File: " + in_file + "-- could not be found"
			flag = False
		        pass

		    try:
			if flag:
		            with open(out_file, "wb") as outf:
				print "Creating csv file: " + out_file
			        writer = csv.writer(outf)
			        writer.writerows([cols, [ipc, mr]])

		    except:
			print "File: " + out_file + "-- could not be created"
			raise


csvify()

#!/usr/bin/env python

# Author: David Akre
# Date: 3/18/2017
#
# Description: This script takes in an executable benchmark and other arguments
# to run lttng properly

import os
import subprocess
import sys
import time
from argparse import ArgumentParser

# Main method to invoke lttng traces
def trace_process():
  in_file, filt, type_of_trace, out_file, opts = parse_inputs()

  create_cmd = "lttng create " + str(in_file) + "-" + str(type_of_trace)
  print create_cmd
  if type_of_trace == "userspace":
    # Part 1 Setup trace
    print "Setting up lttng trace in user space"
    subprocess.call(create_cmd, shell=True)
    subprocess.call("lttng enable-event -u --all", shell=True)

  elif type_of_trace == "kernel":
    # Part 1 Setup trace (always filter by pid)
    print "Setting up lttng trace in kernel"

    if filt != None:
      subprocess.call(create_cmd, shell=True)
      subprocess.call("lttng enable-event -k --all", shell=True)
      subprocess.call("lttng add-context -k -t pid -t " + str(filt), shell=True)
    else:
      subprocess.call(create_cmd, shell=True)
      subprocess.call("lttng enable-event -k --all", shell=True)
  
  else:
    print "ERROR: Unsupported type, run -h for help"
    sys.exit()
 
  # Part 2 Start lttng trace
  print "Starting lttng trace"
  subprocess.call("lttng start", shell=True)
  if opts == None:
    subprocess.call("sudo ./../../src/user_space/" + str(in_file) + "/" + str(in_file), shell=True)
  else:
    subprocess.call("sudo ./../../src/user_space/" + str(in_file) + "/" + str(in_file) + " " + str(opts), shell=True)

  # Part 3 Stop lttng trace
  subprocess.call("lttng stop", shell=True)
  subprocess.call("lttng destroy", shell=True)

  # Part 4 Redirect output to csv file & clean up
  print "Stopping lttng trace and starting up babeltrace to redirect tracing output to csv"
  subprocess.call("babeltrace ~/lttng-traces/* > " + "./lttng_sim_outputs/" + out_file + ".csv", shell=True)
  print "Cleaning up work area"
  subprocess.call("sudo rm -rf ~/lttng-traces/*", shell=True)
  subprocess.call("sudo rm *.out", shell=True)

def parse_inputs():
  parser = ArgumentParser()
  parser.add_argument("-i", "--input", help="Input executable file (e.g. fib)")
  parser.add_argument("-t", "--type", help="Available tracing types are: userspace or kernel")
  parser.add_argument("-f", "--filter", help = "Filter options to be passed into lttng (e.g. pid)")
  parser.add_argument("-o", "--output", help="Output file name")
  parser.add_argument("-opt", "--options", help="Options to executable")
  #parser.add_argument("-d", "--destroy", help= "Destroy previous trace session")

  try:
    args = parser.parse_args()
  except:
    print "ERROR: Not enough input arguments provided... run -h on this script for help"
    sys.exit()

  '''
  if args.destroy != None:
    print "Attempting to destroy lttng trace session"
    subprocess.call("lttng destroy " + str(args.destroy), shell=True)
    sys.exit()
  '''

  if args.input == None or args.type == None:
    print "ERROR: Not enough input arguments provided... run -h on this script for help"
    sys.exit()

  if args.output == None:
    print "ERROR: Must provide an output file name without an extension"
    sys.exit()

  return args.input,  args.filter, args.type, args.output, args.options

trace_process()


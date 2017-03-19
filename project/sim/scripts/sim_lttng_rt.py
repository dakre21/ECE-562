#!/usr/bin/env python

import os
import subprocess
import sys
import time
from argparse import ArgumentParser

def trace_process():
  in_file, filt = parse_inputs()

  pwd = ""
  subprocess.call("pwd > tmp", shell=True)
  with open("tmp") as tmp:
    for line in tmp:
      pwd = line 

  print "Settuping up lttng trace in user space"
  #subprocess.call("lttng create " + str(in_file) + " --output " + str(pwd) + "/simulations/lttng", shell=True)
  subprocess.call("lttng create " + str(in_file), shell=True)
  subprocess.call("lttng enable-event -u --all", shell=True)
  #subprocess.call("lttng enable-event -k --all", shell=True)
  #subprocess.call("lttng add-context -k -t " + str(filt), shell=True)
  #subprocess.call("lttng track -k `pidof " + str(in_file) + "`", shell=True)

  print "Starting lttng trace"
  subprocess.call("lttng start", shell=True)
  subprocess.call("./../../src/user_space/" + str(in_file) + "/" + str(in_file), shell=True)
  subprocess.call("lttng stop", shell=True)
  subprocess.call("lttng destroy", shell=True)
  subprocess.call("rm tmp", shell=True)

  print "Stopping lttng trace"
    
def parse_inputs():
  parser = ArgumentParser()
  parser.add_argument("-i", "--input", help="Input executable file (e.g. fib)")
  parser.add_argument("-f", "--filter", help = "Filter options to be passed into lttng (e.g. pid)")
  parser.add_argument("-d", "--destroy", help= "Destroy previous trace session")

  try:
    args = parser.parse_args()
  except:
    print "ERROR: Not enough input arguments provided... run -h on this script for help"
    sys.exit()

  if args.destroy != None:
    print "Attempting to destroy lttng trace session"
    subprocess.call("lttng destroy " + str(args.destroy), shell=True)
    sys.exit()


  if args.input == None or args.filter == None:
    print "ERROR: Not enough input arguments provided... run -h on this script for help"
    sys.exit()

  return args.input,  args.filter

trace_process()


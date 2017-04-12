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

def capture_syslogs():
  pid, out_file, target = parse_inputs()

  if target == "tegra":
    subprocess.call("grep 'PID " + str(pid) + "' /var/log/syslog > ../tegra_sim_outputs/" + str(out_file) + ".csv", shell=True)
    print "Output of sim file lives in ../tegra_sim_outputs/" + str(out_file) + ".csv"
  elif target == "pi":
    subprocess.call("grep 'PID " + str(pid) + "' /var/log/syslog > ../pi_sim_outputs/" + str(out_file) + ".csv", shell=True)
    print "Output of sim file lives in ../pi_sim_outputs/" + str(out_file) + ".csv"
  else:
    print "ERROR: Input target is invalid.. run -h for help"

def parse_inputs():
  print "Remember to run binary before running this script.. it should be executed separately"
  parser = ArgumentParser()
  parser.add_argument("-p", "--pid", help="Input process identifier")
  parser.add_argument("-o", "--output", help="Specify output file")
  parser.add_argument("-t", "--target", help="Specify a target== tegra or pi")

  try:
    args = parser.parse_args()
  except:
    print "ERROR: Not enough input arguments provided... run -h on this script for help"
    sys.exit()

  if args.output == None or args.target == None or args.pid == None:
    print "ERROR: Not enough input arguments provided... run -h on this script for help"
    sys.exit()

  return args.pid, args.output, args.target

capture_syslogs()

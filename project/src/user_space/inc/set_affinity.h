#include <sched.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <stdbool.h>
#include <unistd.h>
#include <sys/wait.h>
#include <sys/sysinfo.h>

bool setup_affinity(int req_cpus)
{
  cpu_set_t set;
  CPU_ZERO(&set); // Clear cpu set
  int num_of_cpus = get_nprocs_conf(); // Get & set the number of available CPUs

  if (req_cpus > num_of_cpus)
  {
    printf("Error: Requested number of CPUs that is greater than the amount available\n");
    return false;
  }

  int i = 0;

  // Add all available cpus to set  
  for (; i < req_cpus; i++)
  {
    CPU_SET(i, &set); // Add CPU to set
  }

  // Use all available CPUs for current process
  if (sched_setaffinity(getpid(), sizeof(set), &set) == -1)
  {
    printf("ERROR: Could not set affinity properly.. check if you are running as root\n");  
    return false;
  }

  return true;
}

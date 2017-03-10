#include <sched.h>
#include <sys/sysinfo.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>
#include <pthread.h>
#include <time.h>

struct timespec start_time = {0, 0};
struct timespec stop_time = {0, 0};
static struct timespec sleep_time = {0, 10000000}; // 10^7ns or 10ms
static struct timespec remaining_time = {0, 0};
uint32_t fib = 0, fib0 = 0, fib1 = 1;

int calc_delta()
{
  int diff = stop_time.tv_nsec - start_time.tv_nsec;

  // Sanity check 
  if (diff < 0)
  {
    diff = 1000000000 + diff;
  }

  return diff;
}

void calc_fib()
{
  int i = 0;
  int time = 0;

  for (; i < 30; i++)
  {
    clock_gettime(CLOCK_REALTIME, &start_time);
    nanosleep(&sleep_time, &remaining_time);
    fib = fib0 + fib1;
    fib0 = fib1;
    fib1 = fib;
    clock_gettime(CLOCK_REALTIME, &stop_time);
    time = calc_delta();
    printf("Fib num = %u at position %d and total process took %d\n", fib, i, time);
  }
}

bool set_up_affinity()
{
  cpu_set_t set;
  CPU_ZERO(&set); // Clear cpu set
  int num_of_cpus = get_nprocs_conf(); // Get & set the number of available CPUs

  int i = 0;

  // Set CPU 0 to CPU Set
  CPU_SET(0, &set);

  bool rc = true;

  // Lock processot to CPU 0
  if (sched_setaffinity(getpid(), sizeof(set), &set) == -1)
  {
    printf("ERROR: Could not set affinity properly.. check if you are running as root\n");  
    rc = false;
  }

  return rc;
}

int main (int argc, char *argv[])
{
  // Set 1 -- Setup CPU affinity
  if (set_up_affinity())
  {
    calc_fib();
  }

  exit(0);
}

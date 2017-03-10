#include <sched.h>
#include <sys/sysinfo.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>
#include <pthread.h>
#include <time.h>
#include <set_affinity.h>
#include <string.h>

#define NUM_FIB_CYCLES 30

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

// TODO: Maybe take out sleep to get more accurate results
void calc_fib()
{
  int i = 0;
  int time = 0;

  for (; i < NUM_FIB_CYCLES; i++)
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

/*
1) high priority multicore smp
2) normal priority multicore smp
3) high priority single core smp
4) normal priority single core smp
-- DEFAULT is SMP and whatever core Linux wants the process to run on
*/
int main (int argc, char *argv[])
{
  int num_procs = get_nprocs_conf();
  printf("%s argv\n", argv[1]);

  // TODO: Setup pthread env
  if (argv[1] == NULL)
  {
    // Do nothing -- default case
  }
  else if (strcmp(argv[1], "1") == 0)
  {
  }    
  else if (strcmp(argv[1], "2") == 0)
  {
  }
  else if (strcmp(argv[1], "3") == 0)
  {
    num_procs = 1;
  }
  else if (strcmp(argv[1], "4") == 0)
  {
    num_procs = 1;
  }

  if (setup_affinity(num_procs))
  {
    calc_fib();
  }

  exit(0);
}

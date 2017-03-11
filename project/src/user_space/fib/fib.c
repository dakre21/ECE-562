#include <set_affinity.h>
#include <calc_delta.h>
#include <posix_thread.h>
#include <stall_cpu.h>
#include <string.h>

#define NUM_FIB_CYCLES 50

struct timespec start_time = {0, 0};
struct timespec stop_time = {0, 0};
//static struct timespec sleep_time = {0, 10000000}; // 10^7ns or 10ms
//static struct timespec remaining_time = {0, 0};
uint32_t fib = 0, fib0 = 0, fib1 = 1;

void calc_fib()
{
  int i = 0;
  int time = 0;

  for (; i < NUM_FIB_CYCLES; i++)
  {
    clock_gettime(CLOCK_REALTIME, &start_time);
    //nanosleep(&sleep_time, &remaining_time);
    fib = fib0 + fib1;
    fib0 = fib1;
    fib1 = fib;
    clock_gettime(CLOCK_REALTIME, &stop_time);
    time = calc_delta(&start_time, &stop_time);
    // Fib num will exceed what int can actually store... so ignore result we can about time
    printf("INFO: Fib num = %u at position %d and total process took %d\n", fib, i, time);
  }
}

void* calc_fib_entry(void* thread_id)
{
  printf("Thread %d calc fib\n", *(int*)thread_id);
  calc_fib();  

  return thread_id;
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
  bool hprio = false;
  
  if (argv[1] == NULL)
  {
    printf("INFO: Calculating default fib sequence\n");
  }
  else if (strcmp(argv[1], "1") == 0)
  {
    printf("INFO: Calculating fib sequence with process at high priority in a multicore environment\n");
    hprio = true;
  }    
  else if (strcmp(argv[1], "2") == 0)
  {
    printf("INFO: Calculating fib sequence with process at normal priority in a multicore environment\n");
  }
  else if (strcmp(argv[1], "3") == 0)
  {
    printf("INFO: Calculating fib sequence with process at high priority in a unicore environment\n");
    hprio = true;
    num_procs = 1;
  }
  else if (strcmp(argv[1], "4") == 0)
  {
    printf("INFO: Calculating fib sequence with process at normal priority in a uniicore environment\n");
    num_procs = 1;
  }
  
  if (setup_affinity(num_procs) == false)
  {
    exit(-1);
  }

  if (hprio == true)
  {
    if (create_pthreads(1, calc_fib_entry) == false)
    {
      exit(-1);
    }

    if (kill_pthreads(1) == false)
    {
      exit(-1);
    }
  }
  else
  {
    calc_fib();
  }

  exit(0);
}

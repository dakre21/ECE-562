#include <set_affinity.h>
#include <calc_delta.h>
#include <posix_thread.h>
#include <stall_cpu.h>
#include <string.h>
#include <cpu_stats.h>

#define TRACEPOINT_CREATE_PROBES
#define TRACEPOINT_DEFINE
#include <trace.h>

/*
 * Author: David Akre
 * Date: 3/11/2017
 *
 * Description: fib is a simple benchmark that will calculate the fibonacci sequence for 
 * a defined number of cycles. In the int main function, the user can give input to what 
 * kind of configuration this process should execute under.
 *
 */

#define NUM_FIB_CYCLES 1000

// Fwd declaration of vars
struct timespec start_time = {0, 0};
struct timespec stop_time = {0, 0};
uint32_t fib = 0, fib0 = 0, fib1 = 1, pid = 0;

// Function to calculate fibonacci sequence
// Instruction count (done by statically looking through asm code):
// 1. Calc delta = 5 instructions
// 2. Get cpu cycles = 7 instructions
// 3. Clock gettime = 2 instructions
// 4. Fib sequence = 5 instructions
// 5. Extra ALU ops = 5 instructions
// 6. Tracepoint = 184 instructions (use this instead of printf because it preempts 
// the processor and adds significant latency due to the context switch)
// Total instructions for the loop = 208
void calc_fib()
{
  int i = 0;
  int time = 0;
  unsigned int cycles = 0;
  unsigned int prev_cycles = 0;
  unsigned int instr_count = 208;
  float ipc = 0;
  float cpi = 0;

  for (; i < NUM_FIB_CYCLES; i++)
  {
    clock_gettime(CLOCK_REALTIME, &start_time);
    fib = fib0 + fib1;
    fib0 = fib1;
    fib1 = fib;

    clock_gettime(CLOCK_REALTIME, &stop_time);
    time = calc_delta(&start_time, &stop_time);
    cycles = get_cpu_cycles();

    ipc = (float)(instr_count) / ((float)(cycles) - (float)(prev_cycles));
    cpi = ((float)(cycles) - (float)(prev_cycles)) / (float)(instr_count);

    // Fib num will exceed what int can actually store... so ignore result we can about time
    // NOTE: CPI and IPC (this is per process not overall CPU instructions executed) 
    tracepoint(benchmark, tracepoint, "Fib iteration metrics: execution time, cpu cycles, IPC, and CPI", 
            pid, (int)time, (cycles - prev_cycles), ipc, cpi);
    //printf("Fib iteration metrics: execution time %d, cpu cycles %u, IPC %f, and CPI %f\n", time, (cycles - prev_cycles), ipc, cpi);
    prev_cycles = cycles;
  }
}

// Function pointer for pthreads to execute at (just calls calc_fib())
void* calc_fib_entry(void* thread_id)
{
  calc_fib();  

  if (kill_pthreads(1) == false)
  {
    exit(-1);
  }

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
  pid = getpid();
  printf("FIB pid %d\n", pid);
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
  }
  else
  {
    calc_fib();
  }

  exit(0);
}

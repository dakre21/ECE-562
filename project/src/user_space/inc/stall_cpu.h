#include <time.h>

/*
 * Author: David Akre
 * Date: 3/11/2017
 *
 * Description: stall_cpu is an interface that will sleep the current calling thread, 
 * thus stalling its cpu cycles and allowing another thread to preempt it.
 *
 */

// Description: nanosleep the current calling thread
//
// Inputs:
// - time (uint)
//
// Outputs:
// - N/A
void stall_cpu(unsigned int time)
{
  if (time <= 0)
  {
    return;
  }

  struct timespec sleep_time = {0, time};
  struct timespec remaining_time = {0, 0};

  nanosleep(&sleep_time, &remaining_time);
}

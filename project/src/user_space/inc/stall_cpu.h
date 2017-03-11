#include <time.h>

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

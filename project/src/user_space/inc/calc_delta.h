#include <time.h>

int calc_delta(timespec* start_time, timespec* stop_time)
{
  int diff = (*stop_time).tv_nsec - (*start_time).tv_nsec;

  // Sanity check 
  if (diff < 0)
  {
    diff = 1000000000 + diff;
  }

  return diff;
}


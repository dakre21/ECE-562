/* Author: David Akre
 * Date: 3/11/2017
 *
 * Description: calc_delta is an interface that will give a timestamp of the
 * total time it takes for an algorithm/program takes to execute.
 *
 */

#include <time.h>

// Description: Calculate the delta time
//
// Inputs:
// - timespec start_time
// - timespec stop_time
//
// Outputs:
// - difference (int)
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


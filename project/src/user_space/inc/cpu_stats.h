/* Author: David Akre
 * Date: 3/19/2017
 *
 * Description: Header function to be used in a generic manner to add
 * tracing to c/c++ benchmarks and executed against the sim_lttng_rt.py 
 * script
 */

#include <stdint.h>

// Get cpu cycles from cpu time stamp counter
uint64_t get_cpu_cycles()
{
    unsigned int lo, hi;
    __asm__ __volatile__("rdtsc" : "=a" (lo), "=d" (hi));
    return ((uint64_t)hi << 32 | lo);
}


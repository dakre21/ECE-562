/* Author: David Akre
 * Date: 3/19/2017
 *
 * Description: Header function to be used in a generic manner to add
 * tracing to c/c++ benchmarks and executed against the sim_lttng_rt.py 
 * script
 */

#ifdef __x86_64__ || __amd64__
#undef TRACEPOINT_PROVIDER
#define TRACEPOINT_PROVIDER benchmark

#undef TRACEPOINT_INCLUDE
#define TRACEPOINT_INCLUDE "./trace.h"

#if !defined(_TRACE_H) || defined(TRACEPOINT_HEADER_MULTI_READ)
#define _TRACE_H

#include <lttng/tracepoint.h>

TRACEPOINT_EVENT(
    benchmark,
    tracepoint,
    TP_ARGS(
        char*, trace_description,
        unsigned int, pid,
        int, timestamp,
        unsigned int, cpu_cycles,
        float, cpi,
        float, ipc
    ),
    TP_FIELDS(
        ctf_string(trace_description_field, trace_description)
        ctf_integer(unsigned int, pid_field, pid)
        ctf_integer(int, timestamp_field, timestamp)
        ctf_integer(unsigned int, cpu_cycles_field, cpu_cycles)
        ctf_float(float, cpi_field, cpi)
        ctf_float(float, ipc_field, ipc)
    )
)

#endif

#include <lttng/tracepoint-event.h>
#else
#endif


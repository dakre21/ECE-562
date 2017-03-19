#undef TRACEPOINT_PROVIDER
#define TRACEPOINT_PROVIDER benchmark

#undef TRACEPOINT_INCLUDE
#define TRACEPOINT_INCLUDE "./trace.h"

#if !defined(_TRACE_H) || defined(TRACEPOINT_HEADER_MULTI_READ)
#define _TRACE_H

#include <lttng/tracepoint.h>

TRACEPOINT_EVENT(
    benchmark,
    my_tracepoint,
    TP_ARGS(
        int, my_timestamp_arg,
        char*, my_trace_description_arg
    ),
    TP_FIELDS(
        ctf_integer(int, my_timestamp_field, my_timestamp_arg)
        ctf_string(my_trace_description_field, my_trace_description_arg)
    )
)

#endif

#include <lttng/tracepoint-event.h>

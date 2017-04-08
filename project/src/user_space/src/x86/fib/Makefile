INCLUDE_DIRS =./../../../inc
LIB_DIRS =./../../../lib/x86
CC=g++

CDEFS=
CFLAGS= -O3 -w -Wall -ggdb3 -O3 -D__DEBUG -pg -g $(CDEFS) -I${INCLUDE_DIRS} -L${LIB_DIRS} -lm 
LIBS= -lrt -lpthread -ldl -llttng-ust
CPPLIBS= -L/usr/lib 

HFILES= set_affinity.h calc_delta.h posix_thread.h stall_cpu.h trace.h cpu_stats.h
CFILES1= fib.c 
CFILES2= fib_gem5.c 
CPPFILES= 
LINK= 

SRCS1= ${HFILES} ${CFILES1}
SRCS2= ${HFILES} ${CFILES2}

CPPOBJS= ${CPPFILES:.cpp=.o}

all:	 fib fib_gem5

clean:
		-rm -f *.o *.d fib fib_gem5

fib: fib.o
		$(CC) $(LDFLAGS) $(CFLAGS) -o $@ $(CFILES1) $(LIBS)

fib_gem5: fib_gem5.o 
		$(CC) $(LDFLAGS) $(CFLAGS) -static -o $@ $(CFILES2) $(LIBS) 

distclean:
		-rm -f *.o *.d

depend:

.c.o:
		$(CC) $(CFLAGS) -c $<

.cpp.o:
	$(CC) $(CFLAGS) -c $<

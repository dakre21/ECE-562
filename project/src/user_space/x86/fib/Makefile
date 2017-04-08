INCLUDE_DIRS =./../../inc
LIB_DIRS =./../lib
CC=g++

CDEFS=
CFLAGS= -O3 -Wall -pg -g $(CDEFS) -I${INCLUDE_DIRS} -L${LIB_DIRS}
LIBS= -lrt -lpthread -ldl -llttng-ust
CPPLIBS= -L/usr/lib 

HFILES= set_affinity.h calc_delta.h posix_thread.h stall_cpu.h trace.h cpu_stats.h
CFILES= fib.c 
CPPFILES= 
LINK= 

SRCS= ${HFILES} ${CFILES}

CPPOBJS= ${CPPFILES:.cpp=.o}

all:	 fib

clean:
	-rm -f *.o *.d fib

fib: fib.o 
	$(CC) $(LDFLAGS) $(CFLAGS) -o $@ $(CFILES) $(LIBS)

distclean:
	-rm -f *.o *.d

depend:

.c.o:
	$(CC) $(CFLAGS) -c $<

.cpp.o:
	$(CC) $(CFLAGS) -c $<

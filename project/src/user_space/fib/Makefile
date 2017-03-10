INCLUDE_DIRS = 
LIB_DIRS = 
CC=g++

CDEFS=
CFLAGS= -O3 -Wall -pg -g $(INCLUDE_DIRS) $(CDEFS) 
LIBS= -lrt -lpthread
CPPLIBS= -L/usr/lib 

HFILES= 
CFILES= 
CPPFILES= 
LINK= 

CFILES1 = fib_high_prio_smp.c
CFILES2 = fib_norm_prio_smp.c
CFILES3 = fib_high_prio_smp_locked.c
CFILES4 = fib_norm_prio_smp_locked.c

SRCS= ${HFILES} ${CFILES}

COBJS1= ${CFILES1}
COBJS2= ${CFILES2}
COBJS3= ${CFILES3}
COBJS4= ${CFILES4}

CPPOBJS= ${CPPFILES:.cpp=.o}

all:	 fib_high_prio_smp fib_norm_prio_smp fib_high_prio_smp_locked fib_norm_prio_smp_locked

clean:
	-rm -f *.o *.d fib_high_prio_smp fib_norm_prio_smp fib_high_prio_smp_locked fib_norm_prio_smp_locked

fib_high_prio_smp: fib_high_prio_smp.o
	$(CC) $(LDFLAGS) $(CFLAGS) -o $@ $(COBJS1) $(LIBS)

fib_norm_prio_smp: fib_norm_prio_smp.o
	$(CC) $(LDFLAGS) $(CFLAGS) -o $@ $(COBJS2) $(LIBS)

fib_high_prio_smp_locked: fib_high_prio_smp_locked.o
	$(CC) $(LDFLAGS) $(CFLAGS) -o $@ $(COBJS3) $(LIBS)

fib_norm_prio_smp_locked: fib_norm_prio_smp_locked.o
	$(CC) $(LDFLAGS) $(CFLAGS) -o $@ $(COBJS4) $(LIBS)

distclean:
	-rm -f *.o *.d

depend:

.c.o:
	$(CC) $(CFLAGS) -c $<

.cpp.o:
	$(CC) $(CFLAGS) -c $<

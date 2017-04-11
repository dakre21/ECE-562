/* Author: David Akre
 * Date: 4/7/2017
 *
 * Description: Interface for getting cpu stats (namely cycles) on x86/ARM
 */

#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#ifdef __x86_64__
// INFO:
// Below is assembly code based on the x86 architecture
// Get cpu cycles from cpu time stamp counter - x86
uint64_t get_cpu_cycles()
{
    unsigned int lo, hi;
    __asm__ __volatile__("rdtsc" : "=a" (lo), "=d" (hi));
  return ((uint64_t)hi << 32 | lo);
}

#else

typedef struct
{
    uint64_t ccnt;
    uint64_t event0;
    uint64_t event1;
    uint64_t event2;
} pmu_counters;

// Get cpu cycles from ARM PMU counters
void get_cpu_cycles(pmu_counters* counters)
{
    uint32_t lo, hi;
    // Read ccnt
    __asm__ __volatile__("mrs %0, pmccntr_el0" : "=r" (counters->ccnt));

    // Read event counters
   /* __asm__ __volatile__("mrs %0, pmevcntr0_el0" : "=r" (lo));
    __asm__ __volatile__("ISB");
    __asm__ __volatile__("mrs %0, pmevcntr1_el0" : "=r" (hi));
    __asm__ __volatile__("ISB");
    counters->event0 = ((uint64_t)hi << 32 | lo);
    
    __asm__ __volatile__("mrs %0, pmevcntr2_el0" : "=r" (lo));
    __asm__ __volatile__("ISB");
    __asm__ __volatile__("mrs %0, pmevcntr3_el0" : "=r" (hi));
    __asm__ __volatile__("ISB");
    counters->event1 = ((uint64_t)hi << 32 | lo);
    
    __asm__ __volatile__("mrs %0, pmevcntr4_el0" : "=r" (lo));
    __asm__ __volatile__("ISB");
    __asm__ __volatile__("mrs %0, pmevcntr5_el0" : "=r" (hi));
    __asm__ __volatile__("ISB");
    counters->event2 = ((uint64_t)hi << 32 | lo);*/
}

// INFO:
// Below is assmebly code based on the ARM v8 architecture 64 bit (use MCR/MRC for 32 bit)
// Enable PMUs
void enable_pmus()
{
    uint32_t val;
    // Enable control register
    __asm__ __volatile__("mrs %0, pmcr_el0" : "=r" (val)); 
    val |= 0x1;
    __asm__ __volatile__("msr pmcr_el0, %0" : : "r" (val));

    // Enable user access
    //__asm__ __volatile__("msr pmuserenr_el0, %0" : : "r" (0xF));
    
    // Enable all pmu counters
    __asm__ __volatile__("msr pmcntenset_el0, %0" : : "r" (0x8000000F));   
}

// Reset pmus + ccnt
void reset_pmus()
{
    uint32_t val;
    __asm__ __volatile__("mrs %0, pmcr_el0" : "=r" (val)); 
    val |= 0x7;
    __asm__ __volatile__("msr pmcr_el0, %0" : : "r" (val));

    //__asm__ __volatile__("mrs %0, pmcntenclr_el0" : "=r" (val));
    //val |= 0x80000001;
    //__asm__ __volatile__("msr pmcntenclr_el0, %0" : : "r" (val));
    __asm__ __volatile__("msr pmovsclr_el0, %0" : : "r" (0x8000000F)); 
}

// Disable pmus + ccnt
void disable_pmus()
{
    uint32_t val;
    // Disable control register
    __asm__ __volatile__("mrs %0, pmcr_el0" : "=r" (val)); 
    val |= 0x0;
    __asm__ __volatile__("msr pmcr_el0, %0" : : "r" (val));

    // Disable user access
    //__asm__ __volatile__("msr pmuserenr_el0, %0" : : "r" (0x1));
    
    // Disable all pmu counters
    __asm__ __volatile__("msr pmcntenset_el0, %0" : : "r" (0x0));
}

#endif


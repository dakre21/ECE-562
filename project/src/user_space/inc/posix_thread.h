#include <pthread.h>
#include <stdlib.h>
#include <stdio.h>
#include <sched.h>

#define MAX_THREADS 10

// Fwd declaration of pthreads
typedef struct
{
  int thread_id;
} thread_params;

pthread_t threads[MAX_THREADS];
thread_params params[MAX_THREADS];
pthread_attr_t sched_attr[MAX_THREADS];
struct sched_param rt_params[MAX_THREADS];

bool kill_pthreads(int num_threads)
{
  int i = 0;
  for (; i < num_threads; i++)
  {
    if (pthread_join(threads[i], NULL) != 0)
    {
      printf("ERROR: Could not kill thread execution\n");
      return false;
    }
  }

  pthread_exit(NULL);
  return true;
}

bool create_pthreads(int num_threads, void* (*entry_point)(void*))
{
  if (num_threads > MAX_THREADS)
  {
    printf("ERROR: Number of threads requested exceeds maximum %d\n", MAX_THREADS);
    return false;
  }

   int rt_max_prio = sched_get_priority_max(SCHED_FIFO);

  pthread_attr_init(&sched_attr[0]); // Init thread attributes
  pthread_attr_setinheritsched(&sched_attr[0], PTHREAD_EXPLICIT_SCHED); // Set inherit sched policy
  pthread_attr_setschedpolicy(&sched_attr[0], SCHED_FIFO); // Set sched policy to FIFO

  int i = 0;
  int rc;
  for (; i < num_threads; i++)
  {
    params[i].thread_id = i;
    rt_params[i].sched_priority = rt_max_prio - i; 	       // Set sched prio
    pthread_attr_setschedparam(&sched_attr[0], &rt_params[i]); // Set sched params & attr
    rc = pthread_create(&threads[i], 	           	       // ptr to thread descriptor
		   	&sched_attr[0],            	       // thread attributes
 		   	entry_point,               	       // thread fn entry pt (same for each thread)
		   	(void*)&(params[i]) 	   	       // params to pass in
		   	);
    if (rc)
    {
      printf("ERROR: Failed to create pthread... make sure you are running as root\n");
      return false;
    }
  } 

  return true;
}

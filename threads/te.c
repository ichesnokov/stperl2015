#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <pthread.h>
#include <string.h>

#define MAX_THREADS 10

static void *threadFunc(void *arg);
void wait_for_threads(pthread_t threads[]);

int main (int argc, char *argv[]) {
    // Настройка атрибутов потока
    pthread_attr_t threadAttr;
    pthread_attr_init(&threadAttr);
    pthread_attr_setdetachstate(&threadAttr, PTHREAD_CREATE_JOINABLE);

    pthread_t threads[MAX_THREADS];
    for (long iteration = 0; iteration < MAX_THREADS; iteration++) {
        int result = pthread_create(
            &threads[iteration],
            &threadAttr,
            threadFunc,
            (void*)iteration
        );
        if (result != 0) {
            printf("Error creating thread: %s\n", strerror(result));
            exit(1);
        }
    }

    wait_for_threads(threads);
    printf("Done\n");
}

void wait_for_threads(pthread_t threads[]) {

    printf("Waiting for all threads to finish...\n");
    for (int i = 0; i < MAX_THREADS; i++) {

        long *value;
        int result = pthread_join(threads[i], (void *)&value);
        if (result != 0) {
            printf("Error joining thread (%s)\n", strerror(result));
        }
        printf("Thread returned (%lu)\n", *value);
        free(value);
    }
}

static void *threadFunc(void *arg) {
    long iteration = (long) arg;

    printf("Thread %lu start\n", iteration);
    //unsigned long max = arc4random_uniform(1e9);
    unsigned long max = 1e9;
    unsigned long result = 0;
    for (int i = 1; i <= max; i++) {
       result += i;
    }
    printf("Thread %lu end\n", iteration);

    unsigned long *val = malloc(sizeof(unsigned long));
    *val = result;
    pthread_exit(val);
}


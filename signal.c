#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <signal.h>
#include <sys/wait.h>

void handle_sigterm(int sig) {
    printf("Parent received SIGTERM. Cleaning up...\n");
}

void handle_sigint(int sig) {
    printf("Parent received SIGINT. Exiting gracefully.\n");
    exit(0);
}

int main() {
    pid_t pid1, pid2;

    // Setup signal handlers
    signal(SIGTERM, handle_sigterm);
    signal(SIGINT, handle_sigint);

    printf("Parent PID: %d\n", getpid());

    // First child: sends SIGTERM after 5 seconds
    pid1 = fork();
    if (pid1 == 0) {
        sleep(5);
        kill(getppid(), SIGTERM);
        printf("Child 1 sent SIGTERM to parent.\n");
        exit(0);
    }

    // Second child: sends SIGINT after 10 seconds
    pid2 = fork();
    if (pid2 == 0) {
        sleep(10);
        kill(getppid(), SIGINT);
        printf("Child 2 sent SIGINT to parent.\n");
        exit(0);
    }

    // Parent runs indefinitely, waiting for signals
    while (1) {
        pause(); // Wait for signals
    }

    return 0;
}

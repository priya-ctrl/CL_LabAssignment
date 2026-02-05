#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>

int main() {
    int i;
    pid_t pid, child_pid;

    // Create multiple child processes
    for (i = 0; i < 3; i++) {
        pid = fork();

        if (pid == 0) {
            // Child process
            printf("Child process created. PID = %d\n", getpid());
            sleep(1);   // Simulate some work
            exit(0);
        }
        else if (pid < 0) {
            perror("fork failed");
            exit(1);
        }
    }

    // Parent process cleans up terminated children
    while ((child_pid = wait(NULL)) > 0) {

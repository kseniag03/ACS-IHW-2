#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

extern int64_t timespec_difference(struct timespec a, struct timespec b);
extern int file_input(char *pStr,  char *filename);
extern void file_output(char *pStr,  char *filename);
extern void random_generation(char *pStr);
extern void form_new_str(char *pStr, char ans[]);

const int SIZEMAX = 100000;
const int VALUEMAX = 128;

int main (int argc, char** argv) {
    char *arg;
    int option;
    struct timespec start, end;
    int64_t elapsed_ns;
    char *str;
    str = (char*)malloc(SIZEMAX);
    if (argc > 1) {
        arg = argv[1];
        printf("arg = %s\n", arg);
        option = atoi(arg);
        if (option == 1) {
            fgets(str, SIZEMAX, stdin);
        } else if (option == 2) {
            if (file_input(str, "input.txt")) {
                return 1;
            }
        } else {
            random_generation(str);
        }
    } else {
        printf("No arguments\n");
        return 0;
    }
    printf("Input: %s\n", str);
    clock_gettime(CLOCK_MONOTONIC, &start);
    char *pStr;
    pStr = str;
    char ans[100000] = "";
    form_new_str(pStr, ans);
    clock_gettime(CLOCK_MONOTONIC, &end);
    elapsed_ns = timespec_difference(end, start);
    printf("Elapsed: %ld ns\n", elapsed_ns);
    printf("Output: %s\n", ans);
    file_output(ans, "output.txt");
    return 0;
}

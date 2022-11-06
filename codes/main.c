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

int64_t timespec_difference(struct timespec a, struct timespec b) {
    int64_t timeA, timeB;
    timeA = a.tv_sec;
    timeA *= 1000000000;
    timeA += a.tv_nsec;
    timeB = b.tv_sec;
    timeB *= 1000000000;
    timeB += b.tv_nsec;
    return timeA - timeB;
}

int file_input(char *pStr,  char *filename) {
    FILE *file;
    if ((file = fopen(filename, "r")) == NULL) {
        printf("Unable to open file '%s'\n", filename);
        return 1;
    }
    int ch;
    do {
        ch = fgetc(file);
        *pStr = ch;
        ++pStr;
    } while(ch != -1);
    *pStr = '\0';
    fclose(file);
    return 0;
}

void file_output(char *pStr, char *filename) {
    FILE *file;
    if ((file = fopen(filename, "w")) != NULL) {
        while (*pStr) {
            fprintf(file, "%c", *pStr);
            ++pStr;
        }
        fclose(file);
    }
}

void random_generation(char *pStr) {
    srand(time(NULL));
    int n = rand() % SIZEMAX;
    if (n < 1) {
        ++n;
    }
    int i;
    short isNumber = 0;
    for (i = 0; i < n; ++i) {
        int c = rand() % VALUEMAX;
        if (c < 32) {
            --i;
            continue;
        }
        if ('0' <= c && c <= '9') {
            if (!isNumber) {
                *pStr = ' ';
                ++pStr;
                if (c % 7 == 0) {
                    *pStr = '-';
                    ++pStr;
                }
            }
            isNumber = 1;
        } else {
            if (isNumber) {
                isNumber = 0;
                *pStr = ' ';
                ++pStr;
            }
        }
        *pStr = c;
        ++pStr;
    }
    *pStr = '\0';
}

void form_new_str(char *pStr, char ans[]) {
    short isNumber = 0;
    short isNegative = 0;
    char tmp[256] = "";
    while (*pStr) {
        if (*pStr == '-') {
            if (*(pStr + 1) >= '0' && *(pStr + 1) <= '9') {
                isNegative = 1;
            }
        }
        if (*pStr >= '0' && *pStr <= '9') {
            isNumber = 1;
            char cToStr[2];
            cToStr[0] = *pStr;
            cToStr[1] = '\0';
            strcat(tmp, cToStr);
        } else {
            if (isNumber) {
                isNumber = 0;
                while (tmp[0] == '0' && strlen(tmp) > 1) {
                    memmove(tmp, tmp + 1, strlen(tmp));
                }
                if (isNegative && !(tmp[0] == '0' && strlen(tmp) == 1)) {
                    memmove(tmp + 1, tmp, strlen(tmp) + 1);
                    memset(tmp, '-', 1);
                    memmove(tmp + 1, tmp, strlen(tmp) + 1);
                    memset(tmp, '(', 1);
                    strcat(tmp, ")");
                }
                strcat(ans, tmp);
                strcat(ans, "+");
                tmp[0] = '\0';
                isNegative = 0;
            }
        }
        ++pStr;
    }
    if (isNumber) {
        strcat(ans, tmp);
        strcat(ans, "+");
        tmp[0] = '\0';
    }
    ans[strlen(ans) - 1] = '\0';
}

int main (int argc, char** argv) {
    // variables
    char *arg;
    int option;
    struct timespec start, end;
    int64_t elapsed_ns;
    char *str;
    str = (char*)malloc(SIZEMAX);

    // input
    if (argc > 1) {
        arg = argv[1];
        printf("arg = %s\n", arg);
        option = atoi(arg);
        if (option == 1) {
            gets(str);
        } else if (option == 2) {
            if (file_input(str, "input.txt")) {
                return 1;
            }
        } else {
            random_generation(str);
            puts(str);
        }
    } else {
        printf("No arguments\n");
        return 0;
    }

    // timeStart
    clock_gettime(CLOCK_MONOTONIC, &start);

    // do task
    char *pStr;
    pStr = str;
    char ans[100000] = "";
    form_new_str(pStr, ans);

    // timeEnd
    clock_gettime(CLOCK_MONOTONIC, &end);
    elapsed_ns = timespec_difference(end, start);
    printf("Elapsed: %lld ns\n", elapsed_ns);

    // output
    puts(ans);
    file_output(ans, "output.txt");

    return 0;
}
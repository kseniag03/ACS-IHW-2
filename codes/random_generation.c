#include <stdio.h>
#include <stdlib.h>
#include <time.h>

const int SIZEMAX = 100000;
const int VALUEMAX = 128;

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
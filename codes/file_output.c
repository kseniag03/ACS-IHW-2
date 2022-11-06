#include <stdio.h>

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
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// cheb qwj-kdqb 12 127 0 -1278 jwcvw

int main(int argc, char** argv) {
    char *str;
    str = (char*)malloc(100000);
    gets(str);
    puts(str);

    char *pStr;
    short isNumber = 0;
    pStr = str;

    char ans[100000] = "";
    char tmp[256] = "";

    while (*pStr) {
        if (*pStr == '-') {
            if (*(pStr + 1) >= '0' && *(pStr + 1) <= '9') {
                //printf("%c", *pStr);
                strcat(tmp,"-");
            }
        }
        if (*pStr >= '0' && *pStr <= '9') {
            //printf("%c", *pStr);
            isNumber = 1;
            char cToStr[2];
            cToStr[0] = *pStr;
            cToStr[1] = '\0';
            strcat(tmp, cToStr);
        } else {
            if (isNumber) {
                isNumber = 0;
                //printf(" ");
                strcat(ans, tmp);
                strcat(ans, "+");
                tmp[0] = '\0';
            }
        }
        ++pStr;
    }
    ans[strlen(ans) - 1] = '\0';
    puts(ans);
    return 0;
}

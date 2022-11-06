#include <stdio.h>
#include <string.h>

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
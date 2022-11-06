#  ИДЗ №2 #
## Markdown report <br> ##

### 1. Ганина Ксения Андреевна <br> ###
### 2. БПИ212 <br> ###
### 3. Вариант-31 <br> ###
 <br>

![image](https://user-images.githubusercontent.com/114473740/198892140-817596ef-fa86-40cd-a0cf-3d871b1d0d03.png) <br>
________________________

### 4. Тесты, демонстрирующие проверку программ. <br> ###

Формат ввода данных <br>
argc -- число аргументов в функции (если > 1, значит, передали аргументы) <br>
argv -- массив с аргументами, где: <br>
argv[0] -- имя исполняемого файла <br>
argv[1] -- формат ввода (1 -- console, 2 -- file, else -- random generation) <br>
выводится в консоль и в файл "output.txt" <br>

![Screenshot from 2022-10-23 18-22-55](https://user-images.githubusercontent.com/114473740/197400720-bfa9d7c5-eec4-43e8-9dbe-990bbc1cb4e6.png) <br>
________________________

### 5. Результаты тестовых прогонов для различных исходных данных. <br> ###

Тесты можно посмотреть здесь: ACS-IHW-1/tests <br>

Ввод с консоли: <br>
![Screenshot from 2022-11-06 23-30-44](https://user-images.githubusercontent.com/114473740/200193764-e0978872-eaaa-40b5-9d06-a2fab6d52c70.png) <br>

Ввод из файла: <br>
![Screenshot from 2022-11-06 23-37-57](https://user-images.githubusercontent.com/114473740/200193892-ba71c22b-d12b-4304-a600-2454bb04e77d.png) <br>
![Screenshot from 2022-11-06 23-41-17](https://user-images.githubusercontent.com/114473740/200193987-13eadfbf-2e0e-4a99-9a6f-0504bad323e6.png) <br>

Генератор: <br>
![Screenshot from 2022-11-06 23-46-03](https://user-images.githubusercontent.com/114473740/200194304-57cac48b-334f-4058-b7ca-4644f84057b9.png) <br>
![Screenshot from 2022-11-06 23-46-56](https://user-images.githubusercontent.com/114473740/200194314-e8f75fda-c30a-4fff-b2b2-2d26938d7484.png) <br>
________________________

### 6. Исходные тексты программы на языке C. <br> ###

Можно также посмотреть здесь: ACS-IHW-1/codes (main.c) и ACS-IHW-1/codes/funcs (все подпрограммы) <br>

main.c -- основная функция
```c
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
```
<br>

file_input.c -- ввод данных из входного файла "input.txt"
```c
#include <stdio.h>

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
```
<br>

file_output.c -- вывод данных в выходной файл "output.txt"
```c
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
```
<br>

random_generation.c -- псевдослучайная генерация исходной строки <br>
В качестве условностей: некоторые нечитаемые символы ASCII пропускались, числа отделялись пробелами, символы-цифры с кодом, кратным 7, становились отрицательными (для разнообразия вывода)
```c
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

extern const int SIZEMAX;
extern const int VALUEMAX;

void random_generation(char *pStr) {
    srand(time(NULL));
    int n = rand() % (SIZEMAX / 2);
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
```
<br>

timespec_difference.c -- вычисление разницы по времени работы
```c
#include <time.h>
#include <stdint.h>

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
```
<br>

form_new_str.c -- формирование новой строки согласно условию задачи
```c
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
```
<br>

________________________

### 7. Тексты программы на языке ассемблера, разработанной вручную или полученной после компиляции и расширенной комментариями. <br> ###

Можно также посмотреть здесь: ACS-IHW-1/codes/edited-asm-code <br>

main.s

```assembly
.intel_syntax noprefix			# intel-синтаксис
.globl main				# точка запуска main
.type main, @function			# объявление main как функции

.globl	SIZEMAX				# объявление глобальной константы
.globl	VALUEMAX			# объявление глобальной константы

.global ARRAY_A				# объявление глобального массива (входные данные)
.global ARRAY_B				# объявление глобальной массива (выходные данные)

.section .data				# секция объявления переменных 
	SIZEMAX:	.long		100000
	VALUEMAX:	.long		100000
	ARRAY_A:	.zero		400000
	ARRAY_B:	.zero		400000
	showArg:	.string		"arg = %s"
	inputFileName:	.string		"input.txt"
	outputFileName:	.string		"output.txt"
	noArg:		.string		"No arguments\n"
	elapsed:	.string		"Elapsed: %ld ns\n"

.text					# секция кода

main:					# тело main
	push	rbp				# сохраняем rbp на стек
	mov	rbp, rsp			# присваиваем rbp = rsp
	sub	rsp, 96				# rsp -= 96 (выделение памяти на стеке)

	mov	DWORD PTR -84[rbp], edi		# 1-й аргумент main — argc (в стеке на -84)
	mov	QWORD PTR -96[rbp], rsi		# 2-й аргумент main — argv (в стеке на -96)
	cmp	DWORD PTR -84[rbp], 1		# сравниваем число аргументов командной строки (argc) с 1
	jle	.NOARGS				# если argc <= 1, переходим к метке NOARGS

	lea	rdi, showArg[rip]		# 1-й аргумент для вывода варианта ввода — строка "arg = %s" (формат)
	mov	rax, QWORD PTR -96[rbp]		# rax := argv
	mov	rax, QWORD PTR 8[rax]		# rax := argv[1]
	mov	QWORD PTR -8[rbp], rax		# arg := rax
	mov	rsi, QWORD PTR -8[rbp]		# 2-й аргумент для вывода варианта ввода — arg
	call	printf@PLT			# вызов функции печати для вывода ответа, т.е. printf("arg = %s", arg)
	mov	edi, 10				# 1-й аргумент для функции печати символа — перевод строки (код 10)
	call	putchar@PLT			# вызов функции печати символа перевода строки, т.е. printf("\n")

	mov	rdi, QWORD PTR -8[rbp]		# 1-й аргумент для функции перевода в int — arg
	call	atoi@PLT			# вызов функции atoi для перевода в аргумент типа int, т.е. atoi(argv[1])
	mov	DWORD PTR -12[rbp], eax		# option := eax (результат выполнения функции atoi(argv[1]))

	cmp	DWORD PTR -12[rbp], 1		# сравниваем option с 1
	jne	.FILEINPUT			# если option не равен 1, переходим к метке FILEINPUT

	lea	rdi, -36[rbp]			# rdi := -36 на стеке, т.е. 1-й аргумент для ввода из командной строки — &n
	mov	rsi, QWORD PTR -96[rbp]		# 2-й аргумент для ввода из командной строки — argv
	call	command_line_input@PLT		# вызов функции ввода данных из командной строки, т.е. command_line_input(&n, argv)

	test	eax, eax			# проверяется код возврата (логическое сравнение)
	je	.FILLARRAYB			# если равны, переход к метке FILLARRAYB (если command_line_input не завершился с ошибкой и вернул 0)
	mov	eax, 1				# иначе return 1

	jmp	.EXIT				# переход к метке EXIT

.FILEINPUT:				# ввод из файла
	cmp	DWORD PTR -12[rbp], 2		# сравниваем option с 2
	jne	.RANDOM				# если option не равен 2, переходим к метке RANDOM

	lea	rdi, -36[rbp]			# 1-й аргумент для ввода из файла — &n
	lea	rsi, inputFileName[rip]		# 2-й аргумент для ввода из файла — "input.txt"
	call	file_input@PLT			# вызов функции ввода данных из файла, т.е. file_input(&n, "input.txt")

	test	eax, eax			# проверяется код возврата (логическое сравнение)
	je	.FILLARRAYB			# если равны, переход к метке FILLARRAYB (если file_input не завершился с ошибкой и вернул 0)
	mov	eax, 1				# иначе return 1

	jmp	.EXIT				# переход к метке EXIT

.RANDOM:				# псевдослучайная генерация массива
	lea	rdi, -36[rbp]			# 1-й аргумент для генерации — &n
	call	random_generation@PLT		# вызов функции случайной генерации массива, т.е. random_generation(&n);

	mov	edi, DWORD PTR -36[rbp]		# 1-й аргумент для вывода — &n
	lea	rsi, ARRAY_A[rip]		# 2-й аргумент для вывода — сгенерированный исходный массив 
	call	command_line_output@PLT		# вызов функции вывода исходного сгенерированного массива, т.е. command_line_output(n, ARRAY_A)

	jmp	.FILLARRAYB			# переход к метке FILLARRAYB

.NOARGS:				# недостаточно аргументов в командной строке для работы программы
	lea	rdi, noArg[rip]			# 1-й аргумент для вывода сообщения — строка "No arguments"
	call	printf@PLT			# вызов функции печати для вывода ответа, т.е. printf("No arguments\n")
	mov	eax, 0				# return 0

	jmp	.EXIT				# переход к метке EXIT

.FILLARRAYB:
	mov	edi, 1				# 1-й аргумент для запуска счётчика — 1 (CLOCK_MONOTONIC)
	lea	rsi, -64[rbp]			# 2-й аргумент для запуска счётчика — &start
	call	clock_gettime@PLT		# вызов функции подсчёта времени до заполнения массива B, т.е. clock_gettime(CLOCK_MONOTONIC, &start)

	mov	edi, DWORD PTR -36[rbp]		# 1-й аргумент для поиска минимума — n
	lea	rsi, ARRAY_A[rip]		# 2-й аргумент для поиска минимума — ARRAY_A
	call	get_min_from_array@PLT		# вызов функции поиска минимума, т.е. get_min_from_array(n, ARRAY_A);
	mov	DWORD PTR -16[rbp], eax		# min := результат функции get_min_from_array (в стеке на -16)

	mov	edi, DWORD PTR -36[rbp]		# 1-й аргумент для подсчёта — n
	lea	rsi, ARRAY_A[rip]		# 2-й аргумент для подсчёта — ARRAY_A
	mov	edx, DWORD PTR -16[rbp]		# 3-й аргумент для поиска минимума — min
	call	count_if_equals_element@PLT	# вызов функции ..., т.е. count_if_equals_element(n, ARRAY_A, min);
	mov	DWORD PTR -20[rbp], eax		# size := результат функции count_if_equals_element (в стеке на -20)

	mov	eax, DWORD PTR -36[rbp]		# eax := n
	sub	eax, DWORD PTR -20[rbp]		# eax := n - size
	mov	DWORD PTR -20[rbp], eax		# size := eax

	mov	edi, DWORD PTR -36[rbp]		# 1-й аргумент для заполнения — n
	mov	esi, DWORD PTR -20[rbp]		# 2-й аргумент для заполнения — size
	mov	edx, DWORD PTR -16[rbp]		# 3-й аргумент для заполнения — min
	call	fill_ARRAY_B@PLT		# вызов функции заполнения массива B, т.е. fill_ARRAY_B(n, size, min)

	mov	edi, 1				# 1-й аргумент для запуска счётчика — 1 (CLOCK_MONOTONIC)
	lea	rsi, -80[rbp]			# 2-й аргумент для запуска счётчика — &end
	call	clock_gettime@PLT		# вызов функции подсчёта времени до вывода, т.е. clock_gettime(CLOCK_MONOTONIC, &end)

	mov	rdi, QWORD PTR -80[rbp]		# 1-й аргумент для подсчёта времени — end.tv_sec
	mov	rsi, QWORD PTR -72[rbp]		# 2-й аргумент для подсчёта времени — end.tv_nsec
	mov	rdx, QWORD PTR -64[rbp]		# 3-й аргумент для подсчёта времени — start.tv_sec
	mov	rcx, QWORD PTR -56[rbp]		# 4-й аргумент для подсчёта времени — start.tv_nsec
	call	timespec_difference@PLT		# вызов функции для вычисления времени заполнения массива B, т.е. timespec_difference(end, start) (4 аргумента, т.к. передаются структуры с 2-мя полями)
	mov	QWORD PTR -32[rbp], rax		# elapsed_ns := rax (результат выполнения функции timespec_difference)

	mov	edi, DWORD PTR -20[rbp]		# 1-й аргумент для вывода — size
	lea	rsi, ARRAY_B[rip]		# 2-й аргумент для вывода — ARRAY_B
	call	command_line_output@PLT		# вызов функции вывода полученного массива, т.е. command_line_output(size, ARRAY_B)

	mov	edi, DWORD PTR -20[rbp]		# 1-й аргумент для вывода — size
	lea	rsi, outputFileName[rip]	# 2-й аргумент для вывода — "output.txt"
	call	file_output@PLT			# вызов функции вывода полученного массива в выходной файл, т.е. file_output(size, "output.txt")

	lea	rdi, elapsed[rip]		# 1-й аргумент для вывода времени — строка "Elapsed: %ld ns\n"
	mov	rsi, QWORD PTR -32[rbp]		# 2-й аргумент для вывода времени — elapsed_ns
	call	printf@PLT			# вызов функции печати для вывода ответа, т.е. printf("Elapsed: %ld ns\n", elapsed_ns)

	mov	eax, 0				# return 0

.EXIT:					# выход из программы
	leave					# освобождает стек на выходе из функции main
	ret					# выполняется выход из программы

```
<br>

Стек переменных: <br>
![main_stack](https://user-images.githubusercontent.com/114473740/197405043-2ef52153-8269-4fa7-9005-f7174bb80fa9.jpg) <br>
<br>

command_line_input.s

```assembly
.intel_syntax noprefix			# intel-синтаксис
.globl command_line_input		# точка запуска command_line_input
.type command_line_input, @function	# объявление command_line_input как функции

.section .data				# секция объявления переменных
	wrongElemsNum:	.string		"The num of elems in arr must be from 1 to %d\n"
	notEnough:	.string		"Not enough elems in arr\n"

.text					# секция кода

command_line_input:			# тело command_line_input
	push	rbp					# сохраняем rbp на стек
	mov	rbp, rsp				# присваиваем rbp = rsp
	sub	rsp, 32					# rsp -= 32 (выделение памяти на стеке)

	mov	QWORD PTR -24[rbp], rdi			# 1-й аргумент command_line_input — int *n (в стеке на -24)
	mov	QWORD PTR -32[rbp], rsi			# 2-й аргумент command_line_input — char** argv (в стеке на -32)

	mov	rax, QWORD PTR -32[rbp]			# rax := argv
	mov	rdi, QWORD PTR [rax + 16]		# rdi := argv[2] (1-й аргумент функции)
	call	atoi@PLT				# вызов функции atoi для перевода в аргумент типа int, т.е. atoi(argv[2])

	mov	rdx, QWORD PTR -24[rbp]			# rdx := *n
	mov	DWORD PTR [rdx], eax			# n := результат вызова функции atoi
	mov	eax, DWORD PTR [rdx]			# eax := n
	cmp	eax, 0					# сравнение n и 0
	jle	.WRONGN					# если n <= 0, переходим к метке WRONGN
	cmp	eax, SIZEMAX[rip]			# иначе сравниваем n и SIZEMAX
	jle	.BEFORELOOP				# если n <= SIZEMAX, переходим к метке BEFORELOOP

.WRONGN:				# введен неверный размер массива
	lea	rdi, wrongElemsNum[rip]			# 1-й аргумент функции — строка "The num of elems in arr must be from 1 to %d\n"
	mov	esi, SIZEMAX[rip]			# 2-й аргумент функции — константа SIZEMAX 
	call	printf@PLT				# вызов функции печати для вывода сообщения об ошибке, т.е. printf("The num of elems in arr must be from 1 to %d\n", SIZEMAX)		

	mov	eax, 1					# return 1
	jmp	.EXIT					# переход к метке EXIT

.BEFORELOOP:				# объявляем индекс перед циклом
	mov	r12d, 0					# i := 0 (в свободном регистре r12)
	jmp	.LOOPFOR				# переход к метке LOOPFOR

.CHECKINPUTELEMS:
	mov	eax, r12d				# eax := i
	add	rax, 3					# rax += 3
	lea	rdx, 0[0 + rax * 8]			# rdx := (rax + 3) * 8

	mov	rax, QWORD PTR -32[rbp]			# rax := argv
	add	rax, rdx				# rax += rdx
	mov	rax, QWORD PTR [rax]			# rax := argv[i + 3]

	test	rax, rax				# логическое сравнене — проверка, является ли элемент NULL
	jne	.ARRAYELEMS				# если не NULL, переход к метке ARRAYELEMS

	lea	rdi, notEnough[rip]			# 1-й аргумент функции — строка "Not enough elems in arr\n"
	call	printf@PLT				# вызов функции печати для вывода сообщения об ошибке, т.е. printf("Not enough elems in arr\n")

	mov	eax, 1 					# return 1;
	jmp	.EXIT					# переход к метке EXIT

.ARRAYELEMS:
	mov	eax, r12d				# eax := i
	add	rax, 3					# rax += 3
	lea	rdx, 0[0 + rax * 8]			# rdx := (rax + 3) * 8

	mov	rax, QWORD PTR -32[rbp]			# rax := argv
	add	rax, rdx				# rax += rdx
	mov	rdi, QWORD PTR [rax]			# rdi := argv[i + 3] (1-й аргумент функции)
	call	atoi@PLT				# вызов функции atoi для перевода в аргумент типа int, т.е. atoi(argv[i + 3])

	movsx	rdx, r12d				# в rdx копируется r12d
	lea	rcx, 0[0 + rdx * 4]			# rcx := rdx * 4
	lea	rdx, ARRAY_A[rip]			# rdx := &ARRAY_A[rip]
	mov	DWORD PTR [rcx + rdx], eax		# *(rcx + rdx) = eax
	add	r12d, 1					# ++i

.LOOPFOR:				# цикл for по i
	mov	rax, QWORD PTR -24[rbp]			# rax := *n
	mov	eax, DWORD PTR [rax]			# eax := n
	cmp	r12d, eax				# сравниваем i c n
	jl	.CHECKINPUTELEMS			# если i < n, переход к метке CHECKINPUTELEMS
	mov	eax, 0					# return 0

.EXIT:					# выход из программы
	leave					# освобождает стек на выходе из функции main
	ret					# выполняется выход из программы

```
<br>

command_line_output.s

```assembly
.intel_syntax noprefix			# intel-синтаксис
.globl command_line_output		# точка запуска command_line_output
.type command_line_output, @function	# объявление command_line_output как функции

.section .data				# секция объявления переменных
	bracket:	.string		"[ "
	frmtnum:	.string		"%d "

.text					# секция кода

command_line_output:
	push	rbp				# сохраняем rbp на стек
	mov	rbp, rsp			# присваиваем rbp = rsp
	sub	rsp, 32				# rsp -= 32 (выделение памяти на стеке)
	mov	DWORD PTR -20[rbp], edi		# 1-й аргумент command_line_output — int n (в стеке на -20)
	mov	QWORD PTR -32[rbp], rsi		# 2-й аргумент command_line_output — int arr[] (в стеке на -32)
	
	lea	rdi, bracket[rip]		# rdi := "[ " (1-й аргумент функции)
	call	printf@PLT			# printf("[ ")
	mov	r12d, 0				# i = 0
	jmp	.LOOP				# переход к LOOP
	
.PRINTELEM:
	mov	eax, r12d			# eax := i
	lea	rdx, 0[0 + rax * 4]		# rdx := rax * 4
	mov	rax, QWORD PTR -32[rbp]		# rax := n	
	add	rax, rdx			# rax := arr[i]
	
	lea	rdi, frmtnum[rip]		# rdi := "%d " (1-й аргумент функции)
	mov	esi, DWORD PTR [rax]		# esi := arr[i] (2-й аргумент функции)
	call	printf@PLT			# printf("%d ", arr[i])
	add	r12d, 1				# ++i
	
.LOOP:
	cmp	r12d, DWORD PTR -20[rbp]	# сравнение i и n
	jl	.PRINTELEM			# если i < n, переход в PRINTELEM
	
	mov	edi, 93				# передача 1-го аргумента в функцию
	call	putchar@PLT			# выводит символ ']' (номер 93), т.е. printf("]")
	mov	edi, 10				# передача 1-го аргумента в функцию		
	call	putchar@PLT			# выводит символ перевода строки (номер 10), т.е. printf("\n")
	
	leave					# освобождает стек на выходе из функции main
	ret					# выполняется выход из программы

```

<br>

count_if_equals_element.s

```assembly
.intel_syntax noprefix
.globl count_if_equals_element
.type count_if_equals_element, @function

.text
	
count_if_equals_element:
	push	rbp
	mov	rbp, rsp
	mov	r13d, edi			# r13d = n
	mov	r14, rsi			# r14 = int arr[]
	mov	r15d, edx			# r15d = int element
	
	mov	r11d, 0				# cnt = 0
	mov	r12d, 0				# i = 0
	jmp	.LOOP				# переход к циклу
	
.INCCNT:
	lea	rdx, 0[0 + rax * 4]		# rdx := rax * 4
	mov	rax, r14			# rax := &arr
	add	rax, rdx			# rax += rdx
	mov	eax, DWORD PTR [rax]		# eax := arr[i]
	cmp	r15d, eax			# сравнение element и arr[i]
	jne	.INCI				# если arr[i] != elementn, переход к INCI
	add	r11d, 1				# иначе ++cnt;
	
.INCI:
	add	r12d, 1				# ++i
	
.LOOP:
	cmp	r12d, r13d			# сравнение i и n
	jl	.INCCNT				# если i < n, переход к INCCNT
	mov	eax, r11d			# return cnt
	pop	rbp				# очистка стека
	ret					# выполняется выход из программы

```

<br>

random_generation.s

```assembly
.intel_syntax noprefix
.text
.globl	random_generation
.type	random_generation, @function

random_generation:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	QWORD PTR -24[rbp], rdi

	mov	edi, 0				# 1-й агрумент -- 0 (NULL)
	call	time@PLT			# time(NULL)
	mov	edi, eax			# 1-й агрумент -- возвращаемое знач. из time(NULL)
	call	srand@PLT			# srand(time(NULL))
	call	rand@PLT			# вызов ф-и rand()
	mov	ecx, DWORD PTR SIZEMAX[rip]	# ecx := SIZEMAX
	idiv	ecx				# % SIZEMAX

	mov	rax, QWORD PTR -24[rbp]		# rax := *n
	mov	DWORD PTR [rax], edx		# n = edx (rand())
	mov	eax, DWORD PTR [rax]		# eax := n
	test	eax, eax			# логическое сравнение (< 1)
	jg	.TOLOOP				# если *n > 1, переход к объявлению i и циклу (TOLOOP)
	mov	rax, QWORD PTR -24[rbp]
	mov	eax, DWORD PTR [rax]		# eax := n
	lea	edx, 1[rax]			# ++*n
	mov	rax, QWORD PTR -24[rbp]		# rax := *n
	mov	DWORD PTR [rax], edx		# n = edx

.TOLOOP:
	mov	r12d, 0				# i = 0
	jmp	.LOOP				# переход к циклу LOOP

.GENERATEELEM:
	call	rand@PLT			# вызов ф-и rand()
	mov	ecx, VALUEMAX[rip]		# ecx := VALUEMAX
	idiv	ecx				# % VALUEMAX
	mov	ecx, edx			#
	mov	eax, r12d			#

	lea	rdx, 0[0 + rax * 4]		# 		
	lea	rax, ARRAY_A[rip]		#	
	mov	DWORD PTR [rdx + rax], ecx	# 	
	add	r12d, 1				# ++i

.LOOP:
	mov	rax, QWORD PTR -24[rbp]		# rax := *n
	mov	eax, DWORD PTR [rax]		# eax := n
	cmp	r12d, eax			# сравнение i и n
	jl	.GENERATEELEM			# если i < n, переход к GENERATEELEM
	leave					# очистка стека
	ret					# выполняется выход из программы

```

________________________

### 8. Текст на ассемблере программы, полученный после компиляции программы на C. <br> ###

Смотреть: ACS-IHW-1/codes/generated-asm-code/ <br>

________________________

### 9. Информацию, подтверждающую выполнение задания в соответствие требованиям на предполагаемую оценку. <br> ###
<br>

Компиляция частей кода и линковка: <br>

`gcc -masm=intel \` <br>
    `-fno-asynchronous-unwind-tables \` <br>
    `-fno-jump-tables \` <br>
    `-fno-stack-protector \` <br>
    `-fno-exceptions \` <br>
    `./main.c \` <br>
    `-S -o ./main.s` <br>
`gcc ./main.s -c -o ./main.o` <br>

Аналогичные команды выполнить для всех файлов-функций: <br>
command_line_input.c <br>
command_line_output.c <br>
count_if_equals_element.c <br>
file_input.c <br>
file_output.c <br>
fill_ARRAY_B.c <br>
get_min_from_array.c <br>
random_generation.c <br>
timespec_difference.c <br>

Для линковки: <br>
`gcc -lc main.o command_line_input.o command_line_output.o count_if_equals_element.o file_input.o file_output.o fill_ARRAY_B.o get_min_from_array.o random_generation.o timespec_difference.o -o foo.exe` <br>

Убираем макросы: <br>
endbr64, cdqe, cdq <br>

Переписываем .section.data и названия меток (LC0, L1, etc.) для наглядности <br>


Убираем лишние присваивания: вместо  <br>
`mov	rax, QWORD PTR -8[rbp]` <br>
`mov	rdi, rax` <br>
сразу пишем <br>
`mov	rdi, QWORD PTR -8[rbp]` <br>

Изменения main: <br>
Добавилось небольшое отличие от программы на Си — вывод `elapsed_ns` после выводов массива (чтобы при генерации массивов время было видно при выводе) <br>

Критерий на 6. <br>
Оптимизация использования регистров процессора: <br>
// r8-r15 -- свободные регистры <br>
Переменную цикла i записываем в один из свободных регистров: <br>
DWORD PTR -4[rbp] -> r12d <br>
<br>
При редакции count_if_equals_element.s использовались: <br>
DWORD PTR -4[rbp] -> r11d (т.к. double word, используем 0-3 bytes) <br> 
DWORD PTR -8[rbp] -> r12d <br>
DWORD PTR -20[rbp] -> r13d <br>
QWORD PTR -32[rbp] -> r14 (т.к. quad word, используем 8-byte register) <br> 
DWORD PTR -24[rbp] -> r15d <br>

Критерий на 7. <br>
Скомпилированы и отредактированы (к сожалению, не все...) программы на ассемблере, в виде 10 единиц компиляции (походу, зря...). <br>
// но единиц компиляции получилось отредактировать больше 2-х <br>
Реализован файловый ввод/вывод (после имени исполняемого файла в командной строке достаточно ввести символ 2). <br>
<br>

Критерий на 8. <br>
Реализована генерация исходного массива (псевдослучайная) и добавлена функция замера времени заполнения массива B с помощью clock_gettime. <br>
Программа генерирует случайный массив, если в качестве `option` подавался символ, отличный от 1 или 2 (но не NULL). <br>
Время замерялось перед поиском минимума и перед выводом полученного массива, разница показателей есть время заполнения. <br>
<br>

Критерий на 9. <br>
Для оптимизации по скорости все части программы компилировались с флагом -O3. <br>
Для оптимизации по размеру все части программы компилировались с флагом -Os. <br>

Таблица сравнений приведена ниже: <br>
| Критерий	     	| Скомпилированный Си| С оптим. -O3	   | С оптим. -Os        | Отредактированный вручную после компиляции |       
| ----------------------|:------------------:| :------------------:|:-------------------:|:------------------------------------------:|
| размер асм-файла	| 15 631 байт        | 18 043 байт         | 13 603 байт         | 818 312 байт                               |
| размер испол. файла	| 17 280 байт        | 17 360 байт         | 17 360 байт         | 24 879 байт                                |
| время работы		| 387 918, 1 ns      | 221 510, 8 ns       | 293 939, 9 ns       | 1 236 683 ns                               |

<br>
// размер асм-файла == размер 10 файлов расширения .s (из папки time-size-check), исполняемый файл в этой же папке
<br>
// время работы == усреднённое время работы 10 запусков псевдослучаного генератора (т.к. большой размер массива)
<br>
// программа, отредактированная вручную, отредактирована не полностью (не во всех асм-файлах внесены изменения с регистрами), но при замерах будут учитываться все подпрограммы
<br>

Результаты 10 замеров генератора <br>

Скомп. Си: <br>

<br>

Скомп. Си c option: -O3 <br>

<br>

Скомп. Си c option: -Os <br>

<br>

Скомп. Си c правками <br>

<br>


По времени самый выгодный: с -O3 <br>
По размеру файлов асм: с -Os <br>
По размеру файла исполняемого: обычный компил с Си (но выигравает он не сильно) <br>
<br>

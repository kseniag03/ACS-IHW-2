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

![Screenshot from 2022-11-06 23-54-50](https://user-images.githubusercontent.com/114473740/200194702-54b7ffdb-aae5-465c-b3b9-c9f6b7426c00.png) <br>
________________________

### 5. Результаты тестовых прогонов для различных исходных данных. <br> ###

Тесты можно посмотреть здесь: ACS-IHW-2/tests <br>

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

Можно также посмотреть здесь: ACS-IHW-2/codes <br>

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

Можно также посмотреть здесь: ACS-IHW-2/codes/edited-asm-code <br>

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

file_input.s

```assembly
.intel_syntax noprefix				# intel-синтаксис
.globl file_input				# точка запуска file_input
.type file_input, @function			# объявление file_input как функции

.section .data					# секция объявления переменных
	readFile:	.string		"r"
	notOpenFile:	.string	"Unable to open file '%s'\n"

.text						# секция кода

file_input:
	push	rbp				# сохраняем rbp на стек
	mov	rbp, rsp			# присваиваем rbp = rsp

	mov	r12, rdi			# 1-й аргумент file_input — char *pStr (в свободном регистре r12)
	mov	r13, rsi			# 2-й аргумент file_input — char *filename (в свободном регистре r13)

	mov	rdi, r13			# 1-й аргумент — имя файла
	lea	rsi, readFile[rip]		# 2-й аргумент —  формат открытия файла (чтение)
	call	fopen@PLT			# вызов функции открытия файла: file = fopen(filename, "r"), в rax результат функции

	mov	r14, rax			# FILE *file = filename (возвращаемое значение из функции)
	cmp	r14, 0				# сравнение file с 0 (NULL)
	jne	.LOOP				# если file != NULL, переход к метке LOOP

	lea	rdi, notOpenFile[rip]		# 1-й аргумент —  сообщение об ошибке
	mov	rsi, r13			# 2-й аргумент —  имя файла
	call	printf@PLT			# вызов printf("Unable to open file '%s'\n", filename)

	mov	eax, 1				# return 1						
	jmp	.EXIT				# переход к выходу из программы

.LOOP:
	mov	rdi, r14			# 1-й аргумент — file
	call	fgetc@PLT			# вызов ch = fgetc(file) — получение символа из файлового потока
	mov 	r15d, eax			# в свободный регистр r15d записывается результат функции fgetc
	mov	edx, r15d			# скопировать содержимое r15d в edx

	mov	rax, r12			# rax = r12 
	mov	BYTE PTR [rax], dl		# по адресу текущего символа записывается символ из файла (*pStr = ch)
	add	r12, 1				# ++pStr

	cmp	r15d, -1			# сравнение текущего символа с -1
	jne	.LOOP				# если не равен -1, переход к метке LOOP

	mov	rax, r12			# rax = r12
	mov	BYTE PTR [rax], 0		# по адресу последнего символа записывается конец строки (*pStr = ‘\0’)

	mov	rdi, r14			# 1-й аргумент — file
	call	fclose@PLT			# вызов fclose(file)

	mov	eax, 0				# return 0

.EXIT:
	leave					# освобождает стек на выходе из функции
	ret					# выполняется выход из программы

```
<br>

file_output.s

```assembly
.intel_syntax noprefix				# intel-синтаксис
.globl file_output				# точка запуска file_output
.type file_output, @function			# объявление file_output как функции

.section .data					# секция объявления переменных
	writeFile:	.string		"w"	# формат открытия файла (запись)

.text						# секция кода

file_output:
	push	rbp				# сохраняем rbp на стек
	mov	rbp, rsp			# присваиваем rbp = rsp

	mov	r12, rdi			# 1-й аргумент file_output — char *pStr (в свободном регистре r12)
	mov	r13, rsi			# 2-й аргумент file_output — char *filename (в свободном регистре r13)

	mov	rdi, r13			# 1-й аргумент — имя файла
	lea	rsi, writeFile[rip]		# 2-й аргумент —  формат открытия файла (запись)
	call	fopen@PLT			# вызов функции открытия файла: file = fopen(filename, "w"), в rax результат функции

	mov	r14, rax			# FILE *file = filename (возвращаемое значение из функции)
	cmp	r14, 0				# сравнение file с 0 (NULL)
	je	.EXIT				# если file == NULL, переход к выходу из программы

	jmp	.LOOP				# иначе переход к метке LOOP

.PRINT:
	movsx	eax, al				# eax = al

	mov	edi, eax			# 1-й аргумент — текущий символ (*pStr)
	mov	rsi, r14			# 2-й аргумент — file
	call	fputc@PLT			# вызов fputc(*pStr, file)

	add	r12, 1				# ++pStr

.LOOP:
	mov	rax, r12 			# rax = pStr
	movzx	eax, BYTE PTR [rax]		# вычисление адреса текущего символа (записывается в eax)

	test	al, al				# логическое сравнения значения регистра с нулем
	jne	.PRINT				# если не равно 0, переход к метке PRINT
	mov	rdi, r14			# 1-й аргумент — file
	call	fclose@PLT			# вызов fclose(file)

.EXIT:
	leave					# освобождает стек на выходе из функции
	ret					# выполняется выход из программы

```

<br>

form_new_str.s

```assembly

```

<br>

random_generation.s

```assembly
.intel_syntax noprefix				# intel-синтаксис
.globl random_generation			# точка запуска random_generation
.type random_generation, @function		# объявление random_generation как функции

.text

random_generation:
	push	rbp				# сохраняем rbp на стек
	mov	rbp, rsp			# присваиваем rbp = rsp

	mov 	eax, SIZEMAX[rip]		# делимое SIZEMAX в eax
	mov	ecx, 2				# делитель 2 в ecx
	cdq					# преобразовывает SIZEMAX в 8-байтовое значение
	idiv 	ecx				# SIZEMAX / 2 (частное сохраняется в eax, остаток в edx)
	mov	r13d, eax			# в свободный регистр r13d (double word) записываем результат деления SIZEMAX / 2

	mov	r12, rdi			# в свободный регистр r12 записываем переданный в ф-ю параметр (pStr)

	mov	edi, 0				# 1-й аргумент — 0 (NULL)
	call	time@PLT			# вызов функции time(NULL)

	mov	edi, eax			# 1-й аргумент — результат вызова time(NULL)
	call	srand@PLT			# вызов функции srand(time(NULL))

	xor 	edx, edx 			# очистка edx, в который запишется остаток от операции деления div
	call	rand@PLT			# вызов функции rand() — делимое, записываемое в eax
	mov	ecx, r13d			# делитель (SIZEMAX / 2) в ecx
	cdq					# преобразовывает rand() в 8-байтовое значение
	idiv 	ecx				# rand() / (SIZEMAX / 2) (частное сохраняется в eax, остаток в edx)

	mov	r11d, edx			# в свободный регистр r11d (double word) записываем остаток (int n = rand() % (SIZEMAX / 2))
	cmp	r11d, 0				# сравнение n с нулём
	jg	.FLAGS				# если n > 0, переходим к метке FLAGS
	add	r11d, 1				# иначе ++n

.FLAGS:
	mov	r10w, 0				# short isNumber = 0
	mov	r15d, 0				# int i = 0
	jmp	.LOOPBEGIN			# переход к метке LOOPBEGIN

.GETCHAR:
	xor 	edx, edx 			# очистка edx, в который запишется остаток от операции деления div
	call	rand@PLT			# вызов функции rand() — делимое, записываемое в eax
	mov	ecx, VALUEMAX[rip]		# делитель VALUEMAX (128) в ecx
	cdq					# преобразовывает rand() в 8-байтовое значение
	idiv	ecx				# rand() / VALUEMAX (частное сохраняется в eax, остаток в edx)

	mov	r14d, edx			# в свободный регистр r14d (double word) записываем остаток (int c = rand() % VALUEMAX)
	cmp	r14d, 31			# сравнение кода символа с 31
	jg	.CHECKNEGATIVE			# если больше 31, переход к метке CHECKNEGATIVE

	sub	r15d, 1				# иначе --i (запускаем цикл заново)
	jmp	.INCINDEX			# переход к метке INCINDEX

.CHECKNEGATIVE:
	cmp	r14d, 47			# сравнение кода символа с 48 (с 48-го начинаются цифры)
	jl	.ADDCLOSESPACE			# если меньше 48, переход к метке ADDCLOSESPACE

	cmp	r14d, 57			# сравнение кода символа с 57 (с 58-го заканчиваются цифры)
	jg	.ADDCLOSESPACE			# если больше 57, переход к метке ADDCLOSESPACE

	cmp	r10w, 0				# проверяем, встретилось ли число (чтобы вставить пробелы)
	jne	.NUMBERFLAG			# если число не закончилось (или не началось), переходим к метке NUMBERFLAG

	mov	rax, r12			# rax = r12
	mov	BYTE PTR [rax], 32		# по адресу текущего символа записывается пробел (*pStr = ‘ ’)
	add	r12, 1				# ++pStr

	xor 	edx, edx 			# очистка edx, в который запишется остаток от операции деления div
	mov	eax, r14d			# делимое c в eax
	mov 	ecx, 7				# делитель 7 в ecx
	cdq					# преобразовывает c в 8-байтовое значение
	idiv 	ecx				# c / 7
	cmp	edx, 0				# сравниваем остаток от деления с нулём
	jne	.NUMBERFLAG			# если не равен нулю, переход к метке NUMBERFLAG (минус не ставим)

	mov	rax, r12			# rax = r12
	mov	BYTE PTR [rax], 45		# по адресу текущего символа записывается минус (*pStr = ‘-’)
	add	r12, 1				# ++pStr

.NUMBERFLAG:
	mov	r10w, 1				# isNumber = 1
	jmp	.ADDSYMTOSTR			# переход к метке ADDSYMTOSTR

.ADDCLOSESPACE:
	cmp	r10w, 0				# сравнение isNumber с нулём (не число)
	je	.ADDSYMTOSTR			# если равен нулю, переход к метке ADDSYMTOSTR (не ставим пробел)

	mov	r10w, 0				# иначе isNumber = 0

	mov	rax, r12			# rax = r12
	mov	BYTE PTR [rax], 32		# по адресу текущего символа записывается пробел (*pStr = ‘ ’)
	add	r12, 1				# ++pStr

.ADDSYMTOSTR:
	mov	edx, r14d			# скопировать содержимое r14d в edx
	mov	rax, r12			# rax = r12
	mov	BYTE PTR [rax], dl		# по адресу текущего символа записывается символ из файла (*pStr = c)
	add	r12, 1				# ++pStr

.INCINDEX:
	add	r15d, 1				# ++i

.LOOPBEGIN:
	cmp	r15d, r11d			# сравнение i с n
	jl	.GETCHAR			# если меньше, переход к метке GETCHAR (следующая итерация цикла-for)

	mov	rax, r12			# rax = r12
	mov	BYTE PTR [rax], 0		# по адресу последнего символа записывается конец строки (*pStr = ‘\0’)

	leave					# освобождает стек на выходе из функции
	ret					# выполняется выход из программы

```

<br>

timespec_difference.s

```assembly
.intel_syntax noprefix			# intel-синтаксис
.globl	timespec_difference		# точка запуска timespec_difference
.type	timespec_difference, @function	# объявление timespec_difference как функции

.text					# секция кода

timespec_difference:
	push	rbp			# сохраняем rbp на стек
	mov	rbp, rsp		# присваиваем rbp = rsp

	mov	r12, rdi		# 1-й аргумент timespec_diff — struct timespec a.tv_sec (в свободном регистре r12)
	mov	r13, rsi		# 2-й аргумент timespec_diff — struct timespec a.tv_nsec (в свободном регистре r13)
	mov	r14, rdx		# 3-й аргумент timespec_diff — struct timespec b.tv_sec (в свободном регистре r14)
	mov	r15, rcx		# 4-й аргумент timespec_diff — struct timespec b.tv_nsec (в свободном регистре r15)

	imul	rax, r12, 1000000000	# rax = a.tv_sec * 1000000000 (rax - возвращаемое значение)
	add	rax, r13		# rax = a.tv_sec * 1000000000 + a.tv_nsec
	
	imul	r11, r14, 1000000000	# r11 = b.tv_sec * 1000000000 (r11 - свободный регистр)
	add	r11, r15		# r11 = b.tv_sec * 1000000000 + b.tv_nsec

	sub	rax, r11		# вычитаем время начала: rax = (a.tv_sec * 1000000000 + a.tv_nsec) - (b.tv_sec * 1000000000 + b.tv_nsec)
	
	pop rbp				# очистка стека
	ret				# выполняется выход из программы

```

<br>

________________________

### 8. Текст на ассемблере программы, полученный после компиляции программы на C. <br> ###

Файлы расширения .s есть в папке: ACS-IHW-2/codes/time-size-check/compile-c <br>

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
file_input.c <br>
file_output.c <br>
form_new_str.c <br>
random_generation.c <br>
timespec_difference.c <br>

Для линковки: <br>
`gcc -lc main.o file_input.o file_output.o random_generation.o timespec_difference.o form_new_str.o -o a.exe` <br>

Убираем макросы: <br>
endbr64, cdqe, cdq, nop <br>

Переписываем .section.data и названия меток (LC0, L1, etc.) для наглядности <br>

Убираем лишние присваивания: вместо  <br>
`mov	rax, QWORD PTR -8[rbp]` <br>
`mov	rdi, rax` <br>
сразу пишем <br>
`mov	rdi, QWORD PTR -8[rbp]` <br>

Критерий на 4. <br>

1. Приведено решение задачи на Си (см. п.6. Исходные тексты программы на языке C)
2. В полученный ассемблер добавлены поясняющие комментарии (см. п.7. Тексты программы на языке ассемблера)
3. Из ассемблерной программы убраны лишние макросы (`endbr64, cdqe, cdq, nop`)
4. Модифицированный ассемблер отдельно откомпилирован и скомпонован без использования опций отладки (`gcc ./main.s -c -o ./main.o`)
5. Представлено полное тестовое покрытие (см. п.4-5 Тесты и результаты прогонов)

Критерий на 5. <br>

1. Использованы функции с передачей данных через параметры (`call fputc@PLT`)
2. Использованы локальные переменные
3. В комментариях к ассемблеру описана передача параметров и получение возвращаемого значения
4. В комментариях к ассемблеру описаны аналоги вызовов функций в Си

Критерий на 6. <br>

1. Использования регистров процессора для хранения переменных не на стеке (`r8-r15(d)`)
2. Комментарии поясняют использование регистров
3. Представлены тестовые прогоны (см. п.4-5 Тесты и результаты прогонов)
4. Представлено сравнение результатов скомпилированной программы и измененной (см. критерий на 9)

Критерий на 7. <br>

1. Реализация программы на Си и ассемблере в виде 6 единиц компиляции
2. Использование файлов для ввода и вывода данных (для ввода с файла необходимо выбрать опцию 2 в командной строке; вывод осуществляется и в консоль, и в файл)
3. Представлены файлы с тестами (ACS-IHW-2/tests)

Критерий на 8. <br>

1. Использование генерации исходной строки (псевдослучайной). Программа генерирует случайную строку, если в качестве `option` подавался символ, отличный от 1 или 2 (но не NULL)
2. Выбор ввода с консоли, файла или генерации данных через аргументы командной строки
3. Использование замеров времени формирования новой строки между вводом и выводом данных с помощью `clock_gettime`

Критерий на 9. <br>
Для оптимизации по скорости все части программы компилировались с флагом -O3. <br>
Для оптимизации по размеру все части программы компилировались с флагом -Os. <br>

Таблица сравнений приведена ниже: <br>
| Критерий	     	| Скомпилированный Си| С оптим. -O3	   | С оптим. -Os        | Отредактированный вручную после компиляции |       
| ----------------------|:------------------:| :------------------:|:-------------------:|:------------------------------------------:|
| размер асм-файла	| 12 588 байт        | 12 257 байт         | 10 720 байт         | - байт                               |
| размер испол. файла	| 17 120 байт        | 17 240 байт         | 17 192 байт         | - байт                                |
| время работы		| 738 438.1 ns       | 427 981.7 ns        | 326 355.1 ns        | - ns                               |
<br>
// размер асм-файла == размер 6 файлов расширения .s (из папки time-size-check), исполняемый файл в этой же папке <br>
// время работы == усреднённое время работы 10 запусков псевдослучаного генератора (т.к. большой размер данных) <br>
// программа, отредактированная вручную (из папки edited-asm-code) <br>

Результаты 10 замеров генератора <br>

Скомп. Си: <br>
533317
1096175
1208028
1049533
280498
701592
1007358
1057301
200140
250439
<br>

Скомп. Си c option: -O3 <br>
181253
482087
573459
528316
227937
522753
672271
523038
41172
527531
<br>

Скомп. Си c option: -Os <br>
445427
635534
459203
488791
234542
150897
213529
75841
227566
332221
<br>

Скомп. Си c правками <br>

<br>


По времени самый выгодный: с -Os <br>
По размеру файлов асм: с -Os <br>
По размеру файла исполняемого: обычный компил с Си (но выигравает он не сильно) <br>
<br>

#  ИДЗ №2 #
## Markdown report <br> ##

### 1. Ганина Ксения Андреевна (тг для вопросов: @kgnn47) <br> ###
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

Тесты можно посмотреть здесь: [ACS-IHW-2/tests](https://github.com/kseniag03/ACS-IHW-2/tree/main/tests) <br>

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

Можно также посмотреть здесь: [ACS-IHW-2/codes](https://github.com/kseniag03/ACS-IHW-2/tree/main/codes) <br>

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

[main](https://github.com/kseniag03/ACS-IHW-2/blob/main/codes/edited-asm-code/main.s) <br>
[file_input](https://github.com/kseniag03/ACS-IHW-2/blob/main/codes/edited-asm-code/file_input.s) <br>
[file_output](https://github.com/kseniag03/ACS-IHW-2/blob/main/codes/edited-asm-code/file_output.s) <br>
[random_generation](https://github.com/kseniag03/ACS-IHW-2/blob/main/codes/edited-asm-code/random_generation.s) <br>
[timespec_difference](https://github.com/kseniag03/ACS-IHW-2/blob/main/codes/edited-asm-code/timespec_difference.s) <br>
[form_new_str](https://github.com/kseniag03/ACS-IHW-2/blob/main/codes/edited-asm-code/form_new_str.s) <br>

main.s

```assembly
.intel_syntax noprefix				# intel-синтаксис
.globl main					# точка запуска main
.type main, @function				# объявление main как функции

.globl	SIZEMAX					# объявление глобальной константы
.globl	VALUEMAX				# объявление глобальной константы

.section .data					# секция объявления переменных 
	SIZEMAX:	.long		100000
	VALUEMAX:	.long		128
	noArg:		.string		"No arguments\n"
	showArg:	.string		"arg = %s\n"
	inputFileName:	.string		"input.txt"
	outputFileName:	.string		"output.txt"
	inputData:	.string		"Input: %s\n"
	outputData:	.string		"Output: %s\n"
	elapsed:	.string		"Elapsed: %ld ns\n"

.text						# секция кода

main:
	push	rbp				# сохраняем rbp на стек
	mov	rbp, rsp			# присваиваем rbp = rsp
	sub	rsp, 100096

	mov	DWORD PTR -100084[rbp], edi	# 1-й аргумент main — argc (в стеке на -100084)
	mov	QWORD PTR -100096[rbp], rsi	# 2-й аргумент main — argv (в стеке на -100096)

	mov	eax, 100000			# eax = 100000
	mov	rdi, rax			# 1-й аргумент — 100000
	call	malloc@PLT			# выделяем память под строку (str = (char*)malloc(SIZEMAX))

	mov	QWORD PTR -8[rbp], rax		# char *str (в стеке на -8)
	cmp	DWORD PTR -100084[rbp], 1	# сравнение argc с 1
	jle	.NOARGS				# если argc <= 1, переходим к метке NOARGS

	mov	rax, QWORD PTR -100096[rbp]	# rax = argv
	mov	rax, QWORD PTR 8[rax]		# rax = argv[0]
	mov	r12, rax			# arg = argv[0], локальную переменную записываем в свободный регистр r12
	
	lea	rdi, showArg[rip]		# 1-й аргумент — "arg = %s\n"
	mov	rsi, r12			# 2-й аргумент — arg = argv[0]
	call	printf@PLT			# printf("arg = %s\n", arg)

	mov	rdi, r12			# 1-й аргумент — arg
	call	atoi@PLT			# atoi(arg)

	mov	r13d, eax			# option = atoi(arg) (в свободном регистре r13d, double word)
	cmp	r13d, 1				# сравнение option с 1
	jne	.FILEINPUT			# если не равен 1, переходим к файловому выводу (метка FILEINPUT)

	mov	rdi, QWORD PTR -8[rbp]		# 1-й аргумент — str
	mov	esi, 100000			# 2-й аргумент — 100000
	mov	rdx, QWORD PTR stdin[rip]	# 3-й аргумент — stdin (поток ввода)
	call	fgets@PLT			# вывод с консоли: fgets(str, SIZEMAX, stdin)

	jmp	.DOTASK				# переход к метке DOTASK

.FILEINPUT:
	cmp	r13d, 2				# сравнение option с 2
	jne	.RANDOM				# если не равен 2, переходим к псевдослучайной генерации данных (метка RANDOM)

	mov	rdi, QWORD PTR -8[rbp]		# 1-й аргумент — str
	lea	rsi, inputFileName[rip]		# 2-й аргумент — "input.txt"
	call	file_input@PLT			# file_input(str, "input.txt")

	test	eax, eax			# проверяем, что file_input(str, "input.txt") завершается без ошибок (с кодом 0)
	je	.DOTASK				# если равно 0, переход к метке DOTASK

	mov	eax, 1				# return 1
	jmp	.EXIT				# переход к выходу из программы

.RANDOM:
	mov	rdi, QWORD PTR -8[rbp]		# 1-й аргумент — str
	call	random_generation@PLT		# random_generation(str)

	jmp	.DOTASK				# переход к метке DOTASK

.NOARGS:
	lea	rdi, noArg[rip]			# 1-й аргумент — "No arguments\n"
	call	printf@PLT			# printf("No arguments\n")

	mov	eax, 0				# return 0
	jmp	.EXIT				# переход к выходу из программы

.DOTASK:
	lea	rdi, inputData[rip]		# 1-й аргумент — "Input: %s\n"
	mov	rsi, QWORD PTR -8[rbp]		# 2-й аргумент — str
	call	printf@PLT			# printf("Input: %s\n", str)

	mov	edi, 1				# 1-й аргумент для запуска счётчика — 1 (CLOCK_MONOTONIC)
	lea	rsi, -64[rbp]			# 2-й аргумент для запуска счётчика — &start
	call	clock_gettime@PLT		# вызов функции подсчёта времени до формирования строки, т.е. clock_gettime(CLOCK_MONOTONIC, &start)

	mov	r15, QWORD PTR -8[rbp]		# pStr = str, локальную переменную записываем в свободный регистр r15
	mov	QWORD PTR -100080[rbp], 0	# char ans[100000] = ""

	lea	rdi, -100064[rbp]		# 1-й аргумент — указатель на заполняемый массив ans (-100080 + 16 = -100064 (qword))
	mov	esi, 0				# 2-й аргумент — 0 (код символа для заполнения)
	mov	edx, 99984			# 3-й аргумент — 99984 (размер заполняемой части массива в байтах)
	call	memset@PLT			# memset (ans, 0, 99984) — заполнение массива

	mov	rdi, r15			# 1-й аргумент — pStr
	lea	rsi, -100080[rbp]		# 2-й аргумент — ans
	call	form_new_str@PLT		# form_new_str(pStr, ans)

	mov	edi, 1				# 1-й аргумент для запуска счётчика — 1 (CLOCK_MONOTONIC)
	lea	rsi, -80[rbp]			# 2-й аргумент для запуска счётчика — &end
	call	clock_gettime@PLT		# вызов функции подсчёта времени до вывода, т.е. clock_gettime(CLOCK_MONOTONIC, &end)

	mov	rdi, QWORD PTR -80[rbp]		# 1-й аргумент для подсчёта времени — end.tv_sec
	mov	rsi, QWORD PTR -72[rbp]		# 2-й аргумент для подсчёта времени — end.tv_nsec
	mov	rdx, QWORD PTR -64[rbp]		# 3-й аргумент для подсчёта времени — start.tv_sec
	mov	rcx, QWORD PTR -56[rbp]		# 4-й аргумент для подсчёта времени — start.tv_nsec
	call	timespec_difference@PLT		# вызов функции для вычисления времени выполнения задания, т.е. timespec_difference(end, start) (4 аргумента, т.к. передаются структуры с 2-мя полями)
	mov	r14, rax			# elapsed_ns = rax (результат выполнения функции timespec_difference), локальную переменную записываем в свободный регистр r14

	lea	rdi, elapsed[rip]		# 1-й аргумент — "Elapsed: %ld ns\n"
	mov	rsi, r14			# 2-й аргумент — elapsed_ns
	call	printf@PLT			# printf("Elapsed: %ld ns\n", elapsed_ns)

	lea	rdi, outputData[rip]		# 1-й аргумент — "Output: %s\n"
	lea	rsi, -100080[rbp]		# 2-й аргумент — ans
	call	printf@PLT			# printf("Output: %s\n", ans)

	lea	rdi, -100080[rbp]		# 1-й аргумент — ans
	lea	rsi, outputFileName[rip]	# 2-й аргумент — "output.txt"
	call	file_output@PLT			# file_output(ans, "output.txt")

	mov	eax, 0				# return 0

.EXIT:
	leave					# освобождает стек на выходе из функции
	ret					# выполняется выход из программы

```
<br>

file_input.s

```assembly
.intel_syntax noprefix				# intel-синтаксис
.globl file_input				# точка запуска file_input
.type file_input, @function			# объявление file_input как функции

.section .data					# секция объявления переменных
	readFile:	.string		"r"
	notOpenFile:	.string		"Unable to open file '%s'\n"

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
.intel_syntax noprefix				# intel-синтаксис
.globl form_new_str				# точка запуска form_new_str
.type form_new_str, @function			# объявление form_new_str как функции

.text						# секция кода

form_new_str:
	push	rbp				# сохраняем rbp на стек
	mov	rbp, rsp			# присваиваем rbp = rsp
	sub	rsp, 274			# выделяем память на стеке

	mov	r12, rdi			# 1-й аргумент — char *pStr (в свободном регистре r12)
	mov	r13, rsi			# 2-й аргумент — char ans[] (в свободном регистре r13)

	mov	r14w, 0				# short isNumber = 0
	mov	r15w, 0				# short isNegative = 0

	mov	QWORD PTR -272[rbp], 0		# char tmp[256] = "" (на стеке выделена память под временную строку)

	jmp	.TOLOOP				# переход к метке TOLOOP

.LOOP:
	mov	rax, r12			# rax = r12
	movzx	eax, BYTE PTR [rax]		# в eax записываем текущий символ *pStr (байтовый)
	cmp	al, 45				# сравниваем текущий символ (al — байтовый регистр) с 45-м кодом ('-')
	jne	.ADDDIGIT			# если не найден минус, переход к метке ADDDIGIT

	mov	rax, r12			# rax = r12
	add	rax, 1				# rax = pStr + 1
	movzx	eax, BYTE PTR [rax]		# в eax записываем следующий символ *(pStr + 1) (байтовый)
	cmp	al, 47				# сравниваем символ (al — байтовый регистр) с 47-м кодом (c 48-го начинаются цифры)
	jle	.ADDDIGIT			# если меньше или равен 47 (не цифры), переход к метке ADDDIGIT

	mov	rax, r12
	add	rax, 1				# rax = pStr + 1
	movzx	eax, BYTE PTR [rax]		# в eax записываем следующий символ *(pStr + 1) (байтовый)
	cmp	al, 57				# сравниваем символ (al — байтовый регистр) с 57-м кодом (c 58-го заканчиваются цифры)
	jg	.ADDDIGIT			# если больше 57 (не цифры), переход к метке ADDDIGIT

	mov	r15w, 1				# найдено отрицательное число (isNegative = 1)

.ADDDIGIT:
	mov	rax, r12			# rax = r12
	movzx	eax, BYTE PTR [rax]		# в eax записываем текущий символ *pStr (байтовый)		
	cmp	al, 47				# сравниваем символ (al — байтовый регистр) с 47-м кодом (c 48-го начинаются цифры)			
	jle	.CHECKDIGIT			# если меньше или равен 47 (не цифры), переход к метке CHECKDIGIT				

	mov	rax, r12			# rax = r12		
	movzx	eax, BYTE PTR [rax]		# в eax записываем текущий символ *pStr (байтовый)
	cmp	al, 57				# сравниваем символ (al — байтовый регистр) с 57-м кодом (c 58-го заканчиваются цифры)
	jg	.CHECKDIGIT			# если больше 57 (не цифры), переход к метке CHECKDIGIT

	mov	r14w, 1				# найдено число (isNumber = 1)
	mov	rax, r12			# rax = r12
	movzx	eax, BYTE PTR [rax]		# в eax записываем текущий символ *pStr (байтовый)
	mov	BYTE PTR -274[rbp], al		# cToStr[0] = *pStr
	mov	BYTE PTR -273[rbp], 0		# cToStr[1] = '\0'

	lea	rdi, -272[rbp]			# 1-й аргумент — tmp
	lea	rsi, -274[rbp]			# 2-й аргумент — cToStr
	call	strcat@PLT			# вызов функции strcat(tmp, cToStr)

	jmp	.NEXTSYM			# переход к метке NEXTSYM

.CHECKDIGIT:
	cmp	r14w, 0				# проверяем, храним ли число (if (isNumber == 0)) 
	je	.NEXTSYM			# если не число, переход к метке NEXTSYM

	mov	r14w, 0				# isNumber = 0 (обнуляем флаг)
	jmp	.CHECKINSIGNZEROS		# переход к метке CHECKINSIGNZEROS

.DELINSIGNZEROS:
	lea	rdi, -272[rbp]			# 1-й аргумент — tmp
	call	strlen@PLT			# вызов strlen(tmp)

	mov	rdx, rax			# rdx = rax = strlen(tmp) (3-й аргумент)
	lea	rax, -272[rbp]			# rax = tmp
	add	rax, 1				# rax = tmp + 1

	lea	rdi, -272[rbp]			# rdi = tmp (1-й аргумент)
	mov	rsi, rax			# rsi = rax = tmp + 1 (2-й аргумент)
	call	memmove@PLT			# memmove(tmp, tmp + 1, strlen(tmp))

.CHECKINSIGNZEROS:
	movzx	eax, BYTE PTR -272[rbp]		# в eax записываем tmp[0]
	cmp	al, 48				# сравниаем код символа с 48 (код '0')
	jne	.CHECKNEGATIVE			# если цифра не равна нулю, переход к метке CHECKNEGATIVE

	lea	rdi, -272[rbp]			# 1-й аргумент — tmp
	call	strlen@PLT			# вызов strlen(tmp)

	cmp	rax, 1				# сравниваем длину текущей временной строки с 1
	ja	.DELINSIGNZEROS			# если длина (беззнаковая) > 1, переход к метке DELINSIGNZEROS

.CHECKNEGATIVE:
	cmp	r15w, 0				# проверяем, отрицательное ли число (if (isNegative == 0))
	je	.TMPTOANS			# если не отрицательное, переходим к метке TMPTOANS

	movzx	eax, BYTE PTR -272[rbp]		# в eax записываем tmp[0]
	cmp	al, 48				# сравниаем код символа с 48 (код '0')
	jne	.ADDBRACKETS			# если цифра не равна нулю, переход к метке ADDBRACKETS

	lea	rdi, -272[rbp]			# 1-й аргумент — tmp
	call	strlen@PLT			# вызов strlen(tmp)

	cmp	rax, 1				# сравниваем длину текущей временной строки с 1
	ja	.DELINSIGNZEROS			# если длина (беззнаковая) > 1, переход к метке

.ADDBRACKETS:
	lea	rdi, -272[rbp]			# 1-й аргумент — tmp
	call	strlen@PLT			# вызов strlen(tmp)

	lea	rdx, 1[rax]			# rdx = strlen(tmp) + 1 (3-й аргумент)
	lea	rax, -272[rbp]			# rax = tmp
	add	rax, 1				# rax = tmp + 1

	mov	rdi, rax			# rdi = rax = tmp + 1 (1-й аргумент)
	lea	rsi, -272[rbp]			# rsi = tmp (2-й аргумент)
	call	memmove@PLT			# вызов memmove(tmp + 1, tmp, strlen(tmp) + 1)

	mov	BYTE PTR -272[rbp], 45		# tmp[0] = '-' (45 — код '-')

	lea	rdi, -272[rbp]			# 1-й аргумент — tmp
	call	strlen@PLT			# вызов strlen(tmp)

	lea	rdx, 1[rax]			# rdx = strlen(tmp) + 1 (3-й аргумент)
	lea	rax, -272[rbp]			# rax = tmp
	add	rax, 1				# rax = tmp + 1

	mov	rdi, rax			# rdi = rax = tmp + 1 (1-й аргумент)
	lea	rsi, -272[rbp]			# rsi = tmp (2-й аргумент)

	call	memmove@PLT			# вызов memmove(tmp + 1, tmp, strlen(tmp) + 1)

	mov	BYTE PTR -272[rbp], 40		# tmp[0] = '(' (40 — код '(') 

	lea	rdi, -272[rbp]			# 1-й аргумент — tmp
	call	strlen@PLT			# вызов strlen(tmp)

	mov	rdx, rax			# rdx = rax = strlen(tmp)
	lea	rax, -272[rbp]			# rax = tmp
	add	rax, rdx			# rax = tmp + strlen(tmp)
	mov	WORD PTR [rax], 41		# tmp[strlen(tmp)] = ')' (или strcat(tmp, ")")) (41 — код ')')

.TMPTOANS:
	mov	rdi, r13			# 1-й аргумент — ans
	lea	rsi, -272[rbp]			# 2-й аргумент — tmp
	call	strcat@PLT			# strcat(ans, tmp)

	mov	rdi, r13			# 1-й аргумент — ans
	call	strlen@PLT			# вызов strlen(ans)

	mov	rdx, rax			# rdx = rax = strlen(ans)
	mov	rax, r13			# rax = ans
	add	rax, rdx			# rax = ans + strlen(ans)
	mov	WORD PTR [rax], 43		# ans[strlen(ans)] = '+' (или strcat(ans, "+")) (43 — код '+')
	mov	BYTE PTR -272[rbp], 0		# tmp[0] = '\0'
	mov	r15w, 0				# isNegative = 0

.NEXTSYM:
	add	r12, 1				# ++pStr

.TOLOOP:
	mov	rax, r12			# rax = r12
	movzx	eax, BYTE PTR [rax]		# в eax записываем текущий символ *pStr (байтовый)
	test	al, al				# проверка, что while (*pStr) == 0
	jne	.LOOP				# переход к метке LOOP, если while (*pStr) != 0

	cmp	r14w, 0				# иначе выходим из цикла и проверяем, храним ли число (if (isNumber == 0))  
	je	.ENDANS				# если не число, переход к метке ENDANS

	mov	rdi, r13			# 1-й аргумент — ans
	lea	rsi, -272[rbp]			# 2-й аргумент — tmp
	call	strcat@PLT			# вызов strcat(ans, tmp)

	mov	rdi, r13			# 1-й аргумент — ans
	call	strlen@PLT			# вызов strlen(ans)

	mov	rdx, rax			# rdx = rax = strlen(ans)
	mov	rax, r13			# rax = ans
	add	rax, rdx			# rax = ans + strlen(ans)
	mov	WORD PTR [rax], 43		# ans[strlen(ans)] = '+' (или strcat(ans, "+")) (43 — код '+')

	mov	BYTE PTR -272[rbp], 0		# tmp[0] = '\0'

.ENDANS:
	mov	rdi, r13			# 1-й аргумент — ans
	call	strlen@PLT			# вызов strlen(ans)

	lea	rdx, -1[rax]			# rdx = strlen(ans) - 1
	mov	rax, r13			# rax = ans
	add	rax, rdx			# rax = ans + strlen(ans) - 1
	mov	BYTE PTR [rax], 0		# ans[strlen(ans) - 1] = '\0' (убираем лишний плюс с конца)

	leave					# освобождает стек на выходе из функции
	ret					# выполняется выход из программы

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

[main](https://github.com/kseniag03/ACS-IHW-2/blob/main/codes/time-size-check/compile-c/main.s) <br>
[file_input](https://github.com/kseniag03/ACS-IHW-2/blob/main/codes/time-size-check/compile-c/file_input.s) <br>
[file_output](https://github.com/kseniag03/ACS-IHW-2/blob/main/codes/time-size-check/compile-c/file_output.s) <br>
[random_generation](https://github.com/kseniag03/ACS-IHW-2/blob/main/codes/time-size-check/compile-c/random_generation.s) <br>
[timespec_difference](https://github.com/kseniag03/ACS-IHW-2/blob/main/codes/time-size-check/compile-c/timespec_difference.s) <br>
[form_new_str](https://github.com/kseniag03/ACS-IHW-2/blob/main/codes/time-size-check/compile-c/form_new_str.s) <br>

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
endbr64, cdqe, cdq (в random_generation его оставляем, чтобы корректно выполнялось деление), nop <br>

Переписываем .section.data и названия меток (LC0, L1, etc.) для наглядности, убираем код после ret <br>

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

1. Использованы функции с передачей данных через параметры (пр. `call fputc@PLT`), передаём параметры через регистры: di — 1-й аргумент, si — 2-й аргумент, dx — 3-й аргумент, cx — 4-й аргумент (больше в рамках задания не требовалось) <br>
2. Использованы локальные переменные (из глобальных переменных были только константы, см. код main)
3. В комментариях к ассемблеру описана передача параметров и получение возвращаемого значения (описаны аргументы функции и её вызов)
4. В комментариях к ассемблеру описаны аналоги вызовов функций в Си (подписаны аналоги вызываемых функций из кода на Си)

Критерий на 6. <br>

1. Использования регистров процессора для хранения переменных не на стеке (`r8-r15(d)`) (вместо выделения памяти на стеке для локальных переменных использовались свободные регистры, память же выделялась под временную строку в form_new_str, и в main)
2. Комментарии поясняют использование регистров (см. комментарии в п.7. Тексты программы на языке ассемблера)
3. Представлены тестовые прогоны (см. п.4-5 Тесты и результаты прогонов)
4. Представлено сравнение результатов скомпилированной программы и измененной (см. критерий на 9)

Критерий на 7. <br>

1. Реализация программы на Си и ассемблере в виде 6 единиц компиляции
2. Использование файлов для ввода и вывода данных (для ввода с файла необходимо выбрать опцию 2 в командной строке; вывод осуществляется и в консоль, и в файл)
3. Представлены файлы с тестами ([ACS-IHW-2/tests](https://github.com/kseniag03/ACS-IHW-2/tree/main/tests))

Критерий на 8. <br>

1. Использование генерации исходной строки (псевдослучайной). Программа генерирует случайную строку, если в качестве `option` подавался символ, отличный от 1 или 2 (но не NULL)
2. Выбор ввода с консоли, файла или генерации данных через аргументы командной строки (ввод с консоли был необязателен к реализации, поэтому там строку можно считать только до '\n', несколько же строк можно протестировать через файлы)
3. Использование замеров времени формирования новой строки между вводом и выводом данных, реализовано с помощью `clock_gettime`

Критерий на 9. <br>

Для оптимизации по скорости все части программы компилировались с флагом -O3. <br>
Для оптимизации по размеру все части программы компилировались с флагом -Os. <br>
Также для оптимизации использовались флаги -O0, -O1, -O2, -Ofast. <br>

Таблица сравнений приведена ниже: <br>
| Критерий            | Скомпилированный Си | С оптим. -O0 | С оптим. -O1 | С оптим. -O2 | С оптим. -O3 | С оптим. -Os | С оптим. -Ofast |Отредактированный вручную |       
| --------------------|:-------------------:|:------------:|:------------:|:------------:|:------------:|:------------:|:----------------|-------------------------:|
| размер асм-файла    | 12 588 байт         | 12 900 байт  | 11 681 байт  | 12 257 байт  | 12 257 байт  | 10 720 байт  | 12 257 байт     | 28 739 байт              |
| размер испол. файла | 17 120 байт         | 17 176 байт  | 17 240 байт  | 17 240 байт  | 17 240 байт  | 17 192 байт  | 17 240 байт     | 18 264 байт              |
| время работы        | 738 438.1 ns        | 732 171.8 ns | 327 489.3 ns | 541 661.5 ns | 427 981.7 ns | 326 355.1 ns | 442 966.2 ns    | 681 949.6 ns             |
<br>

Размер асм-файла == размер 6 файлов расширения .s ([из папки time-size-check](https://github.com/kseniag03/ACS-IHW-2/tree/main/codes/time-size-check)), исполняемый файл находится в этой же папке <br>
Время работы == усреднённое время работы 10 запусков псевдослучаного генератора (т.к. большой размер данных) <br>

Результаты 10 замеров генератора: <br>

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

Скомп. Си c option: -O0 <br>
654408
943418
1117765
422462
1390688
248191
71144
1252246
21061
1200335
<br>

Скомп. Си c option: -O1 <br>
133398
139191
80068
32054
113871
316994
961773
48095
820612
628837
<br>

Скомп. Си c option: -O2 <br>
1186073
478743
215291
195074
981195
763789
1053054
413612
41477
88307
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

Скомп. Си c option: -Ofast <br>
1012247
778243
756440
286672
340966
218000
216151
516333
282161
22449
<br>

Скомп. Си c правками <br>
740856
869276
1464559
541471
1304529
396489
403311
76749
967291
54965
<br>

По времени самый выгодный: с -Os  <br>
(но обгоняет оптимизатор -O3 всего на 0,0001 секунду, а O1 чуть больше, чем на 1 нано секунду; скорее всего, при большем кол-ве замеров он будет работать медленнее) <br>
По размеру файлов асм: с -Os <br>
По размеру файла исполняемого: обычный компил с Си (но выигрывает он не сильно) <br>
Отредактированный вручную ассемблер по времени выигрывает только у скомпилированного Си примерно на 0,000056 секунды, по остальным параметрам он сильно проигрывает <br> 
// не доверяйте мне ассемблер.... <br>

![ты-чаво-наделал](https://user-images.githubusercontent.com/114473740/201527961-e06ac2b4-58bf-4172-81cf-dad9104c312d.jpg)


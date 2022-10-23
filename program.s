    # -4[rbp] -> r12d
    # -8[rbp] -> r13

    .intel_syntax noprefix         # используем синтаксис intel

	.text                          # начинает новую секцию

	.section	.rodata            # .rodata
.LC0:
	.string	"a[%d] = "             #.LC0: "%d"
.LC1:
	.string	"%d"

	.text                          # секция с кодом
	.globl	input
	.type	input, @function
input:
	push	rbp                    # / сохраняем rbp на стек
	mov	rbp, rsp                   # | rbp := rsp
	sub	rsp, 32                    # \ rsp -= 32

	mov	DWORD PTR -20[rbp], edi    # rdi - 1-й - argc
	mov	QWORD PTR -32[rbp], rsi    # rsi - 2-й - argv
	mov	r12d, 0       # i = 0
	jmp	.L2
.L3:
	mov	eax, r12d                  # eax := i
	mov	esi, eax                   # вместо esi записали eax
	lea	rax, .LC0[rip]             # rax := rip[.LC0] — наша строка "%d"
	mov	rdi, rax                   # rdi := rax
	mov	eax, 0                     # обнуляем eax
	call	printf@PLT             # вызывает функцию "printf" 

	mov	eax, r12d    # eax := i
	cdqe                          # у нас был eax, стал rax, делает sign-extend
	lea	rdx, 0[0+rax*4]           # rdx = rax*4
	mov	rax, QWORD PTR -32[rbp]   # eax := rbp[-32]
	add	rax, rdx                  # rax += rdx
	mov	rsi, rax                  # rsi := rax
	lea	rax, .LC1[rip]            # rax := rip[.LC1] — наша строка "%d"
	mov	rdi, rax                  # rdi := rax - 1 аргумент
	mov	eax, 0                    # eax := 0
	call	__isoc99_scanf@PLT    # вызов scanf
	add	r12d, 1      # rbp[-4] += 1
.L2:
	mov	eax, r12d    # eax := 'int n'
	cmp	eax, DWORD PTR -20[rbp]   # cmp 'int i' eax
	jl	.L3                       # если меньше, перейти к .L3
	nop                           # инструкция без операции
	nop                           # инструкция без операции
	leave                         # / Выход из функции
	ret                           # \
	.section	.rodata
	.align 8
.LC2:
	.string	"\320\237\320\276\320\273\321\203\321\207\320\270\320\262\321\210\320\260\321\217\321\201\321\217 \320\277\320\276\321\201\320\273\320\265\320\264\320\276\320\262\320\260\321\202\320\265\320\273\321\214\320\275\320\276\321\201\321\202\321\214: " # .LC2: "Получившаяся последовательность: "
.LC3:
	.string	"%d "                # .LC3: "%d "
    .text
	.globl	subsequence
	.type	subsequence, @function
subsequence:
	push	rbp                  # / сохраняем rbp на стек
	mov	rbp, rsp                 # | rbp := rsp
	push	rbx                  # | сохраняем rbx на стек
	sub	rsp, 72                  # \ сдвинули rsp на 72 байта
	mov	QWORD PTR -72[rbp], rdi  # rbp[-72] := rdi - 1 аргумент - argc 
	mov	DWORD PTR -76[rbp], esi  # rbp[-76] := esi - 2 аргумент - argv
	mov	rax, rsp                 # rax := rsp
	mov	rbx, rax                 # rbx := rax
	mov	DWORD PTR -20[rbp], 1    # rbp[-20] := 1 - count
	mov	DWORD PTR -24[rbp], 0    # rbp[-24] := 0 - max
	mov	DWORD PTR -28[rbp], 0    # rbp[-28] := 0 - last_elem1
	mov	DWORD PTR -32[rbp], 0    # rbp[-32] := 0 - last_elem2
	mov	DWORD PTR -36[rbp], 1    # rbp[-36] := 1 - i
	jmp	.L5                      # переход к метке .L5 - проверка условия цикла
.L9:
	mov	eax, DWORD PTR -36[rbp]  # eax := rbp[-36]
	cdqe                         # у нас был eax, стал rax, делает sign-extend
	lea	rdx, 0[0+rax*4]          # rdx := rax*4
	mov	rax, QWORD PTR -72[rbp]  # rax := rbp[-72]
	add	rax, rdx                 # rax += rdx
	mov	edx, DWORD PTR [rax]     # edx := *rax
	mov	eax, DWORD PTR -36[rbp]  # eax := -36*rbp
	cdqe                         # у нас был eax, стал rax, делает sign-extend
	sal	rax, 2                   # сдвигаем биты в rax на 2
	lea	rcx, -4[rax]             # rcx := rax[-4]
	mov	rax, QWORD PTR -72[rbp]  # rax := rbp[-72]
	add	rax, rcx                 # rax += rcx
	mov	eax, DWORD PTR [rax]     # eax := *rax
	cmp	edx, eax                 # сравнить edx и eax (счетчик цикла)
	jl	.L6                      # если меньше, перейти к .L6
	add	DWORD PTR -20[rbp], 1    # rbp[-20] += 1
	mov	eax, DWORD PTR -36[rbp]  # eax := rbp[-32]
	mov	DWORD PTR -32[rbp], eax  # rbp[-32] := eax
	jmp	.L7                      # переход к метке .L7 - увеличение счетчика в цикле
.L6:
	mov	eax, DWORD PTR -20[rbp]  # eax:=rbp[-20]
	cmp	eax, DWORD PTR -24[rbp]  # сравнить eax и rbp[-24] - цикл, где сравниваются count и msx
	jle	.L8                      # если eax > rbp[-24], переходим к .L8
	mov	eax, DWORD PTR -20[rbp]  # eax:=rbp[-20]
	mov	DWORD PTR -24[rbp], eax  # rbp[-24] := eax
	mov	eax, DWORD PTR -32[rbp]  # eax:=rbp[-32]
	mov	DWORD PTR -28[rbp], eax  # rbp[-28] := eax
.L8:
	mov	DWORD PTR -20[rbp], 1    # count := 1
.L7:
	add	DWORD PTR -36[rbp], 1    # i := 1
.L5:
	mov	eax, DWORD PTR -36[rbp]  # eax := rbp[-36]
	cmp	eax, DWORD PTR -76[rbp]  # сравнить eax и rbp[-76] (счетчик цикла)
	jl	.L9                      # если меньше, перейти к .L9
	cmp	DWORD PTR -24[rbp], 0    # сравнить rbp[-24] и 0
	jne	.L10                     # если rbp[-24] = 0, переходим к .L10
	mov	eax, DWORD PTR -20[rbp]  # eax := rbp[-20]
	mov	DWORD PTR -24[rbp], eax  # rbp[-24] := eax
	mov	eax, DWORD PTR -32[rbp]  # eax := rbp[-32]
	mov	DWORD PTR -28[rbp], eax  # rbp[-28] := eax
.L10:
	mov	eax, DWORD PTR -24[rbp]  # /eax := rbp[-24]
	movsx	rdx, eax             # |rdx := eax с сохранением знака
	sub	rdx, 1                   # \ сдвинули rdx на 1 байт
	mov	QWORD PTR -56[rbp], rdx  # rbp[-56] := rdx
	movsx	rdx, eax             # dx := eax с сохранением знака
	mov	r10, rdx                 # r10 := rdx
	mov	r11d, 0                  # r11d := 0
	movsx	rdx, eax             # rdx := eax с сохранением знака
	mov	r8, rdx                  # r8 := rdx
	mov	r9d, 0                   # r9d := 0
	cdqe                         # у нас был eax, стал rax, делает sign-extend
	lea	rdx, 0[0+rax*4]          # rdx := rax * 4
	mov	eax, 16                  # eax := 16
	sub	rax, 1                   # rax сдвинули на 1 байт
	add	rax, rdx                 # rax += rdx
	mov	esi, 16                  # esi := 16
	mov	edx, 0                   # edx := 0
	div	rsi                      # unsigned divide
	imul	rax, rax, 16         # signed multiply
	mov	rcx, rax                 # rcx := rax
	and	rcx, -4096               # logical and
	mov	rdx, rsp                 # rdx := rsp
	sub	rdx, rcx                 # rdx сдвинули на rcx байт
.L11:
	cmp	rsp, rdx                 # сравнить rsp и rdx
	je	.L12                     # если rsp < rdx, переходим в .L12
	sub	rsp, 4096                # rsp сдвигаем на 4096 байт
	or	QWORD PTR 4088[rsp], 0   # делает rsp[4088] - логическое и
	jmp	.L11                     # переходим в .L11
.L12:
	mov	rdx, rax                 # rdx := rax
	and	edx, 4095                # логическое и
	sub	rsp, rdx                 # rsp сдвинули на rdx байт
	mov	rdx, rax                 # rdx := rax
	and	edx, 4095                # логическое и 
	test	rdx, rdx             # логическое сравнение
	je	.L13                     # переходим в .L13
	and	eax, 4095                # логическое и
	sub	rax, 8                   # rax сдвинули на 8 байт
	add	rax, rsp                 # rax += rsp
	or	QWORD PTR [rax], 0       # логическое или
.L13:
	mov	rax, rsp                 # rax := rsp
	add	rax, 3                   # rax += 3
	shr	rax, 2                   # shift
	sal	rax, 2                   # shift
	mov	QWORD PTR -64[rbp], rax  # rbp[-64] := rax
	mov	DWORD PTR -40[rbp], 0    # rbp[-40] := 0
	mov	eax, DWORD PTR -28[rbp]  # eax := rbp[-24]
	sub	eax, DWORD PTR -24[rbp]  # eax сдвинули на rbp[-24]
	add	eax, 1                   # eax += 1
	mov	DWORD PTR -44[rbp], eax  # rbp[-44] := eax
	jmp	.L14                     # переходим в .L14
.L15:
	mov	eax, DWORD PTR -44[rbp]  # eax := rbp[-44]
	cdqe                         # у нас был eax, стал rax, делает sign-extend
	lea	rdx, 0[0+rax*4]          # rdx := rax*4
	mov	rax, QWORD PTR -72[rbp]  # rax := rbp[-72]
	add	rax, rdx                 # rax += rdx
	mov	ecx, DWORD PTR [rax]     # ecx := rax
	mov	rax, QWORD PTR -64[rbp]  # rax := rbp[-64]
	mov	edx, DWORD PTR -40[rbp]  # edx := rbp[-40]
	movsx	rdx, edx             # rdx := edx с сохранением знака
	mov	DWORD PTR [rax+rdx*4], ecx  # rax+rdx*4 := ecx
	add	DWORD PTR -40[rbp], 1    # rbp[-40] += 1
	add	DWORD PTR -44[rbp], 1    # rbp[-44] += 1
.L14:
	mov	eax, DWORD PTR -28[rbp]  # eax := rbp[-28]
	cmp	eax, DWORD PTR -44[rbp]  # сравнить eax и rbp[-44]
	jge	.L15                     # переходим в .L15
	lea	rax, .LC2[rip]           # rax := rip[.LC2] ("Получившаяся последовательность: ")
	mov	rdi, rax                 # rdi := rax
	mov	eax, 0                   # eax := 0
	call	printf@PLT           # вызов printf
	mov	DWORD PTR -48[rbp], 0    # rbp[-48] := 0
	jmp	.L16                     # переходим в .L16
.L17:
	mov	rax, QWORD PTR -64[rbp]  # rax := rbp[-64]
	mov	edx, DWORD PTR -48[rbp]  # edx := rbp[-48]
	movsx	rdx, edx             # rdx := edx с сохранением знака
	mov	eax, DWORD PTR [rax+rdx*4] # eax := rax+rdx*4
	mov	esi, eax                 # esi := eax
	lea	rax, .LC3[rip]           # rax := rip[.LC3] ("%d ")
	mov	rdi, rax                 # rdi := rax
	mov	eax, 0                   # eax := 0
	call	printf@PLT           # вызов printf
	add	DWORD PTR -48[rbp], 1    # rbp[-48] += 1
.L16:
	mov	eax, DWORD PTR -48[rbp]  # eax := rbp[-48]
	cmp	eax, DWORD PTR -24[rbp]  # сравнить eax и rbp[-24]
	jl	.L17                     # если eax < rbp[-24], идем в .L17
	mov	rsp, rbx                 # rsp := rbx
	nop                          # инструкция без операции
	mov	rbx, r13  # rbx := rbp[-8]
	leave                        # / Выход из функции
	ret                          # \
    .size	subsequence, .-subsequence
	.section	.rodata
	.align 8

.LC4:
	.string	"\320\222\320\262\320\265\320\264\320\270\321\202\320\265 \321\200\320\260\320\267\320\274\320\265\321\200 \320\274\320\260\321\201\321\201\320\270\320\262\320\260=" # .LC4: "Введите размер массива="
    .text
	.globl	main
	.type	main, @function
main:
	push	rbp                       # сохраняем rbp на стек
	mov	rbp, rsp                      # rbp := rsp
	push	r15                       # сохраняем r15 на стек
	push	r14                       # сохраняем r14 на стек
	push	r13                       # сохраняем r13 на стек
	push	r12                       # сохраняем r12 на стек
	push	rbx                       # сохраняем rbx на стек
	sub	rsp, 40                       # сдвинули rsp на 40 байт
	mov	rax, rsp                      # rax:=rsp
	mov	rbx, rax                      # rbx:=rax
	lea	rax, .LC4[rip]                # rax += rip[.LC4]
	mov	rdi, rax                      # rdi:=rax
	mov	eax, 0                        # eax:=0
	call	printf@PLT                # вызов printf
	lea	rax, -68[rbp]                 # rax := -68 на стеке (Это наш N)
	mov	rsi, rax                      # rsi := rax

	lea	rax, .LC1[rip]                # rax += rip[.LC1]
	mov	rdi, rax                      # rdi := rax
	mov	eax, 0                        # eax := 0
	call	__isoc99_scanf@PLT        # вызов scanf
	mov	eax, DWORD PTR -68[rbp]       # eax := rbp[-68] - это обозначение того, что мы имеем дело с массивом типа int
	movsx	rdx, eax                  # rdx := eax с сохранением знака
	sub	rdx, 1                        # сдвинули rdx на 1 байт
	mov	QWORD PTR -56[rbp], rdx       # rbp[-68] := rdx
	movsx	rdx, eax                  # rdx := eax с сохранением знака
	mov	r14, rdx                      # r14 := rdx
	mov	r15d, 0                       # r15d := 0
	movsx	rdx, eax                  # rdx := eax с сохранением знака
	mov	r12, rdx                      # r12:=rdx
	mov	r13d, 0                       # r13d := 0
	cdqe                              # у нас был eax, стал rax, делает sign-extend
	lea	rdx, 0[0+rax*4]               # rdx += rax*4
	mov	eax, 16                       # eax := 16
	sub	rax, 1                        # rax сдвинули на 1 байт
	add	rax, rdx                      # rax += rdx
	mov	esi, 16                       # esi := 16
	mov	edx, 0                        # edx := 0
	div	rsi                           # деление rsi
	imul	rax, rax, 16              # умножение
	mov	rcx, rax                      # rcx := rax
	and	rcx, -4096                    # логическое и
	mov	rdx, rsp                      # rdx := rcx
	sub	rdx, rcx                      # сдвинули rdx на rcx байт
.L19:
	cmp	rsp, rdx                      # сравнили rsp и rdx
	je	.L20                          # переход к .L20
	sub	rsp, 4096                     # сдвинули rsp на 4096 байт
	or	QWORD PTR 4088[rsp], 0        # логическое или
	jmp	.L19                          # переход к .L19
.L20:
	mov	rdx, rax                      # rdx := rax
	and	edx, 4095                     # логическое и
	sub	rsp, rdx                      # сдвинули rsp на rdx байт
	mov	rdx, rax                      # rdx := rax
	and	edx, 4095                     # логическое и
	test	rdx, rdx                  # логическое сравнение
	je	.L21                          # переход к .L21
	and	eax, 4095                     # логическое и
	sub	rax, 8                        # сдвинули rax на 8 байт
	add	rax, rsp                      # rax += rsp
	or	QWORD PTR [rax], 0            # логическое или
.L21:
	mov	rax, rsp                      # rax := rsp
	add	rax, 3                        # rax += 3
	shr	rax, 2                        # shift
	sal	rax, 2                        # shift
	mov	QWORD PTR -64[rbp], rax       # rbp[-64]:=rax
	mov	eax, DWORD PTR -68[rbp]       # eax := rbp[-68]
	mov	rdx, QWORD PTR -64[rbp]       # rdx := rbp[-64]
	mov	rsi, rdx                      # rsi := rdx
	mov	edi, eax                      # edi := eax
	call	input                     # вызов input, передаем туда n и массив a[n]

	mov	edx, DWORD PTR -68[rbp]       # edx := rbp[-68]
	mov	rax, QWORD PTR -64[rbp]       # rax := rbp[-64]
	mov	esi, edx                      # esi := edx
	mov	rdi, rax                      # rdi := rax
	call	subsequence               # вызов subsequence, передаем туда массив a[n] и n
	mov	rsp, rbx                      # rsp := rbx
              
	nop                               # инструкция без операции
	lea	rsp, -40[rbp]                 # rsp := rbp[-40]
	pop	rbx                           # удаляем rbx из стека
	pop	r12                           # удаляем r12 из стека
	pop	r13                           # удаляем r13 из стека
	pop	r14                           # удаляем r14 из стека
	pop	r15                           # удаляем r15 из стека
	pop	rbp                           # удаляем rbp из стека
	ret                               # выход
    .size	main, .-main

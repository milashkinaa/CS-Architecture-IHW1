# __Алёшкина Милана Вадимовна, БПИ216__

__Вариант 28. Условие задачи:__ Сформировать массив B из элементов массива A, которые образуют неубывающую последовательность. Неубывающей последовательностью считать элементы идущие подряд, которые равны между собой или каждый последующий больше предыдущего.

[__Программа на Си__](https://github.com/milashkinaa/CS-Architecture-IHW1/blob/main/program.c) 

[__Код на ассемблере с комментариями__](https://github.com/milashkinaa/CS-Architecture-IHW1/blob/main/program.s)

[__Тесты собраны вот тут__](https://github.com/milashkinaa/CS-Architecture-IHW1/tree/main/tests)

__А теперь ближе к делу...__

4: Написала программу на си. Скомпилировала программу в терминале. Убрала лишние макросы. Добавила тесты. Добавила комментарии к коду. 

5: В своей программе на си использовала функции с передачей параметров и локальные переменные, написала комментарии.

6: Решила использовать регистры процессора в своей программе, чтобы оптимизировать программу.
Если бегло прочитать код, можно увидеть, что r12 нигде не используется, поэтому я буду использовать вместо -4[rbp] r12d. Еще у нас нигде не используется r13, поэтому вместо -8[rbp] у меня будет r13. Тесты работают так же корректно, как и без использования макросов.

![Для душевного спокойствия](https://i.pinimg.com/564x/78/0c/16/780c163099b57e6246dbbc2a7f117da9.jpg"Для душевного спокойствия")

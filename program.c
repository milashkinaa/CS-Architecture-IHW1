#include <stdio.h>
#include <stdlib.h>
#include <time.h>

void input(int size, int* a) {
    for (int i = 0; i < size; ++i) {
        printf("a[%d] = ", i);
        scanf("%d", &a[i]); 
    }
}

void subsequence(int* a, int n) {
    int count = 1;
    int max = 0;
    int last_elem1 = 0;
    int last_elem2 = 0;
    for (int i = 1; i < n; i ++) {
        if (a[i] >= a[i - 1]) {
            count ++;
            last_elem2 = i;
        } else {
            if (count > max) {
                max = count;
                last_elem1 = last_elem2;
            }
            count = 1;
        }
    }
    if (max == 0) {
        max = count;
        last_elem1 = last_elem2;
    }
    int b[max];
    int f = 0;
    for (int i = (last_elem1 - max + 1); i < (last_elem1 + 1); ++i) {
        b[f] = a[i];
        f++;
    }
    printf("Получившаяся последовательность: ");
    for (int i = 0; i < max; ++i) {
         printf("%d ", b[i]);
    }
    
}

void main() {
    int n, l, elem, count;
    printf("Введите размер массива=");
    scanf("%d", &n);
    int a[n];
    input(n, a);
    subsequence(a, n);
}

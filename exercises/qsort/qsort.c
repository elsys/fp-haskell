#include <stdio.h>
#include <stdlib.h>

#define LENGTH(x) (sizeof(x) / sizeof((x)[0]))

int values[] = { 100,
                 10,
                 1,
                 0x80000000,
                 0x70000000, };

/**
 * Description
 *
 * The naïve number sorting function (x - y) fails for many big
 * positive and negative integers because of integer overflow.
 *
 * To understand why this happens, lets look back at 2s complement
 * arithmetic.
 *
 * 2s complement subtraction is done via normal addition with
 * the right hand operand being negated. e.g.:
 *
 *    x - y        = x + (-y)
 *
 * Negation is a two step process. First all bits are flipped and
 * then the resulting integer is summed with 1:
 *
 *    -y           = (~y) + 1
 *
 * Example:
 *  5 - 3  == 5 + (-3)
 *
 *  5 == 0101
 *  3 == 0011
 *
 * -3 == ~0011 + 0001   -> 1100
 *                         0001
 *                         ----
 *                         1101
 *
 *  5 + (-3)   ==  0101
 *                 1101
 *                 ----
 *               1|0010
 *
 *  result: 0010   == 2
 *
 *
 * Why does compare fail?
 * ----------------------
 *
 * Consider (16 bit but applies equally well to 32 bits):
 *   0x8000   ==  1000 0000 0000 0000 (binary)
 *   0x7000   ==  0111 0000 0000 0000 (binary)
 *
 *  -0x7000   ==  1000 1111 1111 1111
 *                0000 0000 0000 0001
 *                -------------------
 *                1001 0000 0000 0000
 *
 *  0x8000 + (-0x7000)    ==  1000 0000 0000 0000
 *                            1001 0000 0000 0000
 *                          1|0001 0000 0000 0000
 *                          ^
 *                          overflow
 *
 *
 * 0x1000 is a positive number! Because of the overflow, the
 * sign bit gets lost, thus (the negative) 0x8000 looks bigger
 * than (the positive) 0x7000!
 *
 * Conclusion:
 * Don't use clever tricks! Use the natural solution for the
 * problem at hand. In this case it's relational operators :)
 *
**/

int compareInt(const void *a, const void *b)
{
    return *(int *)a - *(int *)b;
}

int properCompareInt(const void *a, const void *b)
{
    int x = *(int *)a;
    int y = *(int *)b;

    return (x == y) ? 0
                    : (x > y) ? 1 : -1;
}

int main ()
{
    int n;

    printf("Bad compare:\n");
    qsort (values, LENGTH(values), sizeof(int), compareInt);

    for (n=0; n < LENGTH(values); n++) {
        printf ("%d ",values[n]);
    }
    printf("\n\n");


    printf("Good compare:\n");
    qsort (values, LENGTH(values), sizeof(int), properCompareInt);

    for (n=0; n < LENGTH(values); n++) {
        printf ("%d ",values[n]);
    }
    printf("\n\n");

    return 0;
}

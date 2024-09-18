#include <stdio.h>

#define TEN_MILLION 10000000

int main(void)
{

    double num = 0;
    for(int i=0; i <TEN_MILLION; i++)
    {
        num += i;
    }
    printf("the result of the sum is equal to %f\n", num);
    
    return 0;
}
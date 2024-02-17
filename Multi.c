#include <stdio.h>

int main() {
    int start = 1;
    int end = 100;
    double multi = 1;

    for (int i = start; i < end; i++) {
        multi *= i;
    }
    printf("%f", multi);
    return 0;
}
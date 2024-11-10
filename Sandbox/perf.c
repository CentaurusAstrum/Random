# include <stdio.h>

int main(void) {
    int counter = 0;

    while (counter < 10000000) {
        if(counter % 2 == 0) {
            printf("%d counter ist Teilbar durch 2\n", counter);
        }
        counter += 1;
    }
    printf("Done!");
    return 0;

}